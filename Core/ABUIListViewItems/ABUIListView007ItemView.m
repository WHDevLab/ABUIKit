//
//  ABUIListView007ItemView.m
//  ABUIKit
//
//  Created by qp on 2021/3/11.
//  Copyright © 2021 abteam. All rights reserved.
//

#import "ABUIListView007ItemView.h"

@interface ABUIListView007ItemView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *phLabel;//placeholder
@property (nonatomic, strong) UILabel *contentLabel;
@end
@implementation ABUIListView007ItemView

+(void)load {
    [[ABUIListViewMapping shared] registerClassString:@"ABUIListView007ItemView" native_id:@"ablist_item_007"];
}

- (void)setupAdjustContents {
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, self.frame.size.height)];
    self.titleLabel.font = [UIFont PingFangSC:16];
    self.titleLabel.textColor = [UIColor hexColor:@"222222"];
    [self addSubview:self.titleLabel];
    
    self.phLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.right+10, 0, self.width-10-self.titleLabel.right-15, self.frame.size.height)];
    self.phLabel.font = [UIFont PingFangSC:16];
    self.phLabel.textColor = [UIColor hexColor:@"666666"];
    [self addSubview:self.phLabel];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.right+10, 0, self.width-10-self.titleLabel.right-15, self.frame.size.height)];
    self.contentLabel.font = [UIFont PingFangSC:16];
    self.contentLabel.textColor = [UIColor hexColor:@"222222"];
    [self.contentLabel setUserInteractionEnabled:true];
    [self addSubview:self.contentLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onAction)];
    [self.contentLabel addGestureRecognizer:tap];
}

- (void)layoutAdjustContents {
    if (self.titleLabel.isHidden) {
        self.contentLabel.left = 15;
        self.phLabel.left = 15;
    }else{
        self.titleLabel.left = 15;
        self.contentLabel.left = self.titleLabel.right+10;
        self.phLabel.left = self.titleLabel.right+10;
    }
}

- (void)reload:(NSDictionary *)item {
    [self.titleLabel setHidden:item[@"data.title"] == nil];
    self.titleLabel.text = item[@"data.title"];
    self.contentLabel.textColor = [UIColor hexColor:@"222222"];
    
    self.phLabel.text = item[@"data.placeholder"];
    
    id rData = [self.cell userProvideData];
    if (rData != nil && [rData isKindOfClass:[NSString class]]) {
        self.contentLabel.text = (NSString *)rData;
    }
    
    if (self.contentLabel.text.length == 0) {
        [self.phLabel setHidden:false];
    }else{
        [self.phLabel setHidden:true];
    }
}

- (void)onAction {
    [[UIApplication sharedApplication].keyWindow endEditing:true];
    [self.cell sendActionWithKey:@"select" actionData:@""];
}

@end
