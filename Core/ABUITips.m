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
    [[UIApplication sharedApplication].keyWindow makeToastActivity:CSToastPositionCenter];
}

+ (void)hideLoading {
    [[UIApplication sharedApplication].keyWindow hideToastActivity];
}
@end
