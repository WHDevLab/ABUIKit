//
//  ABUIPopUp.m
//  ABUIKit
//
//  Created by qp on 2020/7/2.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIPopUp.h"
#import "UIView+AB.h"


@implementation ABUIPopUpContainer

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.enableWrapperClose = true;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end

@interface ABUIPopUp ()
@property (nonatomic, strong) UIControl *cover;
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, assign) ABPopUpDirection direction;
@property (nonatomic, strong) ABUIPopupBlock block;
@end
@implementation ABUIPopUp
+ (ABUIPopUp *)shared {
    static ABUIPopUp *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)show:(UIView *)v from:(ABPopUpDirection)direction duration:(NSInteger)duration {
    [self performSelector:@selector(remove) withObject:nil afterDelay:duration];
    [self show:v from:direction distance:0];
}

- (void)show:(UIView *)v from:(ABPopUpDirection)direction {
    [self show:v from:direction distance:0];
}

- (void)show:(UIView *)v from:(ABPopUpDirection)direction distance:(CGFloat)distance hideBlock:(nonnull ABUIPopupBlock)hideBlock {
    self.block = hideBlock;
    [self show:v from:direction distance:distance];
}

- (void)show:(UIView *)v from:(ABPopUpDirection)direction distance:(CGFloat)distance hideBlock:(nonnull ABUIPopupBlock)hideBlock showBlock:(nonnull ABUIPopupBlock)showBlock {
    self.block = hideBlock;
    showBlock();
    [self show:v from:direction distance:distance];
}

- (void)show:(UIView *)v from:(ABPopUpDirection)direction duration:(NSInteger)duration distance:(CGFloat)distance hideBlock:(nonnull ABUIPopupBlock)hideBlock showBlock:(nonnull ABUIPopupBlock)showBlock {
    [self performSelector:@selector(remove) withObject:nil afterDelay:duration];
    self.block = hideBlock;
    showBlock();
    [self show:v from:direction distance:distance];
}

- (void)show:(UIView *)v from:(ABPopUpDirection)direction distance:(CGFloat)distance {
    [self.containView removeFromSuperview];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.distance = distance;
        self.direction = direction;
        [self _showCover];
        self.containView = v;
        NSLog(@"added");
        [[UIApplication sharedApplication].keyWindow addSubview:self.containView];
        [self _animateShow];
    });
}

- (void)_animateShow {
   
    CGFloat top = self.distance;
    if (self.direction == ABPopUpDirectionBottom) {
        top = [UIScreen mainScreen].bounds.size.height-self.containView.height-self.distance;
    }
    if (self.direction == ABPopUpDirectionCenter) {
        top = ([UIScreen mainScreen].bounds.size.height-self.containView.height)/2+self.distance;
    }
    self.cover.alpha = 0;
    self.containView.top = [UIScreen mainScreen].bounds.size.height;
    self.containView.left = ([UIScreen mainScreen].bounds.size.width-self.containView.width)/2;
    [UIView animateWithDuration:0.1 animations:^{
        self.cover.alpha = 0.2;
        self.containView.top = top;
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.containView];
    }];
}

- (void)_animateHidden:(CGFloat)duration {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if (self.block != nil) {
        self.block();
    }
    if (duration == 0) {
        self.cover.alpha = 0;
        self.containView.top = [UIScreen mainScreen].bounds.size.height;
        [self.containView removeFromSuperview];
        [self.cover removeFromSuperview];
        self.containView = nil;
        self.cover = nil;
        return;
    }
    self.cover.alpha = 0.2;
    self.containView.top = [UIScreen mainScreen].bounds.size.height-self.containView.height;
    [UIView animateWithDuration:duration animations:^{
        self.cover.alpha = 0;
        self.containView.top = [UIScreen mainScreen].bounds.size.height;
    } completion:^(BOOL finished) {
        [self.cover removeFromSuperview];
        [self.containView removeFromSuperview];
        self.containView = nil;
        self.cover = nil;
    }];
}

- (void)_showCover {
    [self.cover removeFromSuperview];
    self.cover = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.cover.backgroundColor = UIColor.blackColor;
    [self.cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview: self.cover];
}

- (void)coverClick {
    if ([self.containView isKindOfClass:[ABUIPopUpContainer class]]) {
        if ([(ABUIPopUpContainer *)self.containView enableWrapperClose] == false) {
            return;
        }
    }
    [self remove];
}

- (void)remove {
    [self _animateHidden:0.1];
}

- (void)remove:(CGFloat)duration {
    [self _animateHidden:duration];
}

@end

