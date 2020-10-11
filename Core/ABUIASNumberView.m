//
//  ABUIASNumberView.m
//  ABUIKit
//
//  Created by qp on 2020/9/29.
//  Copyright © 2020 abteam. All rights reserved.
//  加减器

#import "ABUIASNumberView.h"
#import "UIColor+AB.h"
#import "UIView+AB.h"
@interface ABUIASNumberView ()
@property (nonatomic, strong) UIButton *subButton;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *addButton;


@end
@implementation ABUIASNumberView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.maxNum = 10;
        self.count = 1;
        self.subButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, floor(self.width*0.32), self.frame.size.height)];
        [self.subButton setTitle:@"-" forState:UIControlStateNormal];
        [self.subButton setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
        self.subButton.titleLabel.font = [UIFont systemFontOfSize:25];
        [self.subButton setBackgroundColor:[UIColor hexColor:@"f3f3f2"]];
        [self addSubview:self.subButton];
        [self.subButton addTarget:self action:@selector(onSub) forControlEvents:UIControlEventTouchUpInside];
        
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(self.subButton.right+1, 0, floor(self.width*0.36), self.height)];
        self.textField.textAlignment = NSTextAlignmentCenter;
        self.textField.font = [UIFont boldSystemFontOfSize:16];
        [self.textField setUserInteractionEnabled:false];
        self.textField.textColor = [UIColor hexColor:@"222222"];
        [self.textField setBackgroundColor:[UIColor hexColor:@"f3f3f2"]];
        [self addSubview:self.textField];
        
        self.addButton = [[UIButton alloc] initWithFrame:CGRectMake(self.textField.right+1, 0, floor(self.width*0.32), self.frame.size.height)];
        [self.addButton setTitle:@"+" forState:UIControlStateNormal];
        [self.addButton setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
        self.addButton.titleLabel.font = [UIFont systemFontOfSize:25];
        [self.addButton setBackgroundColor:[UIColor hexColor:@"f3f3f2"]];
        [self addSubview:self.addButton];
        [self.addButton addTarget:self action:@selector(onAdd) forControlEvents:UIControlEventTouchUpInside];
        
        [self r];
        
    }
    return self;
}

- (void)onSub {
    self.count--;
    if (self.count <= 1) {
        self.count = 1;
    }
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)onAdd {
    self.count++;
    if (self.count >= self.maxNum) {
        self.count = self.maxNum;
    }
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)setCount:(int)count {
    _count = count;
    [self r];
}

- (void)r {
    NSLog(@"%i", _count);
    self.textField.text = [NSString stringWithFormat:@"%i", _count];
    [self.subButton setUserInteractionEnabled:true];
    [self.addButton setUserInteractionEnabled:true];
    self.subButton.alpha = 1;
    self.addButton.alpha = 1;
    if (self.count <= 1) {
        self.subButton.alpha = 0.5;
        [self.subButton setUserInteractionEnabled:false];
    }
    
    if (self.count >= self.maxNum) {
        self.addButton.alpha = 0.5;
        [self.addButton setUserInteractionEnabled:false];
    }
}

@end
