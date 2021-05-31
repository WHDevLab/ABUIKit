//
//  ABUIListViewCell.h
//  Demo
//
//  Created by qp on 2020/5/8.
//  Copyright © 2020 ab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABUIListView.h"
#import "ABUIListViewStack.h"
#import "ABUIListViewProtocols.h"
NS_ASSUME_NONNULL_BEGIN

@interface ABUIListViewCell : UICollectionViewCell
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, weak) ABUIListView *ppx;
@property (nonatomic, weak) ABUIListViewStack *stack;
@property (nonatomic, weak) ABUIListViewStack *innerStack;
@property (nonatomic, strong) NSDictionary *item;
@property (nonatomic, strong) UIColor *separatorColor;
- (void)reload:(NSDictionary *)item extra:(nullable NSDictionary *)extra clsStr:(NSString *)clsStr;
- (void)refreshUserProvideData; //更新用户输入的数据
- (void)setUserProvideData:(id)data;
- (nullable id)userProvideData; //获取用户输入的数据
///actionkey 用于外部识别不用的按钮点击操作
- (void)sendActionWithKey:(NSString *)actionKey actionData:(nullable id)actionData;
- (void)sendActionWithData:(nullable id)actionData forKey:(NSString *)actionKey;
- (void)changeHeight:(CGFloat)height;
- (void)changeHeightIfNeed:(CGFloat)height;
- (void)save:(id)value forKey:(NSString *)key;
- (id)get:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
