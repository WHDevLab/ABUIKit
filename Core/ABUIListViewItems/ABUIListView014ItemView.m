//
//  ABUIListView014ItemView.m
//  ABUIKit
//
//  Created by qp on 2021/5/28.
//  Copyright © 2021 abteam. All rights reserved.
//

#import "ABUIListView014ItemView.h"

@implementation ABUIListView014ItemView
+(void)load {
    [[ABUIListViewMapping shared] registerClassString:@"ABUIListView014ItemView" native_id:@"ablist_item_014"];
}


- (void)setupAdjustContents {
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.textColor = [UIColor hexColor:@"#292B32"];
    self.titleLabel.font = [UIFont PingFangSC:16];
    [self addSubview:self.titleLabel];
    
    self.inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 80)];
    self.inputTextField.font = [UIFont PingFangSCBlod:40];
    self.inputTextField.textColor = [UIColor hexColor:@"3c3c3c"];
    [self addSubview:self.inputTextField];
    self.inputTextField.tintColor = [UIColor hexColor:@"04BE02"];
    self.inputTextField.keyboardType = UIKeyboardTypeDecimalPad;
    [self.inputTextField addLineDirection:LineDirectionBottom color:[UIColor hexColor:@"dedede"] width:LINGDIANWU];
    self.inputTextField.delegate = self;
    [self listenInput:self.inputTextField];
    
    UIView *xxV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, self.inputTextField.height)];
    UILabel *xxLabel = [[UILabel alloc] initWithFrame:xxV.bounds];
    xxLabel.text = @"¥";
    xxLabel.font = [UIFont PingFangSCBlod:35];
    xxLabel.textColor = [UIColor hexColor:@"3c3c3c"];
    [xxV addSubview:xxLabel];
    [xxLabel sizeToFit];
    xxV.width = xxLabel.size.width+5;
    xxLabel.centerY = xxV.height/2;
    self.inputTextField.leftView = xxV;
    self.inputTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.noticeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.noticeLabel.textColor = [UIColor hexColor:@"#3dc2d5"];
    self.noticeLabel.font = [UIFont PingFangSC:12];
    [self addSubview:self.noticeLabel];
    
    self.noticeButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [self addSubview:self.noticeButton];
    [self.noticeButton setTitleColor:[UIColor hexColor:@"4682B4"] forState:UIControlStateNormal];
    [self.noticeButton setTitle:@"全部提现" forState:UIControlStateNormal];
    self.noticeButton.titleLabel.font = [UIFont PingFangSCBlod:12];
    [self.noticeButton sizeToFit];
    self.noticeButton.height = 30;
    [self.noticeButton addTarget:self action:@selector(onTiXian) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutAdjustContents {
    self.titleLabel.left = 15;
    self.titleLabel.top = 10;
    
    self.inputTextField.top = self.titleLabel.bottom+10;
    self.noticeLabel.top = self.inputTextField.bottom+10;
    self.noticeLabel.left = 15;
    
    self.noticeButton.centerY = self.noticeLabel.centerY;
    self.noticeButton.left = self.noticeLabel.right;
}

- (void)reload:(NSDictionary *)item {
    if (item[@"css.title.font"]) {
        self.titleLabel.font = item[@"css.title.font"];
    }else{
        self.titleLabel.font = [UIFont PingFangSC:16];
    }
    self.titleLabel.text = item[@"data.title"];
    [self.titleLabel sizeToFit];
    
    self.noticeLabel.text = item[@"data.notice"];
    [self.noticeLabel sizeToFit];
    [self reloadTextFiedData];
    
    int type = [item[@"data.type"] intValue];
    [self.noticeButton setHidden:type == 0];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString * str = [NSString stringWithFormat:@"%@%@",textField.text,string];
    //匹配以0开头的数字
    NSPredicate * predicate0 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[0][0-9]+$"];
    //匹配两位小数、整数
    NSPredicate * predicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^(([1-9]{1}[0-9]*|[0])\\.?[0-9]{0,2})$"];
    BOOL sucess = ![predicate0 evaluateWithObject:str] && [predicate1 evaluateWithObject:str] ? YES : NO;
    return sucess;
}

- (void)onTiXian {
    self.inputTextField.text = @"8888";
}

@end
