//
//  ABTitleHeaderItemView.h
//  ABUIKit
//
//  Created by qp on 2020/9/30.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABUIListViewProtocols.h"
NS_ASSUME_NONNULL_BEGIN

@interface ABTitleHeaderItemView : UIView<ABUIListItemViewProtocol>
@property (nonatomic, strong) UILabel *titleLabel;
@end

NS_ASSUME_NONNULL_END
