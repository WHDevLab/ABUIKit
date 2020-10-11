//
//  UIFont+AB.m
//  ABUIKit
//
//  Created by qp on 2020/9/25.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "UIFont+AB.h"

@implementation UIFont (AB)
+ (UIFont *)fontMicrosoftYaHei:(CGFloat)size {
//    return [UIFont fontWithName:@"Microsoft YaHei" size:size];
    return [UIFont fontWithName:@"PingFangSC-Medium" size:size];
}

+ (UIFont *)PingFangSC:(CGFloat)size {
    return [UIFont fontWithName:@"PingFangSC-Regular" size:size];
}
+ (UIFont *)PingFangMedium:(CGFloat)size {
    return [UIFont fontWithName:@"PingFangSC-Medium" size:size];
}
+ (UIFont *)PingFangSCBlod:(CGFloat)size {
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
}

@end
