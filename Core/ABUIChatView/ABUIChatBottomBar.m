//
//  ABUIChatBottomBar.m
//  ABUIKit
//
//  Created by qp on 2020/9/16.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIChatBottomBar.h"

@interface ABUIChatBottomBar ()<QMUITextViewDelegate>
@end
@implementation ABUIChatBottomBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.moreButton = [[QMUIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-10-40, 0, 40, 40)];
        [self addSubview:self.moreButton];
        
        self.emojiButton = [[QMUIButton alloc] initWithFrame:CGRectMake(self.moreButton.left-40, 0, 40, 40)];
        [self addSubview:self.emojiButton];
        
        self.textView = [[QMUITextView alloc] initWithFrame:CGRectMake(10, 5, self.emojiButton.left-15, self.frame.size.height-10)];
        self.textView.delegate = self;
        self.textView.returnKeyType = UIReturnKeySend;
        self.textView.backgroundColor = [UIColor whiteColor];
        self.textView.layer.cornerRadius = 4;
        self.textView.clipsToBounds = true;
        self.textView.font = [UIFont PingFangSC:16];
        [self addSubview:self.textView];
    
        
        self.emojiButton.centerY = self.height/2;
        self.moreButton.centerY = self.height/2;
        self.textView.centerY = self.height/2;
    }
    return self;
}

// 实现这个 delegate 方法就可以实现自增高
- (void)textView:(QMUITextView *)textView newHeightAfterTextChanged:(CGFloat)height {
    height = fmax(height, 40);
    BOOL needsChangeHeight = CGRectGetHeight(textView.frame) != height;
    if (needsChangeHeight) {
        self.height = height+10;
    }
}

- (void)textView:(QMUITextView *)textView didPreventTextChangeInRange:(NSRange)range replacementText:(NSString *)replacementText {
    [ABUITips showError:[NSString stringWithFormat:@"最多输入 %@ 个字", @(textView.maximumTextLength)]];
}

- (BOOL)textViewShouldReturn:(QMUITextView *)textView {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(bottomBar:onText:)]) {
//        [self.delegate bottomBar:self onText:textView.text];
//    }
    textView.text = nil;
    return YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textView.height = self.height-10;
    self.textView.centerY = self.height/2;
    
    self.moreButton.top = self.height-self.moreButton.height-5;
    self.emojiButton.top = self.height-self.emojiButton.height-5;
}

@end
