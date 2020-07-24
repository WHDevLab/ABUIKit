//
//  ABUIListViewProtocols.h
//  zhifu
//
//  Created by qp on 2020/5/14.
//  Copyright © 2020 qp. All rights reserved.
//

#ifndef ABUIListViewProtocols_h
#define ABUIListViewProtocols_h

@protocol ABUIListItemViewProtocol
@optional
//创建内容
- (void)setupAdjustContents;
//布局内容
- (void)layoutAdjustContents;
//设置数据
- (void)reload:(NSDictionary *)item;
- (void)reload:(NSDictionary *)item extra:(NSDictionary *)extra indexPath:(NSIndexPath *)indexPath;
- (void)setHighlighted:(BOOL)highlighted;

@end

#endif /* ABUIListViewProtocols_h */
