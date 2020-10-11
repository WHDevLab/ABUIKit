//
//  NSDictionary+AB.m
//  Demo
//
//  Created by qp on 2020/5/6.
//  Copyright © 2020 ab. All rights reserved.
//

#import "NSDictionary+AB.h"

@implementation NSDictionary (AB)
- (NSString *)toJSONString {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
//    NSError *error;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
//    if (error) {
//        NSLog(@"json解析失败:%@", error);
//        return nil;
//    }
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    return jsonString;
}

- (NSString *)stringValueForKey:(NSString *)key {
    if (self[key] == nil) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@", self[key]];
}

- (NSString *)stringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue {
    if (self[key] == nil) {
        return defaultValue;
    }
    return [self stringValueForKey:key];
}

- (id)svf:(NSString *)key dv:(id)dv {
    if (self[key] == nil) {
        return dv;
    }
    return self[key];
}

- (id)valueInKeys:(NSArray *)keys {
    for (NSString *key in keys) {
        if (self[key] != nil) {
            return self[key];
        }
    }
    
    return @"";
}

@end
