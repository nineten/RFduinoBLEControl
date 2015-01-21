//
//  UIToggleButton.m
//  RFduinoBLEControl
//
//  Created by Jayden.Ma on 21/1/15.
//
//

#import "UIToggleButton.h"

@implementation UIToggleButton

- (void)setOffBackgroundColor:(UIColor*)offColor onBGColor:(UIColor*)onColor {
    onBGColor = onColor;
    offBGColor = offColor;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        self.backgroundColor = onBGColor;
    } else {
        self.backgroundColor = offBGColor;
    }
}

@end
