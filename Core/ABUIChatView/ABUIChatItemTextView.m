//
//  ABUIChatItemTextView.m
//  ABUIKit
//
//  Created by qp on 2020/11/2.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIChatItemTextView.h"
@interface ABUIChatItemTextView ()
@property (nonatomic, strong) UIView *bubbleView; //气泡
@property (nonatomic, strong) ABUILabel *titleLabel;
@end
@implementation ABUIChatItemTextView
+(void)load {
    [[ABUIListViewMapping shared] registerClassString:@"ABUIChatItemTextView" native_id:@"item_chat_text"];
}
- (void)setupAdjustContents {
    [super setupAdjustContents];
    
    self.bubbleView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:self.bubbleView];
    self.bubbleView.backgroundColor = [UIColor whiteColor];
    self.bubbleView.layer.cornerRadius = 4;
    self.bubbleView.clipsToBounds = true;
    
    self.titleLabel = [[ABUILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.linkDetectionTypes = ABLinkTypeOptionURL;
    self.titleLabel.font = [ABUIChatConfirgure shared].textFont;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textColor = [UIColor hexColor:@"333333"];
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.titleLabel setUserInteractionEnabled:true];
    [self.bubbleView addSubview:self.titleLabel];
    
    UILongPressGestureRecognizer *longGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longAction:)];
    [self.titleLabel addGestureRecognizer:longGes];
}

- (void)longAction:(UILongPressGestureRecognizer *)longGesture {
    if (longGesture.state == UIGestureRecognizerStateBegan) {
        [ABUITips showError:@"已复制"];
        [UIPasteboard generalPasteboard].string = self.titleLabel.text;
    }
}

- (void)layoutAdjustContents {
    [super layoutAdjustContents];
    self.titleLabel.centerY = self.height/2;
    self.titleLabel.centerX = self.bubbleView.width/2;
    
    self.bubbleView.height = self.height;
}

- (void)reload:(NSDictionary *)item extra:(NSDictionary *)extra indexPath:(NSIndexPath *)indexPath {
    [super reload:item extra:extra indexPath:indexPath];
    
    NSString *content = item[@"content"];
    self.titleLabel.attributedText = [ABUIChatHelper formatMessageString:content withFont:[ABUIChatConfirgure shared].textFont];
    self.titleLabel.width = [item[@"content.width"] floatValue];
    self.titleLabel.height = [item[@"content.height"] floatValue];
    
    self.bubbleView.height = self.height;
    
    self.bubbleView.width = self.titleLabel.width+20;
    if ([self isLeft]) {
        self.bubbleView.backgroundColor = [UIColor whiteColor];
        self.bubbleView.left = self.avatarImageView.right+10;
    }else{
        self.bubbleView.backgroundColor = [UIColor hexColor:@"96E96F"];
        self.bubbleView.left = self.avatarImageView.left-10-self.bubbleView.width;
    }
    
    
}

@end
