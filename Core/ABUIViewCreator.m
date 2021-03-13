//
//  ABUIViewCreator.m
//  ABUIKit
//
//  Created by qp on 2021/3/11.
//  Copyright © 2021 abteam. All rights reserved.
//

#import "ABUIViewCreator.h"

@implementation ABUIViewCreator
+ (ABUIViewCreator *)shared {
    static ABUIViewCreator *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


+ (UIButton *)createButtonWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize isBold:(BOOL)isBold {
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    if (isBold) {
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    }else{
        btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    
    return btn;
}

+ (UIButton *)createButtonWithImageName:(NSString *)imageName {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    return btn;
}


+ (ABUITextField *)createShadowInput {
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    ABUITextField *textField = [[ABUITextField alloc] initWithFrame:CGRectMake(25,0, screenW-50, 46)];
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
    return textField;
}

@end
