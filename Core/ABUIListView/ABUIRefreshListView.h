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
@end

NS_ASSUME_NONNULL_END
