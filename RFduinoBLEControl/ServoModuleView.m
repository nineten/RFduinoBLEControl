//
//  ServoModuleView.m
//  RFduinoBLEControl
//
//  Created by Jayden.Ma on 27/1/15.
//
//

#import "ServoModuleView.h"

@implementation ServoModuleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"ServoModuleView" owner:self options:nil];
        [self styleUI];
        self.moduleView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview: self.moduleView];
    }
    return self;
}

- (void)styleUI {
}


@end
