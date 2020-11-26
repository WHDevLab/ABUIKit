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
NS_ASSUME_NONNULL_BEGIN

@interface ABUIListViewCell : UICollectionViewCell
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, weak) ABUIListView *ppx;
@property (nonatomic, weak) ABUIListViewStack *stack;
- (void)reload:(NSDictionary *)item extra:(nullable NSDictionary *)extra clsStr:(NSString *)clsStr;
- (void)refreshUserProvideData; //更新用户输入的数据
- (nullable id)userProvideData; //获取用户输入的数据
- (void)sendActionWithKey:(NSString *)actionKey actionData:(nullable id)actionData;
@end

NS_ASSUME_NONNULL_END
