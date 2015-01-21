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
    self.isToggled = false;
    
    return self;
}

- (void)setTiteTextColor: (UIColor*)textColor normalBackgroundColor:(UIColor*)normalColor highlightedBGColor:(UIColor*)highlightedColor toggledBGColor:(UIColor*)toggledColor {
    titleLabelTextColor = textColor;
    normalBGColor = normalColor;
    highlightedBGColor = highlightedColor;
    toggledBGColor = toggledColor;
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
    
    if (self.isToggled) {
        self.backgroundColor = normalBGColor;
        self.isToggled = false;
    } else {
        self.backgroundColor = toggledBGColor;
        self.isToggled = true;
    }
}

@end
