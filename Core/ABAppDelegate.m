//
//  ABAppDelegate.m
//  ABUIKit
//
//  Created by qp on 2021/3/1.
//  Copyright © 2021 abteam. All rights reserved.
//

#import "ABAppDelegate.h"
#import "ABUINavBar/ABUINavigationController.h"
@implementation ABAppDelegate

- (void)setUpLoginVC:(NSString *)loginVC mainVC:(NSString *)mainVC {
    self.loginClassString = loginVC;
    self.mainClassString = mainVC;
    
    [self checkSwitch];
}

- (void)checkSwitch {
    if ([self isLogin]) {
        [self switchHome];
    }else{
        [self switchLogin];
    }
}
- (void)switchLogin {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIViewController *vc = [[NSClassFromString(self.loginClassString) alloc] init];
    ABUINavigationController *nav = [[ABUINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
}

- (void)switchHome {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[NSClassFromString(self.mainClassString) alloc] init];
    [self.window makeKeyAndVisible];
}

- (BOOL)isLogin {
    return true;
}

@end
