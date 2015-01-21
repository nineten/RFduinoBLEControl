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
    NSString* normalText;
    NSString* toggledText;
}

typedef NS_ENUM(int, UIToggleButtonState) {
    UIToggleButtonNormal,
    UIToggleButtonHighlighted,
    UIToggleButtonToggled
};

@property UIToggleButtonState currentState;

- (void)setTitle:(NSString *)title;
- (void)setTiteTextColor:(UIColor*)textColor normalBackgroundColor:(UIColor*)normalColor highlightedBGColor:(UIColor*)highlightedColor toggledBGColor:(UIColor*)toggledColor;
- (void)setTiteTextColor:(UIColor*)textColor normalBackgroundColor:(UIColor*)normalColor highlightedBGColor:(UIColor*)highlightedColor toggledBGColor:(UIColor*)toggledColor normalText:(NSString*)normText toggledText:(NSString*)toggText;
- (void)setState:(UIToggleButtonState)state;


@end
