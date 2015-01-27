//
//  MainViewController.h
//  RFduinoBLEControl
//
//  Created by Jayden.Ma on 20/1/15.
//
//

#import <UIKit/UIKit.h>
#import "UIToggleButton.h"
#import "LEDModuleView.h"
#import "ServoModuleView.h"

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIToggleButton *scanButton;
@property (strong, nonatomic) IBOutlet UITableView *bleDeviceTable;
@property (strong, nonatomic) IBOutlet UIView *moduleView;
@property LEDModuleView* ledModuleView;
@property ServoModuleView* servoModuleView;

- (void)refreshTable;
- (void)successfulPairing:(JBLEModuleType)moduleType;

@end
