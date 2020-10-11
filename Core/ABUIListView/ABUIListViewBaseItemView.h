//
//  ABUIListViewBaseItemView.h
//  ABUIKit
//
//  Created by qp on 2020/10/9.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABUIListViewProtocols.h"
#import "ABUIListViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface ABUIListViewBaseItemView : UIView<ABUIListItemViewProtocol>
@property (nonatomic, weak) ABUIListViewCell *cell;
@end

NS_ASSUME_NONNULL_END
