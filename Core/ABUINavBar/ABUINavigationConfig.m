//
//  ABUINavigationConfig.m
//  ABUIKit
//
//  Created by qp on 2020/9/26.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUINavigationConfig.h"

@implementation ABUINavigationConfig
+ (ABUINavigationConfig *)shared {
    static ABUINavigationConfig *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
@end
