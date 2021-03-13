//
//  ABUITabBarViewController.m
//  ABUIKit
//
//  Created by qp on 2020/9/24.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUITabBarViewController.h"
#import "ABUINavigationController.h"
#import "ABUIColor.h"
#import "ABDefines.h"
#import "UIImage+AB.h"
#import "UIColor+AB.h"
#import "NSObject+Language.h"
@interface ABUITabBarViewController ()

@end

@implementation ABUITabBarViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.titleNormalColor = [UIColor hexColor:@"999999"];
    self.titleSelectColor = [UIColor redColor];
}
- (void)setUpChildsWithItems:(NSArray<ABUITabBarItem *> *)items {
    for (ABUITabBarItem *item in items) {
        //parse data from item
        NSString *module = item.module;
        NSString *title = item.title;
        NSString *nmIconName = item.icon_nm;
        NSString *hlIconName = item.icon_hl;
        NSDictionary *navDic = nil;
        
        //dynmic load vc from module name
        UIViewController *vc = [[NSClassFromString(module) alloc] init];
        vc.title = title;
        ABUINavigationController *nav = [[ABUINavigationController alloc] initWithRootViewController:vc];
        nav.titleFont = item.navTitleFont;
//        nav.navigationBar.barStyle = UIBarStyleDefault;
//        nav.navigationBar.translucent = YES;
//        nav.navigationBar.tintColor = nil;

    
        //create image from image name
        UIImage *nmImage = [[UIImage imageNamed:nmIconName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *hlImage = [[UIImage imageNamed:hlIconName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:nmImage selectedImage:hlImage];
        tabBarItem.langKey = item.langKey;
        nav.tabBarItem = tabBarItem;
        [nav.navigationBar setBackgroundImage:[UIImage imageWithColor:item.navColor] forBarMetrics:UIBarMetricsDefault];
        
//        if (navDic != nil) {
//            NSMutableArray *colors = [[NSMutableArray alloc] init];
//            NSArray *bgcolors = navDic[@"bgcolors"];
//            for (NSString *colorhex in bgcolors) {
//                [colors addObject:(__bridge id)[ABUIColor hexColor:colorhex].CGColor];
//            }
//            [nav.navigationBar setBackgroundImage:[UIImage imageWithGradientColors:colors frame:CGRectMake(0, 0, self.view.frame.size.width, STATUS_AND_NAV_BAR_HEIGHT)] forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
//        }else{
//            [nav.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor hexColor:@"f3f3f2"] frame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_AND_NAV_BAR_HEIGHT)] forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
//        }
        //append to childs
        [self addChildViewController:nav];
    }
    
    [self configTabBar];
}


- (void)configTabBar{
//    self.zbTabBar = [ZBTabBar new];
//    self.zbTabBar.delegatee = self;
//    [self setValue:self.zbTabBar forKey:@"tabBar"];
    
    if (@available(iOS 13.0, *)) {
//        UITabBarAppearance *tabBarAppearance = [[UITabBarAppearance alloc] init];
//        tabBarAppearance.backgroundImage = [UIImage imageWithColor:UIColor.clearColor];
//        tabBarAppearance.shadowImage = [UIImage imageWithColor:UIColor.clearColor];
//        self.tabBar.standardAppearance = tabBarAppearance;
        
        self.tabBar.standardAppearance.backgroundImage = [UIImage imageWithColor:UIColor.whiteColor];
        self.tabBar.standardAppearance.shadowImage = [UIImage imageWithColor:UIColor.whiteColor];
        self.tabBar.unselectedItemTintColor = self.titleNormalColor;
    } else {
        [UITabBar appearance].backgroundImage = [UIImage new];
        [UITabBar appearance].shadowImage = [UIImage new];
    }


    [UITabBar appearance].backgroundColor = UIColor.whiteColor;
    [UITabBar appearance].tintColor = self.titleSelectColor;

    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:self.titleNormalColor} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:self.titleSelectColor} forState:UIControlStateSelected];

    self.tabBar.translucent = false;
    self.tabBar.layer.shadowColor = [[UIColor hexColor:@"3A4C82"] CGColor];
    self.tabBar.layer.shadowOpacity = 0.07;
    self.tabBar.layer.shadowOffset = CGSizeMake(0, -19);
    self.tabBar.layer.shadowRadius = 38;
}

@end
