//
//  ABUIListView.h
//  Demo
//
//  Created by qp on 2020/5/8.
//  Copyright © 2020 ab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABUIListViewCSS.h"
#import "ABUICollectionView.h"
#import "ABUIListViewMapping.h"
NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    StatDirectionLeft,
    StatDirectionRight,
    StatDirectionBottom,
    StatDirectionTop
} StatDirection;

@class ABUIListView;
@protocol ABUIListViewDelegate <NSObject>

@optional
- (CGFloat)listView:(ABUIListView *)listView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item;
//- (void)listView:(ABUIListView *)listView didClickAtIndexPath:(NSIndexPath *)indexPath key:(NSString *)key;

- (CGSize)listView:(ABUIListView *)listView sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

- (void)listView:(ABUIListView *)listView onContentSizeChanged:(CGSize)contentSize;
- (void)listViewOnHeaderPullRefresh:(ABUIListView *)listView;
- (void)listViewOnLoadMore:(ABUIListView *)listView;
- (void)listViewDidReload:(ABUIListView *)listView;
- (void)listViewDidScrollToBottom:(ABUIListView *)listView;
@end

@protocol ABUIListViewDataSource <NSObject>

@optional
- (NSDictionary *)listView:(ABUIListView *)listView extraDataAtIndexPath:(nonnull NSIndexPath *)indexPath;

@end

@interface ABUIListView : UIView
@property (nonatomic, weak) id<ABUIListViewDelegate> delegate;
@property (nonatomic, weak) id<ABUIListViewDataSource> dataSource;
@property (nonatomic, strong) ABUICollectionView *collectionView;
@property (nonatomic, assign) BOOL dynamicContent;
@property (nonatomic, assign) StatDirection startDirection;

/// 刷新状态
@property (nonatomic, assign) BOOL isPullRefreshing;
@property (nonatomic, assign) BOOL isLoadMoreing;
///
/// 禁止滚动
@property(nonatomic) BOOL bounces;
/// 头视图
@property (nonatomic, strong) UIView *headerView;
/// 尾视图
@property (nonatomic, strong) UIView *footerView;

@property (nonatomic) UICollectionViewScrollDirection scrollDirection;

- (void)setDataList:(NSArray *)dataList css:(nullable NSDictionary *)css;
- (void)setDataList:(NSArray *)dataList cssModule:(nullable ABUIListViewCSS *)cssModule;
/// dataList数据格式参考ABUIListViewTemplete.json
- (void)setTempleteDataList:(NSArray *)dataList;
- (void)reloadData;
- (void)scrollToBottom:(BOOL)animated;
- (BOOL)isInBottom;
- (void)setupPullRefresh;
- (void)beginPullRefreshing;
- (void)endPullRefreshing;

- (void)setupLoadMore;
//- (void)beginPullRefreshing;
- (void)endLoadMore;
- (void)noMoreData;
- (void)resetNoMoreData;
- (void)adapterSafeArea;
- (UIView *)itemViewAtIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
