//
//  UIToggleButton.h
//  RFduinoBLEControl
//
//  Created by Jayden.Ma on 21/1/15.
//
//

#import <UIKit/UIKit.h>

@interface UIToggleButton : UIButton {
    UIColor* normalBGColor;
    UIColor* highlightedBGColor;
    UIColor* toggledBGColor;
    UIColor* titleLabelTextColor;
}

@property BOOL isToggled;

- (void)setTiteTextColor: (UIColor*)textColor normalBackgroundColor:(UIColor*)normalColor highlightedBGColor:(UIColor*)highlightedColor toggledBGColor:(UIColor*)toggledColor;

@end
