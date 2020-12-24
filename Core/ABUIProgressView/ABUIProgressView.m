//
//  ABUIProgressView.m
//  ABUIKit
//
//  Created by qp on 2020/12/14.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIProgressView.h"
#import "UIView+AB.h"
@interface ABUIProgressView ()
@property (nonatomic, strong) UIView *progressTintView;
@property (nonatomic, strong) UIView *trackView;
@end
@implementation ABUIProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = true;
        self.progressTintView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.progressTintView];
        
        self.trackView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.trackView];
    }
    return self;
}

- (void)setProgressTintColor:(UIColor *)progressTintColor {
    _progressTintColor = progressTintColor;
    
    self.progressTintView.backgroundColor = progressTintColor;
}

- (void)setTrackTintColor:(UIColor *)trackTintColor {
    _trackTintColor = trackTintColor;
    
    self.trackView.backgroundColor = trackTintColor;
}
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    CGRect frame = self.trackView.frame;
    frame.size.width = self.frame.size.width*progress;
    self.trackView.frame = frame;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    
    self.layer.cornerRadius = cornerRadius;
    self.progressTintView.layer.cornerRadius = cornerRadius;
    self.trackView.layer.cornerRadius = cornerRadius;
}



- (void)layoutSubviews {
    [super layoutSubviews];
    self.progressTintView.width = self.width;
    self.trackView.width = self.width*self.progress;
}
@end
