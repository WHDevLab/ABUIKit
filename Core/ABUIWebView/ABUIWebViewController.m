//
//  ABUIWebViewController.m
//  ABUIKit
//
//  Created by qp on 2020/12/16.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIWebViewController.h"
#import "ABUIWebView.h"
@interface ABUIWebViewController ()<ABUIWebViewDelegate>
@property (nonatomic, strong) ABUIWebView *webView;
@end

@implementation ABUIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webView = [[ABUIWebView alloc] initWithFrame:self.view.bounds adjustMobile:false];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;

    [self.webView loadWebWithPath:self.path];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.webView.frame = self.view.bounds;
}

- (void)abwebview:(ABUIWebView *)abwebview onTitleLoaded:(NSString *)string {
    self.title = string;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
@end
