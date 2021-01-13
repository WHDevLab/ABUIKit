//
//  ABUIListViewStack.m
//  ABUIKit
//
//  Created by qp on 2020/10/21.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIListViewStack.h"
@interface ABUIListViewStack()
@property (nonatomic, strong) NSMutableDictionary *_data;
@end
@implementation ABUIListViewStack

- (instancetype)init
{
    self = [super init];
    if (self) {
        self._data = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setData:(NSDictionary *)data {
    self._data = [[NSMutableDictionary alloc] initWithDictionary:data];
}

- (void)set:(id)value key:(NSString *)key {
    if (key == nil) {
        return;
    }
    [self._data setValue:value forKey:key];
}

- (id)get:(NSString *)key {
    return self._data[key];
}

- (NSDictionary *)all {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    for (NSString *key in self._data.allKeys) {
        if ([key hasPrefix:@"_"] == false) {
            dic[key] = self._data[key];
        }
    }
    return dic;
}

- (void)dealloc
{
    NSLog(@"stack dealloc");
}

@end
