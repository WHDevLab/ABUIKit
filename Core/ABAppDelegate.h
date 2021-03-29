//
//  ABAppDelegate.h
//  ABUIKit
//
//  Created by qp on 2021/3/1.
//  Copyright © 2021 abteam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABAppDelegate : UIResponder
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) NSString *loginClassString;
@property (nonatomic, strong) NSString *mainClassString;

- (void)setUpLoginVC:(NSString *)loginVC mainVC:(NSString *)mainVC;
- (BOOL)isLogin;
- (void)checkSwitch;
@end

NS_ASSUME_NONNULL_END 
