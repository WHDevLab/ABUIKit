//
//  ABUIListView011ItemView.m
//  ABUIKit
//
//  Created by qp on 2021/3/11.
//  Copyright © 2021 abteam. All rights reserved.
//

#import "ABUIListView011ItemView.h"

@implementation ABUIListView011ItemView

+ (void)load {
    [[ABUIListViewMapping shared] registerClassString:@"ABUIListView011ItemView" native_id:@"ablist_item_011"];
}
- (void)setupAdjustContents {
    self.backgroundColor = [UIColor whiteColor];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.nameLabel.font = [UIFont PingFangSC:15];
    self.nameLabel.textColor = [UIColor hexColor:@"#3C3C3C"];
    [self addSubview:self.nameLabel];
    
    self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.phoneLabel.font = [UIFont PingFangSC:15];
    self.phoneLabel.textColor = [UIColor hexColor:@"#3C3C3C"];
    [self addSubview:self.phoneLabel];
    
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.addressLabel.font = [UIFont PingFangSC:13];
    self.addressLabel.textColor = [UIColor hexColor:@"#AAAAAA"];
    self.addressLabel.numberOfLines = 0;
    [self addSubview:self.addressLabel];
    
    self.toolView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-44, SCREEN_WIDTH, 44)];
    [self addSubview:self.toolView];
    [self.toolView addLineDirection:LineDirectionTop color:[UIColor hexColor:@"dedede"] width:LINGDIANWU];
    
    self.defaultButton = [[QMUIButton alloc] initWithFrame:CGRectMake(10, 0, 80, 44)];
    [self.defaultButton setTitle:@"默认地址" forState:UIControlStateNormal];
    self.defaultButton.titleLabel.font = [UIFont PingFangSC:14];
    [self.toolView addSubview:self.defaultButton];
    [self.defaultButton setTitleColor:[UIColor hexColor:@"3c3c3c"] forState:UIControlStateNormal];
    [self.defaultButton setImage:[UIImage imageNamed:@"morengouxuanhui"] forState:UIControlStateNormal];
    [self.defaultButton setImage:[UIImage imageNamed:@"morengouxuan"] forState:UIControlStateSelected];
    self.defaultButton.spacingBetweenImageAndTitle = 5;
    
    
    self.delButton = [[QMUIButton alloc] initWithFrame:CGRectMake(self.width-15-50, 0, 50, 44)];
    [self.delButton setTitle:@"删除" forState:UIControlStateNormal];
    self.delButton.titleLabel.font = [UIFont PingFangSC:14];
    [self.toolView addSubview:self.delButton];
    [self.delButton setTitleColor:[UIColor hexColor:@"3c3c3c"] forState:UIControlStateNormal];
    [self.delButton setImage:[UIImage imageNamed:@"sshanchu"] forState:UIControlStateNormal];
    [self.delButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    self.delButton.spacingBetweenImageAndTitle = 5;
    
    self.editButton = [[QMUIButton alloc] initWithFrame:CGRectMake(self.delButton.left-20-50, 0, 50, 44)];
    [self.editButton setTitle:@"编辑" forState:UIControlStateNormal];
    self.editButton.titleLabel.font = [UIFont PingFangSC:14];
    [self.toolView addSubview:self.editButton];
    [self.editButton setTitleColor:[UIColor hexColor:@"3c3c3c"] forState:UIControlStateNormal];
    [self.editButton setImage:[UIImage imageNamed:@"bianji"] forState:UIControlStateNormal];
    self.editButton.spacingBetweenImageAndTitle = 5;
}


- (void)layoutAdjustContents {
    self.nameLabel.left = 15;
    self.addressLabel.left = 15;
    self.phoneLabel.left = self.width-15-self.phoneLabel.width;
    
    self.nameLabel.top = 10;
    self.phoneLabel.top = 10;
    self.addressLabel.top = self.nameLabel.bottom+10;
}

- (void)reload:(NSDictionary *)item {
    self.nameLabel.text = item[@"data.name"];
    [self.nameLabel sizeToFit];
    
    self.phoneLabel.text = item[@"data.phone"];
    [self.phoneLabel sizeToFit];
    
    self.addressLabel.text = item[@"data.address"];
    [self.addressLabel sizeToFit];
    
}
@end
