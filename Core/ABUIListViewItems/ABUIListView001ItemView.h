//
//  ABUIListView001ItemView.h
//  ABUIKit
//
//  Created by qp on 2021/3/11.
//  Copyright © 2021 abteam. All rights reserved.
//  纯文字行
//
//  ----------------
//  设置
//  ----------------
//
// eg: {@"native_id":@"ablist_item_001", @"data.title":@"标题"}

#import "ABUIListViewBaseItemView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ABUIListView001ItemView : ABUIListViewBaseItemView
@property (nonatomic, strong) UILabel *titleLabel;
@end

NS_ASSUME_NONNULL_END
