//
//  ABUIListView012ItemView.h
//  ABUIKit
//
//  Created by qp on 2021/3/11.
//  Copyright © 2021 abteam. All rights reserved.
//  设置item
// -----------------
// 头像           img
// -----------------

#import "ABUIListViewBaseItemView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ABUIListView012ItemView : ABUIListViewBaseItemView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *avatarImageView;

@end

NS_ASSUME_NONNULL_END
