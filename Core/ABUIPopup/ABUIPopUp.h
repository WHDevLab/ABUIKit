//
//  ABUIPopUp.h
//  ABUIKit
//
//  Created by qp on 2020/7/2.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ABUIWXPwdView.h"
#import "ABUIPopupConfiguration.h"
NS_ASSUME_NONNULL_BEGIN

typedef void (^WXPwdBlock)(NSString *text);

typedef enum : NSUInteger {
    ABPopUpDirectionTop,
    ABPopUpDirectionCenter,
    ABPopUpDirectionBottom,
} ABPopUpDirection;

typedef void (^ABUIPopupBlock)();

@interface ABUIPopUpContainer : UIView
@property (nonatomic, assign) BOOL enableWrapperClose; //是否启用点击空白关闭功能
@end

@interface ABUIPopUp : NSObject
@property (nonatomic, assign) CGFloat distance;
@property (nonatomic, assign) BOOL mask;

+ (ABUIPopUp *)shared;
- (void)show:(UIView *)v from:(ABPopUpDirection)direction;
- (void)show:(UIView *)v from:(ABPopUpDirection)direction mask:(BOOL)mask;
- (void)show:(UIView *)v from:(ABPopUpDirection)direction duration:(NSInteger)duration;
- (void)show:(UIView *)v from:(ABPopUpDirection)direction distance:(CGFloat)distance;
- (void)show:(UIView *)v from:(ABPopUpDirection)direction distance:(CGFloat)distance hideBlock:(ABUIPopupBlock)hideBlock;
- (void)show:(UIView *)v from:(ABPopUpDirection)direction distance:(CGFloat)distance hideBlock:(ABUIPopupBlock)hideBlock showBlock:(ABUIPopupBlock)showBlock;
- (void)show:(UIView *)v from:(ABPopUpDirection)direction duration:(NSInteger)duration distance:(CGFloat)distance hideBlock:(nonnull ABUIPopupBlock)hideBlock showBlock:(nonnull ABUIPopupBlock)showBlock;
- (void)remove;
- (void)remove:(CGFloat)duration;

// 通用弹出模版
- (void)showWXPwdWithConfig:(ABWXPwdConfig *)config success:(WXPwdBlock)success;
- (void)showBankSelection:(NSArray *)titles success:(WXPwdBlock)success;
@end

NS_ASSUME_NONNULL_END
