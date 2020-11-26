//
//  ABUIChatItemBaseView.h
//  ABUIKit
//
//  Created by qp on 2020/11/2.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIListViewBaseItemView.h"
#import "UIView+AB.h"
#import "UIColor+AB.h"
#import "UIFont+AB.h"
#import "ABUILabel.h"
#import "ABUIChatHelper.h"
#import "ABUITips.h"
NS_ASSUME_NONNULL_BEGIN

@interface ABUIChatItemBaseView : ABUIListViewBaseItemView
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) NSDictionary *item;
- (BOOL)isLeft;
@end

NS_ASSUME_NONNULL_END
