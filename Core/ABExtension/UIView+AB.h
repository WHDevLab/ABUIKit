//
//  UIView+AB.h
//  Demo
//
//  Created by qp on 2020/5/6.
//  Copyright © 2020 ab. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LineDirection) {
    LineDirectionLeft,
    LineDirectionLeftMiddle,
    LineDirectionTop,
    LineDirectionRight,
    LineDirectionBottom
};

@interface UIView (AB)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;

/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow;

- (void)addLineDirection:(LineDirection)dirction color:(UIColor *)color width:(CGFloat)width;

- (void)corner:(UIRectCorner)corners radii:(CGFloat)radii;

- (void)addTopShadow;
- (void)addShadow;

/// direction: 0左->右，1右->左, 2上->下, 3下->上
- (void)gradient:(NSArray *)colors direction:(NSInteger)direction;

- (void)borderWidth:(CGFloat)width color:(UIColor *)color;
- (void)shake;
- (void)rotate;



/// animate
- (void)doShakeAnimation;
/// twinkle
- (void)doTwinkle;
@end

NS_ASSUME_NONNULL_END
