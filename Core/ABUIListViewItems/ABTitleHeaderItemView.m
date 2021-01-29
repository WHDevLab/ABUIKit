//
//  ABTitleHeaderItemView.m
//  ABUIKit
//
//  Created by qp on 2020/9/30.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABTitleHeaderItemView.h"
#import "UIFont+AB.h"
#import "UIColor+AB.h"
#import "UIView+AB.h"
@implementation ABTitleHeaderItemView

+ (void)load
{
    [[ABUIListViewMapping shared] registerClassString:@"ABTitleHeaderItemView" native_id:@"abitem_header"];
}

- (void)setupAdjustContents {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont PingFangMedium:15];
    self.titleLabel.textColor = [UIColor hexColor:@"333333"];
    [self addSubview:self.titleLabel];
}

- (void)layoutAdjustContents {
    self.titleLabel.centerY = self.height/2;
}

- (void)reload:(NSDictionary *)item {
    self.titleLabel.text = item[@"title"];
    [self.titleLabel sizeToFit];
}

@end
