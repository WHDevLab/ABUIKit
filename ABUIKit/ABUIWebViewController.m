//
//  WebViewController.m
//  ABUIKit
//
//  Created by qp on 2020/6/18.
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
    
    self.webView = [[ABUIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-115, self.view.frame.size.height-300, 100, 100)];
    [btn setTitle:@"xxx" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.webView loadWebWithPath:[NSBundle.mainBundle pathForResource:@"web" ofType:@"html"]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.webView.frame = self.view.bounds;
}

- (void)abwebview:(ABUIWebView *)abwebview onTitleLoaded:(NSString *)string {
    self.title = string;
}

- (void)abwebview:(ABUIWebView *)abwebview onReceiveMessage:(NSDictionary *)message {
    NSData *data = [NSJSONSerialization dataWithJSONObject:message options:NSJSONWritingPrettyPrinted error:nil];
    NSString *ss = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"收到消息" message:ss delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)btnAction {
    [self.webView callFuncName:@"append" data:@"nihao" completionHandler:^(id data, NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"%@", data);
        }else{
            NSLog(@"%@", error);
        }
    }];
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
