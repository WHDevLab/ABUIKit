//
//  ABUIListView.m
//  Demo
//
//  Created by qp on 2020/5/8.
//  Copyright © 2020 ab. All rights reserved.
//

#import "ABUIListView.h"
#import "ABUIListViewCell.h"
#import "ABUIListReusableView.h"
//#import "UIView+AB.h"
#import "ABUIListViewMapping.h"
#import <MJRefresh/MJRefresh.h>
#import "ABUIListViewFlowLayout.h"
#import "ABUITips.h"
#import "ABUIListViewHorizontalLayout.h"
#import "ABUISeatView.h"
static void *contentSizeContext = &contentSizeContext;
@interface ABUIListView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) NSDictionary *fRules; ///验证表单使用
@property (nonatomic, strong) NSDictionary *css;
@property (nonatomic, strong) ABUIListViewFlowLayout *layout;

@property (nonatomic, strong) NSArray *keepOrgSectionsData; //保存原始数据，用于筛选item
@property (nonatomic, strong) ABUISeatView *seatView;
//@property (nonatomic, strong) NSMutableDictionary *rules;
//@property (nonatomic, strong) NSMutableArray *ruleSortedKeys;
@end

@implementation ABUIListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.stack = [[ABUIListViewStack alloc] init];
        self.innerStack = [[ABUIListViewStack alloc] init];
        self.cellViewMap = [[NSMutableDictionary alloc] init];
        
        self.dynamicContent = false;
        self.startDirection = StatDirectionTop;
//        self.dataList = [[NSArray alloc] init];
        self.backgroundColor = UIColor.clearColor;
//        self.layout = [[ABUIListViewFlowLayout alloc] init];
        self.layout = [[ABUIListViewFlowLayout alloc] init];
        self.layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.layout.estimatedItemSize = CGSizeZero;
        
        [self initCollectionView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame configure:(ABUIListViewConfigure *)configure {
    self = [super initWithFrame:frame];
    if (self) {
        self.stack = [[ABUIListViewStack alloc] init];
        self.innerStack = [[ABUIListViewStack alloc] init];
        self.cellViewMap = [[NSMutableDictionary alloc] init];
        
        self.dynamicContent = false;
        self.startDirection = StatDirectionTop;
//        self.dataList = [[NSArray alloc] init];
        self.backgroundColor = UIColor.clearColor;
        if (configure.layout == nil) {
            self.layout = [[ABUIListViewFlowLayout alloc] initWithType:configure.layoutType];
            self.layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
            self.layout.estimatedItemSize = CGSizeZero;
        }else{
            self.layout = configure.layout;
        }
        
        [self initCollectionView];
        
        if (configure.enableMove) {
            UILongPressGestureRecognizer *longPresssGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressMethod:)];
            [self.collectionView addGestureRecognizer:longPresssGes];
        }
    }
    return self;
}

- (void)initCollectionView {
    self.collectionView = [[ABUICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
    self.collectionView.alwaysBounceVertical = true;
    if (@available(iOS 13.0, *)) {
        [self.collectionView setAutomaticallyAdjustsScrollIndicatorInsets:false];
    } else {
        // Fallback on earlier versions
    }
    if (@available(iOS 11.0, *)) {
        self.collectionView.scrollIndicatorInsets = self.collectionView.contentInset;
        [self.collectionView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    } else {
        // Fallback on earlier versions
    }
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.collectionView.backgroundColor = UIColor.clearColor;
    [self registerCollectionViewClass];
    [self listenCollectionViewContentSize];
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(listView:moveItemAtIndexPath:toIndexPath:)]) {
        [self.delegate listView:self moveItemAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    }
}

- (void)longPressMethod:(UILongPressGestureRecognizer *)longPressGes {
    CGPoint point = [longPressGes locationInView:longPressGes.view];
    // 判断手势状态
    switch (longPressGes.state) {
            
        case UIGestureRecognizerStateBegan: {
            
            // 判断手势落点位置是否在路径上(长按cell时,显示对应cell的位置,如path = 1 - 0,即表示长按的是第1组第0个cell). 点击除了cell的其他地方皆显示为null
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longPressGes locationInView:self.collectionView]];
            // 如果点击的位置不是cell,break
            if (nil == indexPath) {
                break;
            }
            // 在路径上则开始移动该路径上的cell
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
            
        case UIGestureRecognizerStateChanged:
            // 移动过程当中随时更新cell位置
            [self.collectionView updateInteractiveMovementTargetPosition:point];
            break;
            
        case UIGestureRecognizerStateEnded:
            // 移动结束后关闭cell移动
            [self.collectionView endInteractiveMovement];
            break;
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}

- (void)setupPullRefresh {
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(onPullRefresh)];
}

- (void)onPullRefresh {
    self.isPullRefreshing = true;
    [self.collectionView.mj_footer resetNoMoreData];
    [self.collectionView.mj_footer setHidden:false];
    if (self.delegate && [self.delegate respondsToSelector:@selector(listViewOnHeaderPullRefresh:)]) {
        [self.delegate listViewOnHeaderPullRefresh:self];
    }
}

- (void)beginPullRefreshing {
    [self.collectionView.mj_header beginRefreshing];
}
- (void)endPullRefreshing {
    self.isPullRefreshing = false;
    [self.collectionView.mj_header endRefreshing];
}

- (void)setupLoadMore {
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(onLoadMore)];
}

