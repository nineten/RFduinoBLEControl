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

- (void)successfulPairing {
    NSLog(@"pairing successful");
    [self setupLEDModuleView];
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
    [self.ledModuleView.disconnectButton addTarget:self action:@selector(closeLEDmoduleView) forControlEvents:UIControlEventTouchUpInside];
    [self.ledModuleView.ledToggleButton addTarget:self action:@selector(toggleLED) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:self.ledModuleView aboveSubview:self.moduleView];
}

- (void)closeLEDmoduleView {
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

@end
