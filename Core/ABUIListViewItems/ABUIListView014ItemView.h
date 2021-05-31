//
//  ABUIListView014ItemView.h
//  ABUIKit
//
//  Created by qp on 2021/5/28.
//  Copyright © 2021 abteam. All rights reserved.
//  充值金额item

#import "ABUIListViewBaseItemView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ABUIListView014ItemView : ABUIListViewBaseItemView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) UILabel *noticeLabel;
@property (nonatomic, strong) UIButton *noticeButton;
@end

NS_ASSUME_NONNULL_END
