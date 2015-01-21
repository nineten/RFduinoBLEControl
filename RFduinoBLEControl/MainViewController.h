//
//  MainViewController.h
//  RFduinoBLEControl
//
//  Created by Jayden.Ma on 20/1/15.
//
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UIToggleButton.h"

@interface MainViewController : UIViewController

@property AppDelegate* delegate;
@property (strong, nonatomic) IBOutlet UIToggleButton *scanButton;

@end
