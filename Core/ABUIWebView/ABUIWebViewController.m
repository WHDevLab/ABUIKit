//
//  ABUIWebViewController.m
//  ABUIKit
//
//  Created by qp on 2020/12/16.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIWebViewController.h"
#import "ABUIWebView.h"
#import "UIViewController+AB.h"
@interface ABUIWebViewController ()<ABUIWebViewDelegate>
@property (nonatomic, strong) ABUIWebView *webView;
@end

@implementation ABUIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.statusBarStyle = UIStatusBarStyleDefault ;
    self.title = @"加载中";
    self.webView = [[ABUIWebView alloc] initWithFrame:self.view.bounds adjustMobile:false];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;

    if (self.path) {
        [self.webView loadWebWithPath:self.path];
    }else{
        [self.webView loadWebWithPath:self.props[@"path"]];
    }
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.webView.frame = self.view.bounds;
}

- (void)abwebview:(ABUIWebView *)abwebview onTitleLoaded:(NSString *)string {
    self.title = string;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.statusBarStyle;
}
@end
