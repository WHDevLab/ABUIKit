//
//  NSDictionary+AB.h
//  Demo
//
//  Created by qp on 2020/5/6.
//  Copyright © 2020 ab. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (AB)
- (NSString *)toJSONString;
- (NSString *)toJSONString2;
- (NSString *)stringValueForKey:(NSString *)key;
- (NSString *)stringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (id)svf:(NSString *)key dv:(id)dv;
- (id)valueInKeys:(NSArray *)keys;
@end

NS_ASSUME_NONNULL_END
