//
//  ABUIListView004ItemView.m
//  ABUIKit
//
//  Created by qp on 2021/3/11.
//  Copyright © 2021 abteam. All rights reserved.
//

#import "ABUIListView004ItemView.h"
@interface ABUIListView004ItemView ()
@property (nonatomic, strong) UITextField *containView;
@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation ABUIListView004ItemView
+ (void)load {
    [[ABUIListViewMapping shared] registerClassString:@"ABUIListView004ItemView" native_id:@"ablist_item_004"];
}
- (void)setupAdjustContents {
    self.backgroundColor = [UIColor whiteColor];
    self.containView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:self.containView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.textColor = [UIColor hexColor:@"#292B32"];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.titleLabel];
    
    self.inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, self.width-30, self.height)];
    self.inputTextField.font = [UIFont PingFangSC:16];
    [self.containView addSubview:self.inputTextField];
    
    [self listenInput:self.inputTextField];
}

- (void)layoutAdjustContents {
    if (self.titleLabel.text.length > 0) {
        self.titleLabel.left = 15;
        self.inputTextField.left = self.titleLabel.right;
        self.inputTextField.width = self.width-self.titleLabel.right-15;
        self.titleLabel.centerY = self.height/2;
    }else{
        self.inputTextField.left = 15;
        self.inputTextField.width = self.width-30;
    }
}

- (void)reload:(NSDictionary *)item {
    if (item[@"data.title"] != nil) {
        self.titleLabel.text = item[@"data.title"];
        [self.titleLabel sizeToFit];
    }
    self.inputTextField.placeholder = item[@"data.placeholder"];
    [self reloadTextFiedData];
}

@end
