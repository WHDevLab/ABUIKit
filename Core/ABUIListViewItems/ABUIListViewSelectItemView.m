//
//  ABUIListSelectItemView.m
//  ABUIKit
//
//  Created by qp on 2020/10/9.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIListViewSelectItemView.h"
#import "ABUIListViewMapping.h"
#import "UIView+AB.h"
#import "UIFont+AB.h"
#import "UIColor+AB.h"
@interface ABUIListViewSelectItemView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *phLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@end
@implementation ABUIListViewSelectItemView

+(void)load {
    [[ABUIListViewMapping shared] registerClassString:@"ABUIListViewSelectItemView" native_id:@"abitem_select"];
}

- (void)setupAdjustContents {
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, self.frame.size.height)];
    self.titleLabel.font = [UIFont PingFangSC:16];
    self.titleLabel.textColor = [UIColor hexColor:@"222222"];
    [self addSubview:self.titleLabel];
    
    self.phLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.right+10, 0, self.width-10-self.titleLabel.right-15, self.frame.size.height)];
    self.phLabel.font = [UIFont PingFangSC:16];
    self.phLabel.textColor = [UIColor hexColor:@"666666"];
    [self addSubview:self.phLabel];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.right+10, 0, self.width-10-self.titleLabel.right-15, self.frame.size.height)];
    self.contentLabel.font = [UIFont PingFangSC:16];
    self.contentLabel.textColor = [UIColor hexColor:@"222222"];
    [self.contentLabel setUserInteractionEnabled:true];
    [self addSubview:self.contentLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onAction)];
    [self.contentLabel addGestureRecognizer:tap];
}

- (void)layoutAdjustContents {
    
}

- (void)reload:(NSDictionary *)item {
    self.titleLabel.text = item[@"title"];
    self.contentLabel.textColor = [UIColor hexColor:@"222222"];
    
    self.phLabel.text = item[@"placeholder"];
    
    id rData = [self.cell userProvideData];
    if (rData != nil && [rData isKindOfClass:[NSString class]]) {
        self.contentLabel.text = (NSString *)rData;
    }
    
    if (self.contentLabel.text.length == 0) {
        [self.phLabel setHidden:false];
    }else{
        [self.phLabel setHidden:true];
    }
}

- (void)onAction {
    [self.cell sendActionWithKey:@"default" actionData:@""];
}

@end
