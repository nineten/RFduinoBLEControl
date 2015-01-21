//
//  UIToggleButton.h
//  RFduinoBLEControl
//
//  Created by Jayden.Ma on 21/1/15.
//
//

#import <UIKit/UIKit.h>

@interface UIToggleButton : UIButton {
    UIColor* onBGColor;
    UIColor* offBGColor;
}

- (void)setOffBackgroundColor:(UIColor*)offColor onBGColor:(UIColor*)onColor;

@end
