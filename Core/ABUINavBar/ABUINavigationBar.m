//
//  ABUINavigationBar.m
//  ABUIKit
//
//  Created by qp on 2020/11/27.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUINavigationBar.h"
@implementation ABUINavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [self addSubview:self.backButton];
        
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:self.titleLabel];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}
@end
