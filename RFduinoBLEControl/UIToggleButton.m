//
//  UIToggleButton.m
//  RFduinoBLEControl
//
//  Created by Jayden.Ma on 21/1/15.
//
//

#import "UIToggleButton.h"

@implementation UIToggleButton

- (instancetype)init {
    self = [super init];
    self.currentState = UIToggleButtonNormal;
    
    return self;
}

- (void)setTiteTextColor:(UIColor*)textColor
   normalBackgroundColor:(UIColor*)normalColor
      highlightedBGColor:(UIColor*)highlightedColor
          toggledBGColor:(UIColor*)toggledColor {
    titleLabelTextColor = textColor;
    normalBGColor = normalColor;
    highlightedBGColor = highlightedColor;
    toggledBGColor = toggledColor;
}

- (void)setTiteTextColor:(UIColor*)textColor
   normalBackgroundColor:(UIColor*)normalColor
      highlightedBGColor:(UIColor*)highlightedColor
          toggledBGColor:(UIColor*)toggledColor
              normalText:(NSString*)normText
             toggledText:(NSString*)toggText {
    [self setTiteTextColor:textColor
     normalBackgroundColor:normalColor
        highlightedBGColor:highlightedColor
            toggledBGColor:toggledColor];
    normalText = normText;
    toggledText = toggText;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        self.backgroundColor = highlightedBGColor;
    } else {
        self.backgroundColor = normalBGColor;
    }
}

- (void)setTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateHighlighted];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    if (self.currentState == UIToggleButtonNormal) {
        [self setState:UIToggleButtonToggled];
    } else {
        [self setState:UIToggleButtonNormal];
    }
}

- (void)setState:(UIToggleButtonState)state {
    self.currentState = state;
    switch (state) {
        case UIToggleButtonNormal:
            self.backgroundColor = normalBGColor;
            [self setTitle:normalText];
            break;
        case UIToggleButtonHighlighted:
            self.backgroundColor = highlightedBGColor;
            break;
        case UIToggleButtonToggled:
            self.backgroundColor = toggledBGColor;
            [self setTitle:toggledText];
            break;
        default:
            break;
    }
}

@end
