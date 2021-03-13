//
//  ABUIListView008ItemView.m
//  ABUIKit
//
//  Created by qp on 2021/3/11.
//  Copyright © 2021 abteam. All rights reserved.
//

#import "ABUIListView008ItemView.h"

@implementation ABUIListView008ItemView
+ (void)load {
    [[ABUIListViewMapping shared] registerClassString:@"ABUIListView008ItemView" native_id:@"ablist_item_008"];
}
- (void)setupAdjustContents {
    self.backgroundColor = [UIColor whiteColor];
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 44, 44)];
    self.iconImageView.layer.cornerRadius = 3;
    self.iconImageView.clipsToBounds = true;
    self.iconImageView.backgroundColor = [UIColor redColor];
    [self addSubview:self.iconImageView];
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.iconImageView.right+10, 0, self.width-self.iconImageView.right-10-15, 25)];
    self.titleLabel.font = [UIFont PingFangSC:16];
    self.titleLabel.textColor = [UIColor hexColor:@"222222"];
    [self addSubview:self.titleLabel];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.iconImageView.right+10, self.titleLabel.bottom, self.width-self.iconImageView.right-10-15, 25)];
    self.contentLabel.font = [UIFont PingFangSC:14];
    self.contentLabel.textColor = [UIColor hexColor:@"999999"];
    [self addSubview:self.contentLabel];
}

- (void)layoutAdjustContents {
    self.iconImageView.centerY = self.height/2;
    self.titleLabel.top = self.iconImageView.centerY-self.titleLabel.height;
    self.contentLabel.top = self.iconImageView.centerY;
}

- (void)reload:(NSDictionary *)item {
    self.titleLabel.text = item[@"data.title"];
    self.contentLabel.text = item[@"data.content"];
    
    [self.titleLabel sizeToFit];
    [self.contentLabel sizeToFit];
}
@end
