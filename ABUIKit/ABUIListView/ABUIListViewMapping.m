//
//  ABUIListViewMapping.m
//  Demo
//
//  Created by qp on 2020/5/13.
//  Copyright © 2020 ab. All rights reserved.
//

#import "ABUIListViewMapping.h"

@implementation ABUIListViewMapping
+ (ABUIListViewMapping *)shared {
    static ABUIListViewMapping *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSString *)classString:(NSString *)native_id {
    return self.mapping[native_id];
}
@end