- (void)onLoadMore {
    self.isLoadMoreing = true;
    if (self.delegate && [self.delegate respondsToSelector:@selector(listViewOnLoadMore:)]) {
        [self.delegate listViewOnLoadMore:self];
    }
}

- (void)endLoadMore {
    self.isLoadMoreing = false;
    [self.collectionView.mj_footer endRefreshing];
}

- (void)noMoreData {
    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    [self.collectionView.mj_footer setHidden:true];
}

- (void)resetNoMoreData {
    [self.collectionView.mj_footer resetNoMoreData];
    [self.collectionView.mj_footer setHidden:false];
}

- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    _scrollDirection = scrollDirection;
    self.layout.scrollDirection = scrollDirection;
    if (scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        self.collectionView.pagingEnabled = true;
        self.collectionView.alwaysBounceHorizontal = true;
        self.collectionView.alwaysBounceVertical = false;
    }else{
        self.collectionView.alwaysBounceHorizontal = false;
        self.collectionView.alwaysBounceVertical = true;
    }
}

- (CGFloat)getValueIn:(NSDictionary *)dic key:(NSString *)key df:(CGFloat)df {
    if (dic == nil || dic[key] == nil) {
        return df;
    }
    
    NSString *value = [NSString stringWithFormat:@"%@", dic[key]];
    if ([value hasSuffix:@"%"]) {
        value = [value stringByReplacingOccurrencesOfString:@"%" withString:@""];
        return ([value floatValue]/100)*self.frame.size.width;
    }
    return [value floatValue];
}

- (UIColor *)hexColor:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6)
        return [UIColor clearColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
    
}

#pragma mark ------- attribute setting ------
- (void)setDataList:(NSArray *)dataList css:(nullable NSDictionary *)css {
    self.css = css;
    [self.seatView removeFromSuperview];
    if (dataList.count == 0 && (self.enableSeat || self.seatConfig != nil)) {
        self.seatView = [[ABUISeatView alloc] initWithFrame:self.collectionView.frame];
        self.seatView.config = self.seatConfig;
        [self.seatView.actionButton addTarget:self action:@selector(onSeatViewAction) forControlEvents:UIControlEventTouchUpInside];
//        [self.seatView addTarget:self action:@selector(onSeatViewAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.seatView];
    }
    [self.collectionView.mj_header setHidden:dataList.count == 0];
    [self.collectionView.mj_footer setHidden:dataList.count == 0];
    NSDictionary *tmpCss = [[NSDictionary alloc] init];
    if (dataList.count == 0) {
        _dataList = dataList;
        [self.collectionView reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([self.delegate respondsToSelector:@selector(listViewDidReload:)]) {
                [self.delegate listViewDidReload:self];
            }
        });
        return;
    }
    if (css != nil) {
        tmpCss = css;
    }
    if (dataList[0][@"items"] == nil) {
        _dataList = @[@{@"items":dataList, @"css":tmpCss}];
    }else{
        _dataList = dataList;
    }
    [self readForm];
    [self.collectionView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.startDirection == StatDirectionRight) {
            UIEdgeInsets inserts = self.collectionView.contentInset;
            CGFloat cha = self.collectionView.frame.size.width-self.collectionView.contentSize.width;
            if (cha <= 0) {
                cha = 0;
            }
            inserts.left = cha;
            self.collectionView.contentInset = inserts;
        }
        if ([self.delegate respondsToSelector:@selector(listViewDidReload:)]) {
            [self.delegate listViewDidReload:self];
        }
    });
}

