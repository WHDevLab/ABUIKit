//
//  ABUIInputView.m
//  ABUIKit
//
//  Created by qp on 2020/7/29.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIInputView.h"
#import "UIView+AB.h"
@interface ABUIInputView ()
@property (nonatomic, strong) UILabel *inputLabel;
@end
@implementation ABUIInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _inputLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, self.height-44, self.width, 44)];
        _inputLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        _inputLabel.clipsToBounds = true;
        _inputLabel.layer.cornerRadius = 33/2;
        _inputLabel.text = @"有爱评论，说点儿好听的~";
        _inputLabel.userInteractionEnabled = true;
        _inputLabel.textAlignment = NSTextAlignmentCenter;
        _inputLabel.font = [UIFont systemFontOfSize:13];
        _inputLabel.textColor = [UIColor whiteColor];
        [self addSubview:_inputLabel];

//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onInput)];
//        [_inputLabel addGestureRecognizer:tap];
    }
    return self;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    NSString * str = [NSString stringWithFormat:@"%@%@",textField.text,string];
//    //匹配以0开头的数字
//    NSPredicate * predicate0 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[0][0-9]+$"];
//    //匹配两位小数、整数
//    NSPredicate * predicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^(([1-9]{1}[0-9]*|[0])\\.?[0-9]{0,2})$"];
//    BOOL sucess = ![predicate0 evaluateWithObject:str] && [predicate1 evaluateWithObject:str] ? YES : NO;
//    return sucess;
//}

@end
