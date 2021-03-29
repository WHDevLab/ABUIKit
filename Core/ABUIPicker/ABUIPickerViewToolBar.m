//
//  ABUIPickerViewToolBar.m
//  ABUIKit
//
//  Created by qp on 2021/3/11.
//  Copyright © 2021 abteam. All rights reserved.
//

#import "ABUIPickerViewToolBar.h"
#import "UIView+AB.h"
@implementation ABUIPickerViewToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.okButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-15-80, 0, 80, 35)];
        [self.okButton setTitle:@"确定" forState:UIControlStateNormal];
        self.okButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.okButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.okButton sizeToFit];
        self.okButton.width = self.okButton.width+20;
        [self addSubview:self.okButton];
        self.okButton.left = self.frame.size.width-15-self.okButton.width;
        self.okButton.centerY = self.height/2;
    }
    return self;
}
@end
