//
//  ABUIListView003ItemView.m
//  ABUIKit
//
//  Created by qp on 2021/3/11.
//  Copyright © 2021 abteam. All rights reserved.
//

#import "ABUIListView003ItemView.h"
@interface ABUIListView003ItemView()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) ABUILabel *titleLabel;
@end
@implementation ABUIListView003ItemView
+ (void)load {
    [[ABUIListViewMapping shared] registerClassString:@"ABUIListView003ItemView" native_id:@"ablist_item_003"];
}
- (void)setupAdjustContents {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 6;
    self.clipsToBounds = true;
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.iconImageView];
    
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
    self.iconImageView.left = 15;
    self.iconImageView.centerY = self.height/2;
    
    self.titleLabel.left = self.iconImageView.right+10;
    self.titleLabel.centerY = self.height/2;
    
    self.arrowImageView.left = self.width-self.arrowImageView.width-15;
    self.arrowImageView.centerY = self.height/2;
}

- (void)reload:(NSDictionary *)item {
    self.titleLabel.text = item[@"data.title"];
    [self.titleLabel sizeToFit];
    
    self.iconImageView.image = [UIImage imageNamed:item[@"data.icon"]];
    [self.arrowImageView setHidden:[item[@"css.arrow.hidden"] boolValue]];
    
}
@end