- (void)onSeatViewAction {
    [self.seatView removeFromSuperview];
    if (self.delegate && [self.delegate respondsToSelector:@selector(listViewOnSeatButton:)]) {
        [self.delegate listViewOnSeatButton:self];
    }
}

- (void)readForm {
    if (self.formCheck) {
        self.fRules = [[NSMutableDictionary alloc] init];
        self.fRuleKeys = [[NSMutableArray alloc] init];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        NSMutableArray *sortedKeys = [[NSMutableArray alloc] init];
        NSMutableDictionary *stackDic = [[NSMutableDictionary alloc] init];
        for (NSDictionary *sectionDic in self.dataList) {
            NSArray *items = sectionDic[@"items"];
            for (NSDictionary *item in items) {
                if (item[@"itemKey"] != nil && item[@"form"] != nil) {
                    NSString *itemKey = item[@"itemKey"];
                    [sortedKeys addObject:itemKey];
                    dic[itemKey] = item[@"form"];
                    NSString *itemValueKey = item[@"itemValueKey"];
                    if (itemValueKey != nil) {
                        stackDic[itemKey] = [NSString stringWithFormat:@"%@", item[itemValueKey]];
                    }
                    
                }
            }
        }
        [self.stack setData:stackDic];
        self.fRuleKeys = sortedKeys;
        self.fRules = dic;
    }
}

- (void)setInsetBottom:(CGFloat)insetBottom {
    _insetBottom = insetBottom;
    UIEdgeInsets inserts = self.collectionView.contentInset;
    inserts.bottom = insetBottom;
    
    self.collectionView.contentInset = inserts;
}


- (void)_loadDataToView {
    
}

- (void)setDataList:(NSArray *)dataList cssModule:(nullable ABUIListViewCSS *)cssModule {
    if (cssModule == nil) {
        NSLog(@"ABUIListView set cssModule is nil, please check");
        return;
    }
    NSDictionary *css = @{
        @"item.rowSpacing":cssModule.item_rowSpacing,
        @"item.columnSpacing":cssModule.item_columnSpacing,
        @"item.size.width":cssModule.item_size_width,
        @"item.size.height":cssModule.item_size_height,
        @"footer.size.height":cssModule.footer_size_height,
        @"footer.size.width":cssModule.footer_size_width,
        @"header.size.height":cssModule.header_size_height,
        @"header.size.width":cssModule.header_size_width,
        @"section.inset.top":cssModule.section_insert_top,
        @"section.inset.left":cssModule.section_insert_left,
        @"section.inset.bottom":cssModule.section_insert_bottom,
        @"section.inset.right":cssModule.section_insert_right
    };

    [self setDataList:dataList css:css];

}

- (void)setFormRules:(NSDictionary *)rules {
    _fRules = rules;
}

- (void)setTempleteDataList:(NSArray *)dataList {
    _dataList = dataList;
    
    [self readForm];
    [self.collectionView.mj_header setHidden:dataList.count == 0];
    [self.collectionView.mj_footer setHidden:dataList.count == 0];
    
    _keepOrgSectionsData = [[NSArray alloc] initWithArray:dataList];
    [self.collectionView reloadData];
}

- (void)setBounces:(BOOL)bounces {
    self.collectionView.bounces = bounces;
}


