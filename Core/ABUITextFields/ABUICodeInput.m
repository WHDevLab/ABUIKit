//
//  ABUICodeInput.m
//  ABUIKit
//
//  Created by qp on 2020/7/2.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUICodeInput.h"
#import "UIView+AB.h"
#import "UIColor+AB.h"
@implementation ABUICodeInput

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:self.titleLabel];
        
        self.textField = [[ABUITextField alloc] initWithFrame:CGRectZero];
        [self addSubview:self.textField];
        
        self.titleLabel.frame = CGRectMake(0, 0, 68, 44);
        self.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        self.titleLabel.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
        
        self.textField.font = [UIFont systemFontOfSize:12];
        
        self.cbButton = [[ABCountDownButton alloc] initWithFrame:CGRectMake(0, 0, 84, 34)];
        [self.cbButton setBackgroundColor:[UIColor hexColor:@"FF2B2B"]];
        [self.cbButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.cbButton.titleLabel.font = [UIFont systemFontOfSize:11];
        self.cbButton.layer.cornerRadius = 34/2;
        self.cbButton.clipsToBounds = true;
        [self.cbButton addTarget:self action:@selector(cbButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.cbButton];
        
        self.downCount = 60;
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
}

- (void)cbButtonAction {
    [self.delegate codeinputOnSendCode:self];    
}

- (void)start {
    [self.cbButton startCountDownWithSecond:self.downCount];
}

- (NSString *)text{
    return self.textField.text;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.cbButton.left = self.width-self.cbButton.width;
    self.cbButton.centerY = self.height/2;
    
    self.titleLabel.left = 0;
    self.titleLabel.centerY = self.height/2;
    
    self.textField.frame = CGRectMake(self.titleLabel.right, 0, self.width-self.titleLabel.width-self.cbButton.width, self.height);
}

@end
