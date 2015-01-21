//
//  MainViewController.m
//  RFduinoBLEControl
//
//  Created by Jayden.Ma on 20/1/15.
//
//

#import "MainViewController.h"

#define BUTTON_NORMAL_BG_COLOR [UIColor lightGrayColor]
#define BUTTON_HIGHLIGHTED_BG_COLOR [UIColor grayColor]
#define BUTTON_TOGGLED_BG_COLOR [UIColor darkGrayColor]
#define BUTTON_TEXT_COLOR [UIColor whiteColor]

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize bleDeviceTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [self.delegate setupCoreBluetooth];
    [self styleUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)styleUI {
    self.scanButton.layer.cornerRadius = 10;
    [self.scanButton setTiteTextColor:BUTTON_TEXT_COLOR
                normalBackgroundColor:BUTTON_NORMAL_BG_COLOR
                   highlightedBGColor:BUTTON_HIGHLIGHTED_BG_COLOR
                       toggledBGColor:BUTTON_TOGGLED_BG_COLOR];
}

- (IBAction)toggleScan:(id)sender {
    if (self.scanButton.isToggled) {
        [self.scanButton setTitle:@"Scan"];
        [self.delegate stopBLEScanning];
    } else {
        [self.scanButton setTitle:@"Stop"];
        [self.delegate startBLEScanning];
    }
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}



@end
