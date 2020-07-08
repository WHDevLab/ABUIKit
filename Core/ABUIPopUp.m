//
//  ABUIPopUp.m
//  ABUIKit
//
//  Created by qp on 2020/7/2.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIPopUp.h"
#import "UIView+AB.h"
@interface ABUIPopUp ()
@property (nonatomic, strong) UIControl *cover;
@property (nonatomic, strong) UIView *containView;
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

- (void)show:(UIView *)v from:(ABPopUpDirection)direction {
    [self show:v from:direction distance:0];
}

- (void)show:(UIView *)v from:(ABPopUpDirection)direction distance:(CGFloat)distance {
    self.distance = distance;
    [self _showCover];
    self.containView = v;
    [[UIApplication sharedApplication].keyWindow addSubview:v];
    [self _animateShow];
}

- (void)_animateShow {
    self.cover.alpha = 0;
    self.containView.top = [UIScreen mainScreen].bounds.size.height;
    [UIView animateWithDuration:0.1 animations:^{
        self.cover.alpha = 0.2;
        self.containView.top = [UIScreen mainScreen].bounds.size.height-self.containView.height-self.distance;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)_animateHidden:(CGFloat)duration {
    self.cover.alpha = 0.2;
    self.containView.top = [UIScreen mainScreen].bounds.size.height-self.containView.height;
    [UIView animateWithDuration:duration animations:^{
        self.cover.alpha = 0;
        self.containView.top = [UIScreen mainScreen].bounds.size.height;
    } completion:^(BOOL finished) {
        [self.cover removeFromSuperview];
        self.containView = nil;
        self.cover = nil;
    }];
}

- (void)_showCover {
    self.cover = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.cover.backgroundColor = UIColor.blackColor;
    [self.cover addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview: self.cover];
}

- (void)remove {
    [self _animateHidden:0.1];
}

- (void)remove:(CGFloat)duration {
    [self _animateHidden:duration];
}

@end

