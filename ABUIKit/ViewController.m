//
//  ViewController.m
//  ABUIKit
//
//  Created by qp on 2020/5/21.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ViewController.h"
#import "ABUIWebViewController.h"
#import "ABUITextField.h"
#import "UIColor+AB.h"
#import "ABUICodeInput.h"
#import "UIView+AB.h"
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
    
    
    ABUITextField *textField = [[ABUITextField alloc] initWithFrame:CGRectMake(25,110, 200, 46)];
    textField.backgroundColor = [UIColor whiteColor];
    textField.font = [UIFont systemFontOfSize:16];
    textField.placeholder = @"请输入您的手机号";
    textField.placeholderColor = [UIColor hexColor:@"#8E8E8E"];
    textField.font = [UIFont systemFontOfSize:13];
    textField.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.06].CGColor;
    textField.layer.shadowOffset = CGSizeMake(0,1);
    textField.layer.shadowOpacity = 1;
    textField.layer.shadowRadius = 12;
    textField.layer.cornerRadius = 9.6;
    [self.view addSubview:textField];
    
    ABUICodeInput *codeInput = [[ABUICodeInput alloc] initWithFrame:CGRectMake(15, textField.bottom+20, self.view.frame.size.width-30, 60)];
    codeInput.titleLabel.text = @"验证码";
    codeInput.textField.placeholder = @"请输入验证码";
    [self.view addSubview:codeInput];
    [codeInput addLineDirection:LineDirectionBottom color:[UIColor colorWithRed:228/255.0 green:227/255.0 blue:228/255.0 alpha:1.0] width:1];
    
}


- (void)gotoWeb {
    ABUIWebViewController *vc = [[ABUIWebViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}

@end
