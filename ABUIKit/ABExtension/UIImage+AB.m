//
//  UIImage+AB.m
//  Demo
//
//  Created by qp on 2020/5/6.
//  Copyright © 2020 ab. All rights reserved.
//

#import "UIImage+AB.h"

@implementation UIImage (AB)
+(UIImage *)imageWithColor:(UIColor *)color{
    CGSize imageSize = CGSizeMake(1, 1);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;
}

+(UIImage *)imageWithColor:(UIColor *)color frame:(CGRect)frame {
    UIView *v = [[UIView alloc] initWithFrame:frame];
    v.backgroundColor = color;
    
    
    CGSize imageSize = CGSizeMake(1, 1);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;
}

+ (UIImage *)imageWithGradientColors:(NSArray *)colors frame:(CGRect)frame {
    
    UIView *v = [[UIView alloc] initWithFrame:frame];
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = frame;
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = colors;
    gl.locations = @[@(0.0),@(1.0)];
    
    [v.layer insertSublayer:gl atIndex:0];
    
//    [[UIApplication sharedApplication].keyWindow addSubview:v];
    
    CGSize s = v.bounds.size;
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
