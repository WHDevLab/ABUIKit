//
//  ABUIChatItemTimeView.m
//  ABUIKit
//
//  Created by qp on 2020/11/2.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIChatItemTimeView.h"
#import "UIView+AB.h"
#import "UIFont+AB.h"
#import "UIColor+AB.h"
@interface  ABUIChatItemTimeView ()
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation ABUIChatItemTimeView

+ (void)load {
    [[ABUIListViewMapping shared] registerClassString:@"ABUIChatItemTimeView" native_id:@"item_chat_time"];
}

- (void)setupAdjustContents {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    self.titleLabel.font = [UIFont PingFangSC:14];
    self.titleLabel.textColor = [UIColor hexColor:@"999999"];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
}

- (void)layoutAdjustContents {
    
}

- (void)reload:(NSDictionary *)item extra:(NSDictionary *)extra indexPath:(NSIndexPath *)indexPath {
    self.titleLabel.text = item[@"title"];
}

@end
