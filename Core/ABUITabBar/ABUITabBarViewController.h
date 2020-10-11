//
//  ABUITabBarViewController.h
//  ABUIKit
//
//  Created by qp on 2020/9/24.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABUITabBarItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface ABUITabBarViewController : UITabBarController
@property (nonatomic, strong) UIColor *titleNormalColor;
@property (nonatomic, strong) UIColor *titleSelectColor;
- (void)setUpChildsWithItems:(NSArray<ABUITabBarItem *> *)items;
@end

NS_ASSUME_NONNULL_END
