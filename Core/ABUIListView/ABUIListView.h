//
//  ABUIListView.h
//  Demo
//
//  Created by qp on 2020/5/8.
//  Copyright © 2020 ab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABUIListViewCSS.h"
NS_ASSUME_NONNULL_BEGIN

@class ABUIListView;
@protocol ABUIListViewDelegate <NSObject>

@optional
- (CGFloat)listView:(ABUIListView *)listView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item;
//- (void)listView:(ListView *)listView didClickAtIndexPath:(NSIndexPath *)indexPath key:(ListViewItemActionKey)key;

- (CGSize)listView:(ABUIListView *)listView sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface ABUIListView : UIView
@property (nonatomic, weak) id<ABUIListViewDelegate> delegate;
@property (nonatomic, strong) UICollectionView *collectionView;
/// 禁止滚动
@property(nonatomic) BOOL bounces;
/// 头视图
@property (nonatomic, strong) UIView *headerView;
/// 尾视图
@property (nonatomic, strong) UIView *footerView;

- (void)setDataList:(NSArray *)dataList css:(nullable NSDictionary *)css;
- (void)setDataList:(NSArray *)dataList cssModule:(nullable ABUIListViewCSS *)cssModule;
/// dataList数据格式参考ABUIListViewTemplete.json
- (void)setTempleteDataList:(NSArray *)dataList;
- (void)reloadData;
@end

NS_ASSUME_NONNULL_END