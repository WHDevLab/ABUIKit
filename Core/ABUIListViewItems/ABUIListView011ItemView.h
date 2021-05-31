//
//  ABUIListView011ItemView.h
//  ABUIKit
//
//  Created by qp on 2021/3/11.
//  Copyright © 2021 abteam. All rights reserved.
//
// 收获地址
// 六六               18888888888
// 北京市朝阳区望京soho6楼304
// 默认地址           编辑    删除

#import "ABUIListViewBaseItemView.h"
#import "QMUIKit.h"
NS_ASSUME_NONNULL_BEGIN

@interface ABUIListView011ItemView : ABUIListViewBaseItemView
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UIView *toolView;
@property (nonatomic, strong) QMUIButton *defaultButton;
@property (nonatomic, strong) QMUIButton *editButton;
@property (nonatomic, strong) QMUIButton *delButton;
@end

NS_ASSUME_NONNULL_END
