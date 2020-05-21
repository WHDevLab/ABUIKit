//
//  UIViewController+AB.h
//  Demo
//
//  Created by qp on 2020/5/6.
//  Copyright © 2020 ab. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (AB)
@property (nonatomic, assign) BOOL isVisableNavigationBar;
@property (nonatomic, weak) UIViewController *parent;
@property (nonatomic, strong) NSDictionary *props;
@end

NS_ASSUME_NONNULL_END
