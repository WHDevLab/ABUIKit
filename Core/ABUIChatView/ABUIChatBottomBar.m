//
//  ABUIChatBottomBar.m
//  ABUIKit
//
//  Created by qp on 2020/9/16.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIChatBottomBar.h"
#import "ABUIChatConfirgure.h"
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
        self.textView.enablesReturnKeyAutomatically = true;
        self.textView.font = [UIFont PingFangSC:16];
        [self addSubview:self.textView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTextViewDidChanged) name:UITextViewTextDidChangeNotification object:nil];
    
        
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
        [self.delegate bottomBar:self heightChanged:self.height];
    }
}

- (void)textView:(QMUITextView *)textView didPreventTextChangeInRange:(NSRange)range replacementText:(NSString *)replacementText {
    [ABUITips showError:[NSString stringWithFormat:@"最多输入 %@ 个字", @(textView.maximumTextLength)]];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString *viewText = textView.text;
    if ([text isEqualToString:@"\n"]) { //换行
        return false;
    }
    if ([text isEqualToString:@"@"]) { //@处理
        
    }
    if (text.length == 0 && viewText.length > 0) {
        //[表情]删除
        if ([viewText characterAtIndex:range.location] == ']') {
            NSUInteger location = range.location;
            NSUInteger length = range.length;
            while (location != 0) {
                location --;
                length ++ ;
                char c = [viewText characterAtIndex:location];
                if (c == '[') {
                    NSString *emij = [viewText substringWithRange:NSMakeRange(location, length)];
                    if ([[ABUIChatConfirgure shared].emojiSets containsObject:emij]) {
                        textView.text = [viewText stringByReplacingCharactersInRange:NSMakeRange(location, length) withString:@""];
                    }
                    return false;
                } else if (c == ']') {
                    return true;
                }
            }
        }
    }
    
    return true;
}

- (BOOL)textViewShouldReturn:(QMUITextView *)textView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(bottomBar:onSendText:)]) {
        [self.delegate bottomBar:self onSendText:textView.text];
    }
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

- (void)setFaceView:(ABUIChatFaceView *)faceView {
    _faceView = faceView;
    [self onTextViewDidChanged];
}

- (void)onTextViewDidChanged {
    [self.faceView setZero:self.text.length == 0];
}

- (void)appendText:(NSString *)text {
    [self.textView insertText:text];
}

- (void)clearText {
    self.textView.text = @"";
}

- (NSString *)text {
    NSString *tt = [self.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return tt;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
