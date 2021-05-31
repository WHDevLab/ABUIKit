//
//  ABUIListView005ItemView.m
//  ABUIKit
//
//  Created by qp on 2021/3/11.
//  Copyright © 2021 abteam. All rights reserved.
//

#import "ABUIListView005ItemView.h"
#import "UIColor+AB.h"
#import "UIFont+AB.h"
@interface ABUIListView005ItemView ()
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) ABCountDownButton *cbButton;
@end
@implementation ABUIListView005ItemView

+ (void)load {
    [[ABUIListViewMapping shared] registerClassString:@"ABUIListView005ItemView" native_id:@"ablist_item_005"];
}

- (void)setupAdjustContents {
    self.containView = [[UIView alloc] initWithFrame:self.bounds];
    self.containView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.containView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.textColor = [UIColor hexColor:@"#292B32"];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.containView addSubview:self.titleLabel];
    
    self.inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-15-114, self.height)];
    self.inputTextField.font = [UIFont PingFangSC:16];
    [self.containView addSubview:self.inputTextField];
    
    self.cbButton = [[ABCountDownButton alloc] initWithFrame:CGRectMake(0, 5, 90, self.height*0.6)];
    [self.cbButton setBackgroundColor:[UIColor hexColor:@"FF2B2B"]];
    [self.cbButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.cbButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.cbButton.layer.cornerRadius = self.cbButton.height/2;
    self.cbButton.clipsToBounds = true;
    [self.cbButton addTarget:self action:@selector(cbButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.containView addSubview:self.cbButton];
    
    [self listenInput:self.inputTextField];
}

- (void)cbButtonAction {
    [self.cell sendActionWithKey:@"sms" actionData:self.cbButton];
}

- (void)reload:(NSDictionary *)item {
    [self.titleLabel setHidden:item[@"data.title"]==nil];
    if (item[@"data.title"]) {
        self.titleLabel.text = item[@"data.title"];
        [self.titleLabel sizeToFit];
    }
    self.inputTextField.placeholder = item[@"data.placeholder"];
}

- (void)layoutAdjustContents {
    self.cbButton.left = self.containView.width-15-self.cbButton.width;
    self.cbButton.centerY = self.containView.height/2;
    
    if (self.titleLabel.isHidden == false) {
        self.titleLabel.left = 15;
        self.inputTextField.left = self.titleLabel.right+10;
        self.inputTextField.width = self.width-15-self.titleLabel.width-self.cbButton.width-10;
        self.titleLabel.centerY = self.height/2;
        
        
    }
}

@end