#pragma mark ------- listen collectionview register class -------
- (void)registerCollectionViewClass {
    [self.collectionView registerClass:[ABUIListViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[ABUIListReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.collectionView registerClass:[ABUIListReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    [self addSubview:self.collectionView];
}

#pragma mark ------- listen collectionview contentsize -------
//for fix footerview position
- (void)listenCollectionViewContentSize {
    [self.collectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:contentSizeContext];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (context == contentSizeContext) {
        CGRect f = _footerView.frame;
        f.origin.y = self.collectionView.contentSize.height;
        self.footerView.frame = f;
        
        if (self.dynamicContent) {
            if ([self.delegate respondsToSelector:@selector(listView:onContentSizeChanged:)]) {
                [self.delegate listView:self onContentSizeChanged:self.collectionView.contentSize];
            }
        }
    }
}


#pragma mark ------- set headerview and footerview ---------
- (void)setHeaderView:(UIView *)headerView {
    _headerView = headerView;

    UIEdgeInsets edgeInserts = self.collectionView.contentInset;
    edgeInserts.top = headerView.frame.size.height;
    self.collectionView.contentInset = edgeInserts;

    CGRect f = headerView.frame;
    f.origin.y = -headerView.frame.size.height;
    headerView.frame = f;
    [self.collectionView addSubview:headerView];
}

- (void)setFooterView:(UIView *)footerView {
    _footerView = footerView;

    UIEdgeInsets edgeInserts = self.collectionView.contentInset;
    edgeInserts.bottom = footerView.frame.size.height;
    self.collectionView.contentInset = edgeInserts;
    
    CGRect f = footerView.frame;
    f.origin.y = self.collectionView.frame.size.height;
    f.origin.x = (self.frame.size.width-footerView.frame.size.width)/2;
    footerView.frame = f;
    [self.collectionView addSubview:footerView];
}

#pragma mark ------- collectionview dataSource ----------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *items = self.dataList[section][@"items"];
    return items.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *items = self.dataList[indexPath.section][@"items"];
    NSDictionary *css = self.dataList[indexPath.section][@"css"];
    NSDictionary *item = items[indexPath.row];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(listView:editItemAtIndexPath:item:)]) {
        item = [self.dataSource listView:self editItemAtIndexPath:indexPath item:[[NSMutableDictionary alloc] initWithDictionary:item]];
    }
    NSDictionary *extDic = [[NSDictionary alloc] init];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(listView:extraDataAtIndexPath:)]) {
       extDic = [self.dataSource listView:self extraDataAtIndexPath:indexPath];
    }
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(listView:extraDataAtIndexPath:item:)]) {
       extDic = [self.dataSource listView:self extraDataAtIndexPath:indexPath item:item];
    }
    NSMutableDictionary *dd = [[NSMutableDictionary alloc] initWithDictionary:extDic];
    dd[@"section.css"] = css;
    ABUIListViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.total = items.count;
    NSString *native_id = [[ABUIListViewMapping shared] classString:item[@"native_id"]];
    cell.ppx = self;
    cell.stack = self.stack;
    cell.innerStack = self.innerStack;
    [cell reload:item extra:dd clsStr:native_id];
    return cell;
}

