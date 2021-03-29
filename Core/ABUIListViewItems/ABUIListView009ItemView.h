//
//  ABUIListView009ItemView.h
//  ABUIKit
//
//  Created by qp on 2021/3/11.
//  Copyright © 2021 abteam. All rights reserved.
//  微信银行卡提现
//  提现金额
//  ¥ 1000.00
//  当前零钱余额8888.00，全部提现

#import "ABUIListViewBaseItemView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ABUIListView009ItemView : ABUIListViewBaseItemView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *accordLabel;
@property (nonatomic, strong) UIButton *allButton;
@property (nonatomic, strong) UILabel *noticeLabel;

@property (nonatomic, assign) int num;
@property (nonatomic, strong) UITextField *textField;
- (void)setNoticeText:(NSString *)notice;
- (void)recharge;
@end

NS_ASSUME_NONNULL_END
