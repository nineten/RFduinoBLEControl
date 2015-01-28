//
//  DCMotorModuleView.m
//  RFduinoBLEControl
//
//  Created by Jayden.Ma on 28/1/15.
//
//

#import "DCMotorModuleView.h"

@implementation DCMotorModuleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"DCMotorModuleView" owner:self options:nil];
        [self styleUI];
        self.moduleView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview: self.moduleView];
    }
    return self;
}

- (void)styleUI {
}

@end
