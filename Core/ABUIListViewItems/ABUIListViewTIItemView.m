//
//  ABUIListViewTIItemView.m
//  ABUIKit
//
//  Created by qp on 2020/9/30.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIListViewTIItemView.h"
#import "UIColor+AB.h"
#import "UIView+AB.h"
@interface ABUIListViewTIItemView()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation ABUIListViewTIItemView
+ (void)load {
    [[ABUIListViewMapping shared] registerClassString:@"ABUIListViewTIItemView" native_id:@"abitem_title"];
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
}

- (void)layoutAdjustContents {
    self.iconImageView.left = 15;
    self.iconImageView.centerY = self.height/2;
    
    self.titleLabel.left = self.iconImageView.right+10;
    self.titleLabel.centerY = self.height/2;
}

- (void)reload:(NSDictionary *)item {
    self.titleLabel.text = item[@"title"];
    [self.titleLabel sizeToFit];
    
    self.iconImageView.image = [UIImage imageNamed:item[@"icon"]];
}
@end
