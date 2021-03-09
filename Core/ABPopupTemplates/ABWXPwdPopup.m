//
//  ABWXPwdPopup.m
//  ABUIKit
//
//  Created by qp on 2021/3/8.
//  Copyright © 2021 abteam. All rights reserved.
//

#import "ABWXPwdPopup.h"
#import <Foundation/Foundation.h>
#import "UIView+AB.h"
#import "UIColor+AB.h"
#import "UIFont+AB.h"
#define JnDotCount 6

@implementation ABWXPwdRawItem

+(void)load {
    [[ABUIListViewMapping shared] registerClassString:@"ABWXPwdRawItem" native_id:@"wxinfoitem"];
}
- (void)setupAdjustContents {
    self.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont PingFangSC:12];
    self.titleLabel.textColor = [UIColor hexColor:@"#B5B7C0"];
    [self addSubview:self.titleLabel];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.contentLabel.font = [UIFont PingFangSCBlod:12];
    self.contentLabel.textColor = [UIColor hexColor:@"#272727"];
    [self addSubview:self.contentLabel];
}

- (void)layoutAdjustContents {
    self.titleLabel.left = 0;
    self.contentLabel.left = self.width-self.contentLabel.width;
    
    self.titleLabel.centerY = self.height/2;
    self.contentLabel.centerY = self.height/2;
}

- (void)reload:(NSDictionary *)item {
    self.titleLabel.text = item[@"title"];
    [self.titleLabel sizeToFit];
    
    self.contentLabel.text = item[@"content"];
    [self.contentLabel sizeToFit];
}

@end

@implementation ABWXPwdPopupConfig
+ (ABWXPwdPopupConfig *)defaultConfig {
    ABWXPwdPopupConfig *config = [[ABWXPwdPopupConfig alloc] init];
    config.pwdCount = 6;
    config.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    config.dotSize = CGSizeMake(10, 10);
    config.title = @"请输入支付密码";
    config.content = @"上架金额";
    config.money = 0;
    config.supplys = @[
        @{@"title":@"兑换美元USD金鹅", @"content":@"$6233"},
        @{@"title":@"汇率", @"content":@"6.5"}
    ];
    return config;
}
@end

@implementation ABWXPwdView
- (instancetype)initWithFrame:(CGRect)frame config:(ABWXPwdPopupConfig *)config
{
    self = [super initWithFrame:frame];
    if (self) {
        self.config = config;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
        self.titleLabel.text = config.title;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        self.titleLabel.textColor = [UIColor blackColor];
        [self addSubview:self.titleLabel];
        
        self.closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [self.closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [self addSubview:self.closeButton];
        
        self.desLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 65, self.frame.size.width, 20)];
        self.desLabel.text = config.content;
        self.desLabel.font = [UIFont systemFontOfSize:16];
        self.desLabel.textAlignment = NSTextAlignmentCenter;
        self.desLabel.textColor = [UIColor blackColor];
        [self addSubview:self.desLabel];
        
        
        self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 102, self.frame.size.width, 40)];
        self.moneyLabel.text = [NSString stringWithFormat:@"¥%.2f", config.money];
        self.moneyLabel.textAlignment = NSTextAlignmentCenter;
        self.moneyLabel.font = [UIFont boldSystemFontOfSize:30];
        self.moneyLabel.textColor = [UIColor blackColor];
        [self addSubview:self.moneyLabel];
        
        self.infoListView = [[ABUIListView alloc] initWithFrame:CGRectMake(10, self.moneyLabel.bottom+10, self.width-20, 30*config.supplys.count)];
        self.infoListView.userInteractionEnabled = false;
        self.infoListView.backgroundColor = [UIColor whiteColor];
        [self.infoListView addLineDirection:LineDirectionTop color:config.borderColor width:1];
        [self addSubview:self.infoListView];
        
        NSMutableArray *nSupplys = [[NSMutableArray alloc] init];
        for (NSDictionary *item in config.supplys) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:item];
            dic[@"native_id"] = @"wxinfoitem";
            [nSupplys addObject:dic];
        }
        
        [self.infoListView setDataList:nSupplys css:@{
            @"item.size.height":@(30)
        }];
        
        self.inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, self.infoListView.bottom+10, self.frame.size.width-20, 44)];
        self.inputTextField.backgroundColor = [UIColor whiteColor];
        //输入的文字颜色为白色
        self.inputTextField.textColor = [UIColor whiteColor];
        //输入框光标的颜色为白色
        self.inputTextField.tintColor = [UIColor whiteColor];
        self.inputTextField.delegate = self;
        self.inputTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.inputTextField.keyboardType = UIKeyboardTypeNumberPad;
        [self.inputTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:self.inputTextField];
        self.height = self.inputTextField.bottom+20;
        
        self.inputTextFieldWrapper = [[UIView alloc] initWithFrame:self.inputTextField.frame];
        self.inputTextFieldWrapper.layer.borderColor = self.config.borderColor.CGColor;
        self.inputTextFieldWrapper.layer.borderWidth = 1;
        self.inputTextFieldWrapper.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.inputTextFieldWrapper];
        
        //每个密码输入框的宽度
        CGFloat width = self.inputTextField.frame.size.width / config.pwdCount;
        //生成分割线
        for (int i = 0; i < config.pwdCount; i++) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(i*width, 0, 1, 44)];
            lineView.backgroundColor = self.config.borderColor;
            [self.inputTextFieldWrapper addSubview:lineView];
        }
        
        
        self.dotArray = [[NSMutableArray alloc] init];
        //生成中间的点
        for (int i = 0; i < config.pwdCount; i++) {
            UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(i*width+width/2-config.dotSize.width/2, self.inputTextField.frame.size.height/2-config.dotSize.height/2, config.dotSize.width, config.dotSize.height)];
            dotView.backgroundColor = [UIColor blackColor];
            dotView.layer.cornerRadius = config.dotSize.height/2;
            dotView.clipsToBounds = YES;
            dotView.tag = i;
            dotView.hidden = YES; //先隐藏
            [self.inputTextFieldWrapper addSubview:dotView];
            //把创建的黑色点加入到数组中
            [self.dotArray addObject:dotView];
        }
    }
    return self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"]) {
        //按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    } else if(string.length == 0) {
        //判断是不是删除键
        
        return YES;
    }else if(textField.text.length >= 6) {
        //输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
        //NSLog(@"输入的字符个数大于6，忽略输入");
        return NO;
    } else {
        return YES;
    }
}

