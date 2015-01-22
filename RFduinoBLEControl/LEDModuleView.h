//
//  LEDModuleView.h
//  RFduinoBLEControl
//
//  Created by Jayden.Ma on 22/1/15.
//
//

#import <UIKit/UIKit.h>
#import "UIToggleButton.h"

@interface LEDModuleView : UIView

@property (strong, nonatomic) IBOutlet UIView *moduleView;
@property (strong, nonatomic) IBOutlet UIToggleButton *ledToggleButton;
@property (strong, nonatomic) IBOutlet UIButton *disconnectButton;

@end
