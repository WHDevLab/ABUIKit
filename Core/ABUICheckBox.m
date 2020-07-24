//
//  ABUICheckBox.m
//  ABUIKit
//
//  Created by qp on 2020/7/20.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUICheckBox.h"
@interface ABUICheckBox ()
@property (nonatomic, strong) UIView *contentView;
@end
@implementation ABUICheckBox

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.borderWidth = 1;
        
        self.contentView = [[UIView alloc] initWithFrame:CGRectInset(self.bounds, 2, 2)];
        [self addSubview:self.contentView];
        
        self.contentColor = [UIColor redColor];
        self.normalBorderColor = [UIColor redColor];
        self.selectBorderColor = [UIColor redColor];
    }
    return self;
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    if (isSelected) {
        self.layer.borderColor = self.selectBorderColor.CGColor;
        self.contentView.backgroundColor = self.contentColor;
    }else{
        self.layer.borderColor = self.normalBorderColor.CGColor;
        self.contentView.backgroundColor = [UIColor clearColor];
    }
}
@end
