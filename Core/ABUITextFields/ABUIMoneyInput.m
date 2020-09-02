//
//  ABUIMoneyInput.m
//  ABUIKit
//
//  Created by qp on 2020/9/2.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIMoneyInput.h"

@implementation ABUIMoneyInput

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textField = [[ABUITextField alloc] initWithFrame:CGRectZero];
        [self addSubview:self.textField];
        
        self.maxdecimal = 0;

    }
    return self;
}

- (void)setMaxdecimal:(int)maxdecimal {
    _maxdecimal = maxdecimal;
    if (maxdecimal == 0) {
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
    }else{
        self.textField.keyboardType = UIKeyboardTypeDecimalPad;
    }
}

- (NSString *)text{
    return self.textField.text;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textField.frame = self.bounds;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString * str = [NSString stringWithFormat:@"%@%@",textField.text,string];
    //匹配以0开头的数字
    NSPredicate * predicate0 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[0][0-9]+$"];
    //匹配两位小数、整数
    NSString *p1 = [NSString stringWithFormat:@"^(([1-9]{1}[0-9]*|[0])\\.?[0-9]{0,%i})$",self.maxdecimal];
    NSPredicate * predicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",p1];
    BOOL sucess = ![predicate0 evaluateWithObject:str] && [predicate1 evaluateWithObject:str] ? YES : NO;
    return sucess;
}


@end
