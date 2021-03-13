//
//  ABUIListView005ItemView.m
//  ABUIKit
//
//  Created by qp on 2021/3/11.
//  Copyright © 2021 abteam. All rights reserved.
//

#import "ABUIListView005ItemView.h"

@interface ABUIListView005ItemView ()
@property (nonatomic, strong) UIView *containView;
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
    
    self.inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-15-114, self.height)];
    self.inputTextField.font = [UIFont PingFangSC:16];
    [self.containView addSubview:self.inputTextField];
    
    self.cbButton = [[ABCountDownButton alloc] initWithFrame:CGRectMake(0, 5, 84, self.height-10)];
    [self.cbButton setBackgroundColor:[UIColor hexColor:@"FF2B2B"]];
    [self.cbButton setTitle:@"获取" forState:UIControlStateNormal];
    self.cbButton.titleLabel.font = [UIFont systemFontOfSize:16];
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
    self.inputTextField.placeholder = item[@"data.placeholder"];
}

- (void)layoutAdjustContents {
    self.cbButton.left = self.containView.width-15-self.cbButton.width;
    self.cbButton.centerY = self.containView.height/2;
}

@end
