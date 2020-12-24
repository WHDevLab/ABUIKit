//
//  ABUITabBarItem.m
//  ABUIKit
//
//  Created by qp on 2020/9/24.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUITabBarItem.h"
#import "UIFont+AB.h"
@implementation ABUITabBarItem
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.navColor = [UIColor whiteColor];
        self.navTitleFont = [UIFont PingFangSC:18];
    }
    return self;
}
@end
