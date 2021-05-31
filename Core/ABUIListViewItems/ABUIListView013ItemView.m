//
//  ABUIListView013ItemView.m
//  ABUIKit
//
//  Created by qp on 2021/5/28.
//  Copyright © 2021 abteam. All rights reserved.
//

#import "ABUIListView013ItemView.h"

@implementation ABUIListView013ItemView

+(void)load {
    [[ABUIListViewMapping shared] registerClassString:@"ABUIListView013ItemView" native_id:@"ablist_item_013"];
}

- (void)setupAdjustContents {
    self.layer.cornerRadius = 5;
    self.clipsToBounds = true;
    self.bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:self.bgImageView];
    self.bgImageView.backgroundColor = [UIColor redColor];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.nameLabel.font = [UIFont PingFangSC:17];
    self.nameLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.nameLabel];
    
    self.typeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.typeLabel.font = [UIFont PingFangSC:14];
    self.typeLabel.textColor = [UIColor hexColor:@"#A8A8A8"];
    [self addSubview:self.typeLabel];
    
    self.cardLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.cardLabel.font = [UIFont PingFangSCBlod:20];
    self.cardLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    [self addSubview:self.cardLabel];
}

- (void)layoutAdjustContents {
    self.nameLabel.left = 15;
    self.nameLabel.top = 10;
    
    self.typeLabel.left = 15;
    self.typeLabel.top = self.nameLabel.bottom;
    
    self.cardLabel.left = 15;
    self.cardLabel.top = self.typeLabel.bottom+10;
}

- (void)reload:(NSDictionary *)item {
    self.nameLabel.text = item[@"data.name"];
    [self.nameLabel sizeToFit];
    
    self.typeLabel.text = item[@"data.type"];
    [self.typeLabel sizeToFit];
    
    self.cardLabel.text = item[@"data.number"];
    [self.cardLabel sizeToFit];
}
@end
