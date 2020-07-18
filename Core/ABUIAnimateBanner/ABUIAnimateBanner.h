//
//  ABUIAnimateBanner.h
//  ABUIKit
//
//  Created by qp on 2020/7/16.
//  Copyright © 2020 abteam. All rights reserved.
//  弹幕，礼物

#import <UIKit/UIKit.h>

#import "ABUIAnimateBannerConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface ABUIAnimateBanner : UIView
- (instancetype)initWithFrame:(CGRect)frame config:(nullable ABUIAnimateBannerConfig *)config;
- (void)pushData:(NSDictionary *)data;
@end

NS_ASSUME_NONNULL_END
