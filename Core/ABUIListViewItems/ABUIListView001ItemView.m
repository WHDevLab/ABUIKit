//
//  ABUIListView001ItemView.m
//  ABUIKit
//
//  Created by qp on 2021/3/11.
//  Copyright © 2021 abteam. All rights reserved.
//  

#import "ABUIListView001ItemView.h"

@implementation ABUIListView001ItemView
+ (void)load {
    [[ABUIListViewMapping shared] registerClassString:@"ABUIListView001ItemView" native_id:@"ablist_item_001"];
}
- (void)setupAdjustContents {
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.textColor = [UIColor hexColor:@"#292B32"];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.titleLabel];
    
    self.arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8, 12)];
    self.arrowImageView.image = [UIImage imageNamed:[ABUIListViewConfigure shared].cellArrowImageName];
    self.arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.arrowImageView];
}

- (void)layoutAdjustContents {
    self.titleLabel.left = 15;
    self.titleLabel.centerY = self.height/2;
    
    self.arrowImageView.left = self.width-15-self.arrowImageView.width;
    self.arrowImageView.centerY = self.height/2;
}

- (void)reload:(NSDictionary *)item {
    self.titleLabel.text = item[@"data.title"];
    if (item[@"css.font"] != nil) {
        self.titleLabel.font = item[@"css.title.font"];
    }
    if (item[@"css.color"] != nil) {
        self.titleLabel.textColor = item[@"css.title.color"];
    }
    [self.titleLabel sizeToFit];
    
    if ([item[@"css.arrow.hidden"] boolValue] == true) {
        [self.arrowImageView setHidden:true];
    }else{
        [self.arrowImageView setHidden:false];
    }
}

@end
