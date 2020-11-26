//
//  ABUIRefreshListView.h
//  ABUIKit
//
//  Created by qp on 2020/8/24.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIListView.h"

NS_ASSUME_NONNULL_BEGIN
@interface ABUIRefreshListView : ABUIListView
@property (nonatomic, strong) NSMutableArray *_dataList;
@property (nonatomic, assign) NSInteger limit; //分页 单页数量
@property (nonatomic, assign) BOOL isSupportHeader; ///< 是否支持下拉刷新, 默认支持
@property (nonatomic, assign) BOOL isSupportFooter; ///< 是否支持加载更多, 默认支持
@property (nonatomic, assign) BOOL isSupportSeat; ///<是否支持没有数据时显示空白页
@end

NS_ASSUME_NONNULL_END
