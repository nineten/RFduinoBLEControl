//
//  DCMotorModuleView.h
//  RFduinoBLEControl
//
//  Created by Jayden.Ma on 28/1/15.
//
//

#import <UIKit/UIKit.h>

@interface DCMotorModuleView : UIView

@property (strong, nonatomic) IBOutlet UIView *moduleView;
@property (strong, nonatomic) IBOutlet UISlider *speedSlider;
@property (strong, nonatomic) IBOutlet UIButton *disconnectButton;

@end
