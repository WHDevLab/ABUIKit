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

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.mapping = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)registerClassString:(NSString *)classString native_id:(NSString *)native_id {
    [self.mapping setValue:classString forKey:native_id];
}

- (NSString *)classString:(NSString *)native_id {
    return self.mapping[native_id];
}
@end
