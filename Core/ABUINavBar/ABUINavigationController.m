//
//  ABUINavigationController.m
//  ABUIKit
//
//  Created by qp on 2020/9/24.
//  Copyright © 2020 abteam. All rights reserved.
// 暗黑模式下，导航栏会变成黑色，关闭暗黑模式

#import "ABUINavigationController.h"

#import "ABUINavigationController.h"
#import "ABUIColor.h"
#import "UIViewController+AB.h"

@interface ABUINavigationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UIView *navBarHairlineView;
@property (nonatomic, strong) UIImageView *navBarHairlineImageView;

@end

@implementation ABUINavigationController

//- (UIView *)navBarHairlineView
//{
//    if (!_navBarHairlineView) {
//        _navBarHairlineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
//        _navBarHairlineView.backgroundColor = [UIColor hexColor:@"cecece"];
//    }
//    return _navBarHairlineView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleColor = [UIColor blackColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.delegate = self;
    //添加手势管理
    self.interactivePopGestureRecognizer.delegate = self;
    self.navigationBar.opaque = NO;
    self.navigationBar.translucent = NO;

    [_navBarHairlineImageView setHidden:true];
    [self.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
//    [navBarHairlineImageView addSubview:self.navBarHairlineView];
    
    self.navigationBar.translucent = false;
    
    self.titleFont = [UIFont boldSystemFontOfSize:16];
}

- (UIImageView *)navBarHairlineImageView {
    if (_navBarHairlineImageView == nil) {
        _navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationBar];
        return _navBarHairlineImageView;
    }
    return _navBarHairlineImageView;
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    
    return nil;
    
}
/**
 *  当第一次使用这个类的时候调用1次
 */
+ (void)initialize
{
    // 设置UINavigationBarTheme的主
    [self setupNavigationBarTheme];
    
    // 设置UIBarButtonItem的主题
    [self setupBarButtonItemTheme];
    
}

/**
 *  设置UINavigationBarTheme的主题
 */
+ (void)setupNavigationBarTheme{
    //获取全局的 UINavigationBar
    UINavigationBar *appearance = [UINavigationBar appearance];
//    appearance.opaque = NO;
//    appearance.translucent = NO;
    
    // 设置导航栏背景
//    [appearance setBarTintColor:[UIColor hexColor:@"ffffff"]];
    [appearance setTintColor:[UIColor redColor]];
    
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:16];
    [appearance setTitleTextAttributes:textAttrs];
}

/**
 *  设置UIBarButtonItem的主题
 */
+ (void)setupBarButtonItemTheme{
    // 通过appearance对象能修改整个项目中所有UIBarButtonItem的样式
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    
    /**设置文字属性**/
    // 设置普通状态的文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [ABUIColor hexColor:@"30331"];
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:16];
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置不可用状态(disable)的文字属性
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [appearance setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [self.navBarHairlineImageView setHidden:true];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    if (self.viewControllers.count>=1) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 64, 44)];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [btn setImage:[ABUINavigationConfig shared].backImage forState:UIControlStateNormal];
        btn.adjustsImageWhenHighlighted = NO;
        [btn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
        
        [self updateNavStatus:viewController backButton:btn];
        
        UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
        
        viewController.navigationItem.leftBarButtonItem = bar;

    }
    [self updateNavStatus:viewController backButton:nil];
    [super pushViewController:viewController animated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    if (navigationController.viewControllers.count==1) {
        navigationController.interactivePopGestureRecognizer.enabled = NO;
        navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    [self updateNavStatus:viewController backButton:nil];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [self setNavigationBarHidden:viewController.isVisableNavigationBar == false animated:true];
    
//    // 设置文字属性
//    if ([viewController preferredStatusBarStyle] == UIStatusBarStyleLightContent) {
//        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//        textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//        textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:16];
//        [navigationController.navigationBar setTitleTextAttributes:textAttrs];
//    }else{
//        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//        textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
//        textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:16];
//        [navigationController.navigationBar setTitleTextAttributes:textAttrs];
//    }
//    [self updateNavStatus:viewController backButton:nil];
    
}

- (void)updateNavStatus:(UIViewController *)vc backButton:(UIButton *)btn {
    if (self.titleFont == nil) {
        self.titleFont = [UIFont boldSystemFontOfSize:16];
    }
    if (vc.isVisableNavigationBar) {
        if (vc.preferredStatusBarStyle == UIStatusBarStyleLightContent) {
            [btn setImage:[ABUINavigationConfig shared].whiteBackImage forState:UIControlStateNormal];
            self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: UIColor.whiteColor, NSFontAttributeName:self.titleFont};
        }
        else{
            [btn setImage:[ABUINavigationConfig shared].backImage forState:UIControlStateNormal];
            self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: UIColor.blackColor, NSFontAttributeName:self.titleFont};
        }
        
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    [self updateNavStatus:self.topViewController backButton:nil];
    return self.topViewController.preferredStatusBarStyle;
}

- (void)pop{
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
