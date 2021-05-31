//
//  ABUIListView012ItemView.m
//  ABUIKit
//
//  Created by qp on 2021/3/11.
//  Copyright © 2021 abteam. All rights reserved.
//

#import "ABUIListView012ItemView.h"
#import <SDWebImage/SDWebImage.h>
@implementation ABUIListView012ItemView

+ (void)load {
    [[ABUIListViewMapping shared] registerClassString:@"ABUIListView012ItemView" native_id:@"ablist_item_012"];
}

- (void)setupAdjustContents {
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.textColor = [UIColor hexColor:@"#343434"];
    self.titleLabel.font = [UIFont PingFangSC:16];
    [self addSubview:self.titleLabel];
    
    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 46, 46)];
    self.avatarImageView.backgroundColor = [UIColor hexColor:@"f3f3f2"];
    self.avatarImageView.layer.cornerRadius = 23;
    self.avatarImageView.clipsToBounds = true;
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.avatarImageView];
}

- (void)layoutAdjustContents {
    self.avatarImageView.left = self.width-15-self.avatarImageView.width;
    self.avatarImageView.centerY = self.height/2;
    self.titleLabel.centerY = self.height/2;
    self.titleLabel.left = 15;
}

- (void)reload:(NSDictionary *)item {
    self.titleLabel.text = item[@"data.title"];
    [self.titleLabel sizeToFit];
    
    if (item[@"css.image.height"]) {
        self.avatarImageView.height = [item[@"css.image.height"] floatValue];
    }
    if (item[@"css.image.width"]) {
        self.avatarImageView.width = [item[@"css.image.width"] floatValue];
    }
    
    [self.avatarImageView sd_setImageWithURL:item[@"data.image"] placeholderImage:nil];
}

@end
