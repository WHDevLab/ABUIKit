//
//  UIImage+AB.h
//  Demo
//
//  Created by qp on 2020/5/6.
//  Copyright © 2020 ab. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (AB)
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color frame:(CGRect)frame;
+ (UIImage *)imageWithGradientColors:(NSArray *)colors frame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
