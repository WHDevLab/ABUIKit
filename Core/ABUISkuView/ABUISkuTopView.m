//
//  ABUISkuTopView.m
//  ABUIKit
//
//  Created by qp on 2021/1/26.
//  Copyright © 2021 abteam. All rights reserved.
//

#import "ABUISkuTopView.h"
#import "UIColor+AB.h"
@implementation ABUISkuTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
        self.imageView.backgroundColor = [UIColor hexColor:@"f6f6f6"];
        [self addSubview:self.imageView];
    }
    return self;
}
@end
