//
//  UIImageView+AB.h
//  Demo
//
//  Created by qp on 2020/5/6.
//  Copyright © 2020 ab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/SDWebImage.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (AB)
- (void)loadImage:(NSString *)str;
- (void)loadAni:(NSArray *)names;
- (void)addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
@end

NS_ASSUME_NONNULL_END
