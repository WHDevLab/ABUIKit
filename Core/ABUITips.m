//
//  ABUITips.m
//  ABUIKit
//
//  Created by qp on 2020/7/17.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUITips.h"
#import <Toast/Toast.h>
@implementation ABUITips
+ (void)showSucceed:(NSString *)text {
    [[UIApplication sharedApplication].keyWindow makeToast:text duration:1 position:CSToastPositionCenter];
}

+ (void)showError:(NSString *)text {
     [[UIApplication sharedApplication].keyWindow makeToast:text duration:1 position:CSToastPositionCenter];
}

+ (void)showLoading {
    [NSObject cancelPreviousPerformRequestsWithTarget:[UIApplication sharedApplication].keyWindow];
    [[UIApplication sharedApplication].keyWindow hideToastActivity];
    [[UIApplication sharedApplication].keyWindow makeToastActivity:CSToastPositionCenter];
    [[UIApplication sharedApplication].keyWindow performSelector:@selector(hideToastActivity) withObject:nil afterDelay:2];
}

+ (void)hideLoading {
    [[UIApplication sharedApplication].keyWindow hideToastActivity];
}
@end
