//
//  MainViewController.m
//  RFduinoBLEControl
//
//  Created by Jayden.Ma on 20/1/15.
//
//

#import "MainViewController.h"

#define OFF_BG_COLOR [UIColor lightGrayColor]
#define ON_BG_COLOR [UIColor grayColor]

@interface MainViewController ()

@end

@implementation MainViewController

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
    self.scanButton.layer.cornerRadius = 5;
    [self.scanButton setOffBackgroundColor:OFF_BG_COLOR onBGColor:ON_BG_COLOR];
}

- (IBAction)toggleScan:(id)sender {
    [self.delegate startBLEScanning];
}

@end
