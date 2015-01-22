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

- (void)successfulPairing {
    NSLog(@"pairing successful");
    [self setupLEDModuleView];
}

- (void)setupLEDModuleView {
    self.ledModuleView = [[LEDModuleView alloc] initWithFrame:self.moduleView.frame];
    [self.view insertSubview:self.ledModuleView aboveSubview:self.moduleView];
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.delegate.nDevices count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"bleTableCell" forIndexPath:indexPath];
    cell.textLabel.text = [[self.delegate.nDevices objectAtIndex:indexPath.row] name];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self checkAndStopScan];
    [self.delegate connectToBLEDevice:[self.delegate.nDevices objectAtIndex:indexPath.row]];
}

- (void)refreshTable {
    [self.bleDeviceTable reloadData];
}

@end
