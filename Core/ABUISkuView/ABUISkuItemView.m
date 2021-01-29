//
//  ABUISkuItemView.m
//  ABUIKit
//
//  Created by qp on 2021/1/22.
//  Copyright © 2021 abteam. All rights reserved.
//

#import "ABUISkuItemView.h"
#import "UIColor+AB.h"
#import "UIFont+AB.h"
#import "UIView+AB.h"
@interface ABUISkuItemView ()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation ABUISkuItemView

+ (void)load {
    [[ABUIListViewMapping shared] registerClassString:@"ABUISkuItemView" native_id:@"abitem_skuitem"];
}

- (void)setupAdjustContents {
    self.contentView = [[UIView alloc] initWithFrame:self.bounds];
    self.contentView.backgroundColor = [UIColor hexColor:@"f3f3f2"];
    self.contentView.layer.cornerRadius = 10;
    self.contentView.clipsToBounds = true;
    [self addSubview:self.contentView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.titleLabel.textColor = [UIColor hexColor:@"111111"];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont PingFangSC:12];
    [self.contentView addSubview:self.titleLabel];
}

- (void)layoutAdjustContents {
    self.contentView.frame = self.bounds;
    self.titleLabel.frame = self.bounds;
    self.titleLabel.centerX = self.width/2;
}

- (void)reload:(NSDictionary *)item extra:(NSDictionary *)extra indexPath:(NSIndexPath *)indexPath {
    self.titleLabel.text = item[@"title"];
    
    int status = [extra[@"status"] intValue];
    self.contentView.alpha = 1.0;
    if (status == 0) { // 不可点击
        self.contentView.backgroundColor = [[UIColor hexColor:@"F5F5F5"] colorWithAlphaComponent:0.6];
        self.titleLabel.textColor = [UIColor hexColor:@"D8D8D8"];
    }
    else if (status == 1) { // 可点击,未选中
        self.contentView.backgroundColor = [UIColor hexColor:@"F5F5F5"];
        self.titleLabel.textColor = [UIColor hexColor:@"646464"];
    }
    else if (status == 2) { // 可点击,已选中
        self.contentView.backgroundColor = [[UIColor hexColor:@"FC2E57"] colorWithAlphaComponent:0.2];
        self.titleLabel.textColor = [UIColor hexColor:@"FC2E57"];
    }
}

@end
