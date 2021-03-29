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
#import "ABUIListViewStack.h"
#import "ABUIListViewConfigure.h"
#import "ABUISeatView.h"
@class ABUIListViewCell;
NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    StatDirectionLeft,
    StatDirectionRight,
    StatDirectionBottom,
    StatDirectionTop
} StatDirection;

@class ABUIListView;

@protocol ABUIListViewHeaderViewDelegate <NSObject>
- (void)onListViewScroll:(CGFloat)offset;

@end

@protocol ABUIListViewDelegate <NSObject>

@optional
- (CGFloat)listView:(ABUIListView *)listView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item;
- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item itemKey:(nullable NSString *)itemKey;
- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item extra:(NSDictionary *)extra;
//- (void)listView:(ABUIListView *)listView didClickAtIndexPath:(NSIndexPath *)indexPath key:(NSString *)key;

- (CGSize)listView:(ABUIListView *)listView sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
- (CGSize)listView:(ABUIListView *)listView sizeForItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item;

- (void)listView:(ABUIListView *)listView onContentSizeChanged:(CGSize)contentSize;
- (void)listViewOnHeaderPullRefresh:(ABUIListView *)listView;
- (void)listViewOnLoadMore:(ABUIListView *)listView;
- (void)listViewDidReload:(ABUIListView *)listView;
- (void)listViewDidScroll:(ABUIListView *)listView offset:(CGFloat)offset;
- (void)listViewDidScrollToBottom:(ABUIListView *)listView;
- (void)listViewBeginDragging:(ABUIListView *)listView;
- (void)listView:(ABUIListView *)listView onPageChanged:(int)page;
- (void)listView:(ABUIListView *)listView didActionItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item itemKey:(NSString *)itemKey actionKey:(NSString *)actionKey actionData:(id)actionData;
- (void)listView:(ABUIListView *)listView didActionItemAtSection:(NSInteger)section item:(NSDictionary *)item itemKey:(NSString *)itemKey actionKey:(NSString *)actionKey actionData:(id)actionData;
- (void)listView:(ABUIListView *)listView formCheckError:(NSString *)message;
- (void)listViewOnSeatButton:(ABUIListView *)listView;
- (void)listView:(ABUIListView *)listView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;
//- (void)listViewDidItemActionResponse:(ABUIListView *)listView itemKey:(NSString *)itemKey actionKey:(NSString *)actionKey data:(id)data;
@end

@protocol ABUIListViewDataSource <NSObject>

@optional
- (NSDictionary *)listView:(ABUIListView *)listView extraDataAtIndexPath:(nonnull NSIndexPath *)indexPath;
- (NSDictionary *)listView:(ABUIListView *)listView extraDataAtIndexPath:(nonnull NSIndexPath *)indexPath item:(NSDictionary *)item;

- (BOOL)listView:(ABUIListView *)listView visableItemAtIndexPath:(nonnull NSIndexPath *)indexPath item:(NSDictionary *)item;
- (NSDictionary *)listView:(ABUIListView *)listView editItemAtIndexPath:(nonnull NSIndexPath *)indexPath item:(NSMutableDictionary *)item;

@end

@interface ABUIListView : UIView
@property (nonatomic, weak) id<ABUIListViewDelegate> delegate;
@property (nonatomic, weak) id<ABUIListViewDataSource> dataSource;
@property (nonatomic, strong) ABUICollectionView *collectionView;
@property (nonatomic, assign) BOOL dynamicContent;
/// 当内容大小低于frame的时候，内容滑动方向，例如聊天室聊天视图
@property (nonatomic, assign) StatDirection startDirection;

/// 刷新状态
@property (nonatomic, assign) BOOL isPullRefreshing;
@property (nonatomic, assign) BOOL isLoadMoreing;

/// 分区颜色
@property (nonatomic, strong) UIColor *sectionColor;
///
/// 禁止滚动
@property(nonatomic) BOOL bounces;
/// 头视图
@property (nonatomic, strong) UIView *headerView;
/// 尾视图
@property (nonatomic, strong) UIView *footerView;

@property (nonatomic) UICollectionViewScrollDirection scrollDirection;

@property (nonatomic, strong) ABUIListViewStack *stack;
@property (nonatomic, strong) ABUIListViewStack *innerStack;
@property (nonatomic, strong) NSMutableDictionary<NSString *, ABUIListViewCell *> *cellViewMap;
@property (nonatomic, strong) NSArray *fRuleKeys; /// 为了解决 frules allkeys 乱序问题,临时方案,外部指定

@property (nonatomic, strong) UIColor *separatorColor;
@property (nonatomic, assign) CGFloat insetBottom;

@property (nonatomic, assign) BOOL enableSeat;
@property (nonatomic, strong) NSString *seatTitle;
@property (nonatomic, strong) NSString *seatImageName;
@property (nonatomic, strong) NSString *seatNetTitle;
@property (nonatomic, strong) NSString *seatNetImageName;
@property (nonatomic, strong) ABUISeatViewConfig *seatConfig;
@property (nonatomic, assign) BOOL formCheck;

- (instancetype)initWithFrame:(CGRect)frame layout:(UICollectionViewLayout *)layout;
- (instancetype)initWithFrame:(CGRect)frame configure:(ABUIListViewConfigure *)configure;
- (void)setDataList:(NSArray *)dataList css:(nullable NSDictionary *)css;
- (void)setDataList:(NSArray *)dataList cssModule:(nullable ABUIListViewCSS *)cssModule;
- (void)setFormRules:(NSDictionary *)rules;
/// dataList数据格式参考ABUIListViewTemplete.json
- (void)setTempleteDataList:(NSArray *)dataList;
- (void)reloadData;
- (void)reloadSection:(int)section;
- (void)scrollToBottom:(BOOL)animated;
- (void)scrollToTop:(BOOL)animated;
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
- (NSDictionary *)itemWithIndexPath:(NSIndexPath *)indexPath;
- (BOOL)isEmpty;
- (BOOL)checkForm;
- (BOOL)isContentFull; //内容是否铺满

/// -1 全刷，用于一些行在特定条件才展示, 通过回调 visableItemAtIndexPath
- (void)hotReloadSection:(int)section; //刷新数据中哪些行需要展示哪些不需要展示，做一层筛选
- (NSArray *)visableCells;
- (void)reloadUserProvide:(NSString *)itemKey;
@end

NS_ASSUME_NONNULL_END
