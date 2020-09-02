//
//  ABUIRefreshListView.m
//  ABUIKit
//
//  Created by qp on 2020/8/24.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIRefreshListView.h"
@interface ABUIRefreshListView ()
@end
@implementation ABUIRefreshListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLoadMore];
        [self setupPullRefresh];
    }
    return self;
}
- (void)setDataList:(NSArray *)dataList css:(NSDictionary *)css {
    
    if (self.isLoadMoreing) {
        [self._dataList addObjectsFromArray:dataList];
    }
    else{
        self._dataList = [[NSMutableArray alloc] initWithArray:dataList];
    }
    
    [self endPullRefreshing];
    [self endLoadMore];
    if (dataList.count == 0) {
        [self noMoreData];
    }
    [super setDataList:self._dataList css:css];
}
@end