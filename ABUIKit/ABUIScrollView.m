//
//  ABUIScrollView.m
//  Demo
//
//  Created by qp on 2020/5/7.
//  Copyright © 2020 ab. All rights reserved.
//

#import "ABUIScrollView.h"

@implementation ABUIScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    }
    return self;
}
@end
