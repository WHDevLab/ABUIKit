//
//  AppDelegate.m
//  ABUIKit
//
//  Created by qp on 2020/5/21.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ABUINavigationController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[ABUINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    [self.window makeKeyAndVisible];
    return YES;
}
@end
