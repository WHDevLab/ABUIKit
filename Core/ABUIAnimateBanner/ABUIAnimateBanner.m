//
//  ABUIAnimateBanner.m
//  ABUIKit
//
//  Created by qp on 2020/7/16.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIAnimateBanner.h"
#import "ABUIAnimateBannerRawProtocol.h"
#import "ABUIAnimateBannerRaw.h"
#import "UIView+AB.h"
@interface ABUIAnimateBanner ()
@property (nonatomic, strong) NSMutableArray<ABUIAnimateBannerRaw *> *pools;
@property (nonatomic, strong) NSMutableArray *quene;
@property (nonatomic, assign) BOOL isShoot;
@end
@implementation ABUIAnimateBanner
- (instancetype)initWithFrame:(CGRect)frame config:(nullable ABUIAnimateBannerConfig *)config
{
    self = [super initWithFrame:frame];
    if (self) {
        self.quene = [[NSMutableArray alloc] init];
        self.pools = [[NSMutableArray alloc] init];
        
        CGFloat p = config.itemPadding*(config.count-1);
        CGFloat h = (self.frame.size.height-p)/config.count;
        CGFloat top = (self.frame.size.height-h*config.count-p)/2;
        for (int i=0; i<2; i++) {
            ABUIAnimateBannerRaw *raw = [[ABUIAnimateBannerRaw alloc] initWithFrame:CGRectMake(0, top, config.itemWidth, h)];
            [self.pools addObject:raw];
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.quene = [[NSMutableArray alloc] init];
        self.isShoot = false;
    }
    return self;
}

- (void)pushData:(NSDictionary *)data {
    [self.quene insertObject:data atIndex:0];
    [self shoot];
}

- (void)shoot {
    if (self.quene.count == 0) {
        return;
    }
    if (_isShoot) {
        return;
    }
    _isShoot = true;
    
    NSDictionary *data = [self.quene lastObject];
    ABUIAnimateBannerRaw *raw = [[ABUIAnimateBannerRaw alloc] initWithFrame:CGRectMake(self.width, 0, 100, self.height)];
    [raw reload:data clsStr:data[@"native_id"]];
    [self addSubview:raw];
    [UIView animateKeyframesWithDuration:2.0 delay:0
            options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionCurveLinear animations:^{
        //第一个关键帧:从0秒开始持续50%的时间，也就是5.0*0.5=2.5秒
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.1 animations:^{
            raw.left = 50;
        }];
        //第二个关键帧:从50%时间开始持续25%的时间，也就是5.0*0.25=1.25秒
        [UIView addKeyframeWithRelativeStartTime:0.1 relativeDuration:0.85 animations:^{
            raw.left = 10;
        }];
        //第三个关键帧:从75%时间开始持续25%的时间，也就是5.0*0.25=1.25秒
        [UIView addKeyframeWithRelativeStartTime:0.95 relativeDuration:0.05 animations:^{
            raw.left = -raw.width;
        }];
    } completion:^(BOOL finished) {
        [raw removeFromSuperview];
        [self.quene removeLastObject];
        self.isShoot = false;
        [self shoot];
    }];
}

@end
