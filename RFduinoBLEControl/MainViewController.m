//
//  MainViewController.m
//  RFduinoBLEControl
//
//  Created by Jayden.Ma on 20/1/15.
//
//

#import "MainViewController.h"
#import "AppDelegate.h"

@interface MainViewController ()

@property AppDelegate* delegate;
@property int speed;

@end

@implementation MainViewController

@synthesize bleDeviceTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.delegate.mainViewController = self;
    [self.delegate setupCoreBluetooth];
    [self styleUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)styleUI {
    [self.scanButton setTiteTextColor:BUTTON_TEXT_COLOR
                normalBackgroundColor:BUTTON_NORMAL_BG_COLOR
                   highlightedBGColor:BUTTON_HIGHLIGHTED_BG_COLOR
                       toggledBGColor:BUTTON_TOGGLED_BG_COLOR
                           normalText:@"Scan"
                          toggledText:@"Stop"];
    [self.bleDeviceTable setSeparatorInset:UIEdgeInsetsZero];
}

- (IBAction)toggleScan:(id)sender {
    if (self.scanButton.currentState == UIToggleButtonToggled) {
        [self stopScan];
    } else {
        [self startScan];
    }
}

- (void)stopScan {
    [self.delegate stopBLEScanning];
}

- (void)startScan {
    [self.delegate startBLEScanning];
}

- (void)checkAndStopScan {
    if (self.scanButton.currentState == UIToggleButtonToggled) {
        [self.scanButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        [self.scanButton setState:UIToggleButtonNormal];
    }
}

- (void)startPairing:(CBPeripheral*)peripheral {
    [self.delegate connectToBLEDevice:peripheral];
}

- (void)stopPairing {
    [self.delegate disconnectFromBLEDevice:self.delegate.cbperipheral];
}

- (void)successfulPairing:(JBLEModuleType)moduleType {
    NSLog(@"pairing successful");
    switch (moduleType) {
        case JBLELEDModule:
            [self setupLEDModuleView];
            break;
        case JBLEServoModule:
            [self setupServoModuleView];
            break;
        case JBLEDCMotorModule:
            [self setupDCMotorModuleView];
            break;
        default:
            break;
    }
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.delegate.jBLEDevices count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"bleTableCell" forIndexPath:indexPath];
    cell.textLabel.text = [[self.delegate.jBLEDevices objectAtIndex:indexPath.row] name];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self checkAndStopScan];
    [self startPairing:[self.delegate.jBLEDevices objectAtIndex:indexPath.row]];
}

- (void)refreshTable {
    [self.bleDeviceTable reloadData];
}

#pragma mark - LEDModule

- (void)setupLEDModuleView {
    self.ledModuleView = [[LEDModuleView alloc] initWithFrame:self.moduleView.frame];
    [self.ledModuleView.disconnectButton addTarget:self action:@selector(closeLEDModuleView) forControlEvents:UIControlEventTouchUpInside];
    [self.ledModuleView.ledToggleButton addTarget:self action:@selector(toggleLED) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:self.ledModuleView aboveSubview:self.moduleView];
}

- (void)closeLEDModuleView {
    [self stopPairing];
    [self.ledModuleView removeFromSuperview];
    self.ledModuleView = nil;
}

- (void)toggleLED {
    NSLog(@"attempting to write");
    NSData* data = nil;
    uint8_t value;
    if (self.ledModuleView.ledToggleButton.currentState == UIToggleButtonNormal) {
        value = 1;
    } else {
        value = 0;
    }
    data = [NSData dataWithBytes:&value length:sizeof(value)];
    [self.delegate.cbperipheral writeValue:data
                         forCharacteristic:self.delegate.ledModuleCharacteristic
                                      type:CBCharacteristicWriteWithoutResponse];
}

#pragma mark - ServoModule

- (void)setupServoModuleView {
    self.servoModuleView = [[ServoModuleView alloc] initWithFrame:self.moduleView.frame];
    [self.servoModuleView.disconnectButton addTarget:self action:@selector(closeServoModuleView) forControlEvents:UIControlEventTouchUpInside];
    [self.servoModuleView.turnLeftButton addTarget:self action:@selector(toggleServoLeft) forControlEvents:UIControlEventTouchUpInside];
    [self.servoModuleView.turnRightButton addTarget:self action:@selector(toggleServoRight) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:self.servoModuleView aboveSubview:self.moduleView];
}

- (void)closeServoModuleView {
    [self stopPairing];
    [self.servoModuleView removeFromSuperview];
    self.servoModuleView = nil;
}

- (void)toggleServoLeft {
    NSLog(@"attempting to write");
    NSData* data = nil;
    uint8_t value = 1;
    data = [NSData dataWithBytes:&value length:sizeof(value)];
    [self.delegate.cbperipheral writeValue:data
                         forCharacteristic:self.delegate.servoModuleCharacteristic
                                      type:CBCharacteristicWriteWithoutResponse];
}

- (void)toggleServoRight {
    NSLog(@"attempting to write");
    NSData* data = nil;
    uint8_t value = 2;
    data = [NSData dataWithBytes:&value length:sizeof(value)];
    [self.delegate.cbperipheral writeValue:data
                         forCharacteristic:self.delegate.servoModuleCharacteristic
                                      type:CBCharacteristicWriteWithoutResponse];
}

#pragma mark - DCMotorModule


- (void)setupDCMotorModuleView {
    self.speed = 0;
    self.dcMotorModuleView = [[DCMotorModuleView alloc] initWithFrame:self.moduleView.frame];
    [self.dcMotorModuleView.disconnectButton addTarget:self action:@selector(closeDCMotorModuleView) forControlEvents:UIControlEventTouchUpInside];
    [self.dcMotorModuleView.speedSlider addTarget:self action:@selector(speedSliderChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view insertSubview:self.dcMotorModuleView aboveSubview:self.moduleView];
}

- (void)closeDCMotorModuleView {
    [self stopPairing];
    [self.dcMotorModuleView removeFromSuperview];
    self.dcMotorModuleView = nil;
}

- (IBAction)speedSliderChanged:(UISlider*)sender {
    NSLog(@"attempting to write");
    if ([self isSpeedChanged:sender.value]) {
        NSData* data = nil;
        uint8_t value = self.speed + 1;
        data = [NSData dataWithBytes:&value length:sizeof(value)];
        [self.delegate.cbperipheral writeValue:data
                             forCharacteristic:self.delegate.servoModuleCharacteristic
                                          type:CBCharacteristicWriteWithoutResponse];
    }
}

- (BOOL)isSpeedChanged:(float)value {
    if (self.speed != (int)value) {
        self.speed = (int)value;
        return true;
    } else {
        return false;
    }
}


@end
