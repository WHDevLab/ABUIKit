//
//  ABUITabBarController.m
//  Demo
//
//  Created by qp on 2020/5/6.
//  Copyright © 2020 ab. All rights reserved.
//

#import "ABUITabBarController.h"
#import "ABUINavigationController.h"
#import "ABUIColor.h"
#import "ABDefines.h"
#import "UIImage+AB.h"
#import "UIColor+AB.h"
@interface ABUITabBarController ()

@end

@implementation ABUITabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setUpChildsFromConfig:(NSDictionary *)config {
    NSArray *list = config[@"data"];
    for (NSDictionary *item in list) {
        
        //parse data from item
        NSString *module = item[@"module"];
        NSString *title = item[@"title"];
        NSString *nmIconName = item[@"icon"];
        NSString *hlIconName = item[@"icon_h"];
        NSDictionary *navDic = item[@"nav"];
        
        //dynmic load vc from module name
        UIViewController *vc = [[NSClassFromString(module) alloc] init];
        vc.title = title;
        ABUINavigationController *nav = [[ABUINavigationController alloc] initWithRootViewController:vc];
    
        //create image from image name
        UIImage *nmImage = [[UIImage imageNamed:nmIconName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *hlImage = [[UIImage imageNamed:hlIconName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:nmImage selectedImage:hlImage];
        nav.tabBarItem = tabBarItem;
        
        
        
        
        if (navDic != nil) {
            NSMutableArray *colors = [[NSMutableArray alloc] init];
            NSArray *bgcolors = navDic[@"bgcolors"];
            for (NSString *colorhex in bgcolors) {
                [colors addObject:(__bridge id)[ABUIColor hexColor:colorhex].CGColor];
            }
            [nav.navigationBar setBackgroundImage:[UIImage imageWithGradientColors:colors frame:CGRectMake(0, 0, self.view.frame.size.width, STATUS_AND_NAV_BAR_HEIGHT)] forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
        }else{
            [nav.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor hexColor:@"f3f3f2"] frame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_AND_NAV_BAR_HEIGHT)] forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
        }
        //append to childs
        [self addChildViewController:nav];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
