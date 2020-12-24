//
//  ABUITabBarItem.h
//  ABUIKit
//
//  Created by qp on 2020/9/24.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABUITabBarItem : NSObject
@property (nonatomic, strong) NSString *module;
@property (nonatomic, strong) NSString *icon_nm;
@property (nonatomic, strong) NSString *icon_hl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *navColor;
@property (nonatomic, strong) UIFont *navTitleFont;
@end

NS_ASSUME_NONNULL_END