/**
 *  重置显示的点
 */
- (void)textFieldDidChange:(UITextField *)textField
{
    for (UIView *dotView in self.dotArray) {
        dotView.hidden = YES;
    }
    for (int i = 0; i < textField.text.length; i++) {
        ((UIView *)[self.dotArray objectAtIndex:i]).hidden = NO;
    }
    if (textField.text.length == 6) {
        [self.inputTextField resignFirstResponder];
        if (self.delegate && [self.delegate respondsToSelector:@selector(abwxpwdpopupFinished:)]) {
            [self.delegate abwxpwdpopupFinished:textField.text];
        }
    }
    
}




@end

@implementation ABWXPwdPopup

+ (instancetype)shared {
    static ABWXPwdPopup *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ABWXPwdPopup alloc] initWithConfig:nil];
    });
    return instance;
}

- (instancetype)initWithConfig:(ABWXPwdPopupConfig *)config
{
    self = [super init];
    if (self) {
        if (config == nil) {
            self.config = [ABWXPwdPopupConfig defaultConfig];
        }else{
            self.config = config;
        }
        self.maskView = [[UIView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        self.maskView.backgroundColor = [UIColor blackColor];
        self.maskView.alpha = 0.3;
        
        
        self.contentView = [[ABWXPwdView alloc] initWithFrame:CGRectMake(30, 100, self.maskView.frame.size.width-60, 250) config:self.config];
        self.contentView.layer.cornerRadius = 8;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView.closeButton addTarget:self action:@selector(onClose) forControlEvents:UIControlEventTouchUpInside];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
    }
    return self;
}

- (instancetype)init
{
    return [self initWithConfig:nil];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self.maskView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.contentView];
    self.contentView.transform = CGAffineTransformScale(self.contentView.transform, 1.1, 1.1);
    self.contentView.alpha = 0.2;
    self.maskView.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{
        self.contentView.transform = CGAffineTransformIdentity;
        self.contentView.alpha = 1;
        self.maskView.alpha = 0.3;
    }];
    [self.contentView.inputTextField becomeFirstResponder];
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
//    //获取键盘的高度
//    NSDictionary *userInfo = [aNotification userInfo];
//    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGRect keyboardRect = [aValue CGRectValue];
//    int height = keyboardRect.size.height;
//    NSLog(@"%d",height);
//
//    if (height == 0) {
//        return;
//    }
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    [self onClose];
}
- (void)setDelegate:(id<ABWXPwdPopupDelegate>)delegate {
    _delegate = delegate;
    self.contentView.delegate = delegate;
}

- (void)onClose {
    [self.maskView removeFromSuperview];
    [self.contentView removeFromSuperview];
}
@end
