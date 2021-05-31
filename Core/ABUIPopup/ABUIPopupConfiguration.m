//
//  ABUIPopupConfiguration.m
//  ABUIKit
//
//  Created by qp on 2021/5/31.
//  Copyright © 2021 abteam. All rights reserved.
//

#import "ABUIPopupConfiguration.h"

@implementation ABUIPopupConfiguration
+ (ABUIPopupConfiguration *)shared {
    static ABUIPopupConfiguration *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

@end
