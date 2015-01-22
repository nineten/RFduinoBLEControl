//
//  LEDModuleView.m
//  RFduinoBLEControl
//
//  Created by Jayden.Ma on 22/1/15.
//
//

#import "LEDModuleView.h"

@implementation LEDModuleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"LEDModuleView" owner:self options:nil];
        [self styleUI];
    }
    return self;
}

- (void)styleUI {
    [self.ledToggleButton setTiteTextColor:BUTTON_TEXT_COLOR
                     normalBackgroundColor:BUTTON_NORMAL_BG_COLOR
                        highlightedBGColor:BUTTON_HIGHLIGHTED_BG_COLOR
                            toggledBGColor:BUTTON_TOGGLED_BG_COLOR
                                normalText:@"On"
                               toggledText:@"Off"];
}

@end
