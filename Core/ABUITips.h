//
//  ABUITips.h
//  ABUIKit
//
//  Created by qp on 2020/7/17.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABUITips : NSObject
+ (void)showSucceed:(NSString *)text;
+ (void)showError:(NSString *)text;
+ (void)showLoading;
+ (void)hideLoading;
@end

NS_ASSUME_NONNULL_END
