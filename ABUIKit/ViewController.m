//
//  ViewController.m
//  ABUIKit
//
//  Created by qp on 2020/5/21.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 100)];
    [btn setTitle:@"web" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(gotoWeb) forControlEvents:UIControlEventTouchUpInside];
}


- (void)gotoWeb {
    WebViewController *vc = [[WebViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}

@end
