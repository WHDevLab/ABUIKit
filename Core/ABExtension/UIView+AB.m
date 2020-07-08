//
//  UIView+AB.m
//  Demo
//
//  Created by qp on 2020/5/6.
//  Copyright © 2020 ab. All rights reserved.
//

#import "UIView+AB.h"
#import <objc/runtime.h>
#import "UIColor+AB.h"
@implementation UIView (AB)
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
//    self.width = size.width;
//    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGFloat)left{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)right{
    return CGRectGetMaxX(self.frame);
}

-(void)setRight:(CGFloat)right{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)top{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)bottom{
    return CGRectGetMaxY(self.frame);
}

- (void)setBottom:(CGFloat)bottom{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (void)addLineDirection:(LineDirection)dirction color:(UIColor *)color width:(CGFloat)width{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
    lineView.backgroundColor = color;
    CGFloat lineWidth = width;
    if (width == 1) {
        lineWidth = 1.0/[UIScreen mainScreen].scale;
    }
    switch (dirction) {
        case LineDirectionTop:
        {
            lineView.frame = CGRectMake(0, 0, self.width, lineWidth);
        }
            break;
        case LineDirectionRight:
        {
            lineView.frame = CGRectMake(self.width-width, 0, lineWidth, self.height);
        }
            break;
        case LineDirectionBottom:
        {
            lineView.frame = CGRectMake(0, self.height-width, self.width, lineWidth);
        }
            break;
        case LineDirectionLeft:
        {
            lineView.frame = CGRectMake(0, 0, lineWidth, self.height);
        }
            break;
        case LineDirectionLeftMiddle:
        {
            lineView.frame = CGRectMake(0, 0, lineWidth, self.height/2);
            lineView.centerY = self.height/2;
        }
        default:
            break;
    }
    [self addSubview:lineView];
}

- (BOOL)isShowingOnKeyWindow
{
    // 主窗口
    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}


- (void)corner:(UIRectCorner)corners radii:(CGFloat)radii {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(radii, radii)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)addTopShadow {
    self.layer.shadowColor = [[UIColor hexColor:@"3A4C82"] CGColor];
    self.layer.shadowOpacity = 0.07;
    self.layer.shadowOffset = CGSizeMake(0, -19);
    self.layer.shadowRadius = 38;
}


- (void)gradient:(NSArray *)colors direction:(NSInteger)direction {
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = self.bounds;
    gl.colors = colors;
    gl.locations = @[@(0.0),@(1.0)];
    if (direction == 0) {
        gl.startPoint = CGPointMake(0, 0);
        gl.endPoint = CGPointMake(1, 1);
    }
    if (direction == 1) {
        gl.startPoint = CGPointMake(0, 0.5);
        gl.endPoint = CGPointMake(1, 0.5);
    }
    if (direction == 2) {
        gl.startPoint = CGPointMake(0.5, 0);
        gl.endPoint = CGPointMake(0.5, 1);
    }
    
    [self.layer insertSublayer:gl atIndex:0];
}

- (void)borderWidth:(CGFloat)width color:(UIColor *)color {
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

@end
