//
//  ABUIListView010ItemView.m
//  ABUIKit
//
//  Created by qp on 2021/3/11.
//  Copyright © 2021 abteam. All rights reserved.
//

#import "ABUIListView010ItemView.h"

@implementation ABUIListView010ItemView
+ (void)load {
    [[ABUIListViewMapping shared] registerClassString:@"ABUIListView010ItemView" native_id:@"ablist_item_010"];
}
- (void)setupAdjustContents {
    self.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont PingFangSC:16];
    self.titleLabel.textColor = [UIColor hexColor:@"222222"];
    [self addSubview:self.titleLabel];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.contentLabel.font = [UIFont PingFangSC:16];
    self.contentLabel.textColor = [UIColor hexColor:@"999999"];
    [self addSubview:self.contentLabel];
    
    self.countLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.countLabel.font = [UIFont PingFangSC:20];
    self.countLabel.textColor = [UIColor hexColor:@"222222"];
    [self addSubview:self.countLabel];
}


- (void)layoutAdjustContents {
    self.titleLabel.left = 15;
    self.contentLabel.left = 15;
    
    self.titleLabel.top = self.height/2-self.titleLabel.height;
    self.contentLabel.top = self.height/2;
    
    self.countLabel.left = self.width-15-self.countLabel.width;
    self.countLabel.centerY = self.titleLabel.centerY;
}

- (void)reload:(NSDictionary *)item {
    self.titleLabel.text = item[@"data.title"];
    [self.titleLabel sizeToFit];
    
    self.contentLabel.text = item[@"data.time"];
    [self.contentLabel sizeToFit];
    
    self.countLabel.text = item[@"data.number"];
    [self.countLabel sizeToFit];
    
}
@end
