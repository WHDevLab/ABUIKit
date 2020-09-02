//
//  ABUIPopUp.h
//  ABUIKit
//
//  Created by qp on 2020/7/2.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    ABPopUpDirectionTop,
    ABPopUpDirectionCenter,
    ABPopUpDirectionBottom,
} ABPopUpDirection;

typedef void (^ABUIPopupBlock)();

@interface ABUIPopUp : NSObject
@property (nonatomic, assign) CGFloat distance;

+ (ABUIPopUp *)shared;
- (void)show:(UIView *)v from:(ABPopUpDirection)direction;
- (void)show:(UIView *)v from:(ABPopUpDirection)direction duration:(NSInteger)duration;
- (void)show:(UIView *)v from:(ABPopUpDirection)direction distance:(CGFloat)distance;
- (void)show:(UIView *)v from:(ABPopUpDirection)direction distance:(CGFloat)distance hideBlock:(ABUIPopupBlock)hideBlock;
- (void)show:(UIView *)v from:(ABPopUpDirection)direction distance:(CGFloat)distance hideBlock:(ABUIPopupBlock)hideBlock showBlock:(ABUIPopupBlock)showBlock;
- (void)show:(UIView *)v from:(ABPopUpDirection)direction duration:(NSInteger)duration distance:(CGFloat)distance hideBlock:(nonnull ABUIPopupBlock)hideBlock showBlock:(nonnull ABUIPopupBlock)showBlock;
- (void)remove;
- (void)remove:(CGFloat)duration;
@end

NS_ASSUME_NONNULL_END