#pragma mark ------- collectionview delegate ----------
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat top = [self getValueIn:self.dataList[section][@"css"] key:@"section.inset.top" df:0];
    CGFloat left = [self getValueIn:self.dataList[section][@"css"] key:@"section.inset.left" df:0];
    CGFloat bottom = [self getValueIn:self.dataList[section][@"css"] key:@"section.inset.bottom" df:0];
    CGFloat right = [self getValueIn:self.dataList[section][@"css"] key:@"section.inset.right" df:0];
    return UIEdgeInsetsMake(top, left,bottom,right);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(listView:didSelectItemAtIndexPath:item:)]) {
        NSArray *items = self.dataList[indexPath.section][@"items"];
        NSDictionary *item = items[indexPath.row];
        [self.delegate listView:self didSelectItemAtIndexPath:indexPath item:item];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(listView:didSelectItemAtIndexPath:item:itemKey:)]) {
        NSArray *items = self.dataList[indexPath.section][@"items"];
        NSDictionary *item = items[indexPath.row];
        [self.delegate listView:self didSelectItemAtIndexPath:indexPath item:item itemKey:item[@"itemKey"]];
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cornerRadius = self.dataList[indexPath.section][@"css"][@"section.layer.cornerRadius"];
    if (cornerRadius != nil) {
        BOOL isFirst = (indexPath.row == 0);
        NSInteger totalRowsCount = [collectionView numberOfItemsInSection:indexPath.section];
        BOOL isLast = (indexPath.row == (totalRowsCount-1));
        [self corner:UIRectCornerBottomRight|UIRectCornerBottomLeft|UIRectCornerTopRight|UIRectCornerTopLeft radii:0 v:cell];
        if (totalRowsCount == 1) {
            [self corner:UIRectCornerBottomRight|UIRectCornerBottomLeft|UIRectCornerTopRight|UIRectCornerTopLeft radii:[cornerRadius intValue] v:cell];
        }
        else if (isFirst) {
            [self corner:UIRectCornerTopRight|UIRectCornerTopLeft radii:[cornerRadius intValue] v:cell];
        }
        else if (isLast) {
            [self corner:UIRectCornerBottomRight|UIRectCornerBottomLeft radii:[cornerRadius intValue] v:cell];
        }
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return [self getValueIn:self.dataList[section][@"css"] key:@"item.rowSpacing" df:0];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return [self getValueIn:self.dataList[section][@"css"] key:@"item.columnSpacing" df:0];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    if ([self.delegate respondsToSelector:@selector(listView:sizeForItemAtIndexPath:)]) {
        return [self.delegate listView:self sizeForItemAtIndexPath:indexPath];
    }
    
    CGFloat w = [self getValueIn:self.dataList[indexPath.section][@"css"] key:@"item.size.width" df:collectionView.frame.size.width];
    CGFloat h = [self getValueIn:self.dataList[indexPath.section][@"css"] key:@"item.size.height" df:44];
    NSArray *items = self.dataList[indexPath.section][@"items"];
    NSDictionary *css = self.dataList[indexPath.section][@"css"];
    NSDictionary *item = items[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(listView:sizeForItemAtIndexPath:item:)]) {
        return [self.delegate listView:self sizeForItemAtIndexPath:indexPath item:item];
    }
    
    if ([item[@"item.size.height"] floatValue] > 0) {
        h = [item[@"item.size.height"] floatValue];
    }
    if ([item[@"item.size.width"] floatValue] > 0) {
        w = [item[@"item.size.width"] floatValue];
    }
    
    if (item[@"_identifier"] != nil) {
        NSString *_identifier = item[@"_identifier"];
        NSDictionary *dic = [self.innerStack get:_identifier];
        if (dic[@"height"] != nil) {
            h = [dic[@"height"] floatValue];
        }
    }
    if (w == self.frame.size.width) {
        w = w-[css[@"section.inset.left"] floatValue]-[css[@"section.inset.right"] floatValue];
    }
    return CGSizeMake(floor(w), floor(h));
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *sectionDic = self.dataList[indexPath.section];
    ABUIListReusableView *view;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        NSDictionary *item = sectionDic[@"header"];
        NSDictionary *css = sectionDic[@"css"];
        view.section = indexPath.section;
        view.backgroundColor = [self hexColor:css[@"header.backgroundColor"]];
        view.ppx = self;
        [view reload:item clsStr:[[ABUIListViewMapping shared] classString:item[@"native_id"]]];
    }
    else {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        view.ppx = self;
        view.section = indexPath.section;
        NSDictionary *item = sectionDic[@"footer"];
        NSDictionary *css = sectionDic[@"css"];
        view.backgroundColor = [self hexColor:css[@"footer.backgroundColor"]];
        [view reload:item clsStr:[[ABUIListViewMapping shared]  classString:item[@"native_id"]]];
    }
    return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGFloat w = [self getValueIn:self.dataList[section][@"css"] key:@"header.size.width" df:0];
    CGFloat h = [self getValueIn:self.dataList[section][@"css"] key:@"header.size.height" df:0];
    return CGSizeMake(w, h);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    CGFloat w = [self getValueIn:self.dataList[section][@"css"] key:@"footer.size.width" df:0];
    CGFloat h = [self getValueIn:self.dataList[section][@"css"] key:@"footer.size.height" df:0];
    return CGSizeMake(w, h);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(listViewBeginDragging:)]) {
        [self.delegate listViewBeginDragging:self];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(listViewDidScroll:offset:)]) {
        [self.delegate listViewDidScroll:self offset:scrollView.contentOffset.y];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(listViewDidScrollToBottom:)]) {
        if ([self isInBottom]) {
             [self.delegate listViewDidScrollToBottom:self];
        }
    }
    
    if ([self.headerView conformsToProtocol:@protocol(ABUIListViewHeaderViewDelegate)]) {
        id<ABUIListViewHeaderViewDelegate> h = (id<ABUIListViewHeaderViewDelegate>)self.headerView;
        if ([h respondsToSelector:@selector(onListViewScroll:)]) {
            [h onListViewScroll:scrollView.contentOffset.y+self.headerView.frame.size.height];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (decelerate == false) {
        [self scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x/scrollView.frame.size.width;
    if (self.delegate && [self.delegate respondsToSelector:@selector(listView:onPageChanged:)]) {
        [self.delegate listView:self onPageChanged:page];
    }
}

#pragma mark ------- other method -------
- (void)corner:(UIRectCorner)corners radii:(CGFloat)radii v:(UIView *)v {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(radii, radii)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    v.layer.mask = maskLayer;
}

- (void)reloadSection:(int)section {
    if (section > 0 && section < [self numberOfSectionsInCollectionView:self.collectionView]) {
        [UIView performWithoutAnimation:^{
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:section]];
        }];
        
    }
}

- (void)reloadData {
    [UIView performWithoutAnimation:^{
        [self.collectionView reloadData];
        [self.collectionView layoutIfNeeded];
        if ([self.delegate respondsToSelector:@selector(listViewDidReload:)]) {
            [self.delegate listViewDidReload:self];
        }
    }];
//    [UIView animateWithDuration:0 animations:^{
//        [UICollectionView performBatchUpdates:^{
//            [self.collectionView reloadData];
//        } completion:nil];
//    }];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.collectionView.frame = self.bounds;
}
- (void)scrollToTop:(BOOL)animated {
    [self.collectionView setContentOffset:CGPointMake(0, 0) animated:animated];
}

- (void)scrollToBottom:(BOOL)animated {
    if (self.collectionView.contentSize.height <= self.collectionView.frame.size.height) {
        return;
    }
    CGFloat y = self.collectionView.contentSize.height-self.collectionView.frame.size.height+self.collectionView.contentInset.bottom;
    [self.collectionView setContentOffset:CGPointMake(0, y) animated:animated];
}

- (BOOL)isInBottom {
    CGFloat y = self.collectionView.contentSize.height-self.collectionView.frame.size.height+self.collectionView.contentInset.bottom;
    if (y-self.collectionView.contentOffset.y < 100) {
        return true;
    }
    return false;
}

- (void)adapterSafeArea {
    UIEdgeInsets inserts = self.collectionView.contentInset;
    inserts.bottom = inserts.bottom+34;
    self.collectionView.contentInset = inserts;
}

- (UIView *)itemViewAtIndexPath:(NSIndexPath *)indexPath {
    return [self.collectionView cellForItemAtIndexPath:indexPath];
}

- (BOOL)isEmpty {
    return self.dataList.count == 0;
}

- (BOOL)isContentFull {
    return self.collectionView.contentSize.height > self.collectionView.frame.size.height;
}

- (BOOL)checkForm {
    BOOL isPass = true;
    NSString *message = @"";
    NSArray *itemKeys = self.fRuleKeys;
    for (NSString *key in itemKeys) {
        NSDictionary *rule = @{};
        if ([self.fRules[key] isKindOfClass:[NSArray class]]) {
            rule = self.fRules[key][0];
        }else{
            rule = self.fRules[key];
        }

        NSString *vv = [self.stack get:key];
        BOOL required = [rule[@"required"] boolValue];
        if (required) {
            if (vv == nil) {
                message = rule[@"message"];
                isPass = false;
                break;
            }
            if ([vv isKindOfClass:[NSString class]] && vv.length == 0) {
                message = rule[@"message"];
                isPass = false;
                break;
            }
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(listView:formCheckError:)]) {
        [self.delegate listView:self formCheckError:message];
    }
    
    [ABUITips showError:message];
    
    return isPass;

}

- (void)hotReloadSection:(int)section {
    NSMutableArray *dataSections = [[NSMutableArray alloc] init];
    for (int i=0; i<_keepOrgSectionsData.count; i++) {
        NSMutableDictionary *dataSection = [[NSMutableDictionary alloc] initWithDictionary:_keepOrgSectionsData[i]];
        NSArray *items = dataSection[@"items"];
        NSMutableArray *nItems = [[NSMutableArray alloc] init];
        for (int j=0; j<items.count; j++) {
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(listView:visableItemAtIndexPath:item:)]) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
                if ([self.dataSource listView:self visableItemAtIndexPath:indexPath item:items[j]]) {
                    [nItems addObject:items[j]];
                }
            }
        }
        dataSection[@"items"] = nItems;
        [dataSections addObject:dataSection];
    }
    
    _dataList = dataSections;
    [self.collectionView reloadData];
}

- (NSArray *)visableCells {
    return self.collectionView.visibleCells;
}

- (void)reloadUserProvide:(NSString *)itemKey {
    for (ABUIListViewCell *cell in self.collectionView.visibleCells) {
        if ([cell isKindOfClass:[ABUIListViewCell class]]) {
            if ([cell.item[@"itemKey"] isEqualToString:itemKey]) {
                [(id<ABUIListItemViewProtocol>)cell.mainView reloadUserProvideData];
            }
        }
    }
}

@end
