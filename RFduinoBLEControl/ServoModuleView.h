//
//  ServoModuleView.h
//  RFduinoBLEControl
//
//  Created by Jayden.Ma on 27/1/15.
//
//

#import <UIKit/UIKit.h>

@interface ServoModuleView : UIView

@property (strong, nonatomic) IBOutlet UIView *moduleView;
@property (strong, nonatomic) IBOutlet UIButton *turnLeftButton;
@property (strong, nonatomic) IBOutlet UIButton *turnRightButton;
@property (strong, nonatomic) IBOutlet UIButton *disconnectButton;

@end
