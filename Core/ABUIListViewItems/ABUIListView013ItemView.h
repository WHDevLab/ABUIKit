//
//  ABUIListView013ItemView.h
//  ABUIKit
//
//  Created by qp on 2021/5/28.
//  Copyright © 2021 abteam. All rights reserved.
//  微信银行卡item bankitem

#import "ABUIListViewBaseItemView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ABUIListView013ItemView : ABUIListViewBaseItemView
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *cardLabel;
@end

NS_ASSUME_NONNULL_END
