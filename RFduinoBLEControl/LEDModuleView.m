//
//  LEDModuleView.m
//  RFduinoBLEControl
//
//  Created by Jayden.Ma on 22/1/15.
//
//

#import "LEDModuleView.h"

@implementation LEDModuleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"initialising led module view");
        [self styleUI];
        [[NSBundle mainBundle] loadNibNamed:@"LEDModuleView" owner:self options:nil];
        self.moduleView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview: self.moduleView];
        
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
