//
//  ABUIAnimateBannerRaw.m
//  ABUIKit
//
//  Created by qp on 2020/7/16.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIAnimateBannerRaw.h"
#import "ABUIAnimateBannerRawProtocol.h"
@interface ABUIAnimateBannerRaw ()
@property (nonatomic, strong) UIView *mainView;
@end
@implementation ABUIAnimateBannerRaw

- (void)reload:(NSDictionary *)item clsStr:(nonnull NSString *)clsStr {
    self.data = item;
    if (clsStr == nil) {
        NSLog(@"classString is empty");
        return;
    }
    if (clsStr != [[self.mainView class] description]) {
        [self.mainView removeFromSuperview];
        self.mainView = nil;
    }
    if (self.mainView == nil) {
        self.mainView = [(UIView *)[NSClassFromString(clsStr) alloc] initWithFrame:self.bounds];
        if ([self.mainView conformsToProtocol:@protocol(ABUIAnimateBannerRawProtocol)]) {
            [self addSubview:self.mainView];
            [(id<ABUIAnimateBannerRawProtocol>)self.mainView setupAdjustContents];
        }else{
            NSAssert(NO, @"itemview 必须准守协议ABUIAnimateBannerRawProtocol");
        }
    }
    [(id<ABUIAnimateBannerRawProtocol>)self.mainView reload:item];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.mainView.frame = self.bounds;
    [(id<ABUIAnimateBannerRawProtocol>)self.mainView layoutAdjustContents];
}

@end
