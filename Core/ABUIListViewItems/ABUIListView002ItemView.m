//
//  ABUIListView002ItemView.m
//  ABUIKit
//
//  Created by qp on 2021/3/11.
//  Copyright © 2021 abteam. All rights reserved.
//

#import "ABUIListView002ItemView.h"
@interface ABUIListView002ItemView()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation ABUIListView002ItemView

+ (void)load {
    [[ABUIListViewMapping shared] registerClassString:@"ABUIListView002ItemView" native_id:@"ablist_item_002"];
}
- (void)setupAdjustContents {
    self.backgroundColor = [UIColor whiteColor];
//    self.layer.cornerRadius = 6;
    self.clipsToBounds = true;
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.iconImageView setImage:[UIImage imageNamed:@"check"]];
    [self addSubview:self.iconImageView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.textColor = [UIColor hexColor:@"#292B32"];
    self.titleLabel.font = [UIFont PingFangSC:16];
    [self addSubview:self.titleLabel];
}

- (void)layoutAdjustContents {
    self.iconImageView.left = self.width-15-self.iconImageView.width;
    self.iconImageView.centerY = self.height/2;
    
    self.titleLabel.left = 15;
    self.titleLabel.centerY = self.height/2;
}

- (void)reload:(NSDictionary *)item extra:(NSDictionary *)extra indexPath:(NSIndexPath *)indexPath {
    self.titleLabel.text = item[@"data.title"];
    [self.titleLabel sizeToFit];
    
    [self.iconImageView setHidden:![extra[@"isSelected"] boolValue]];
}
@end
