//
//  ABUITextField.m
//  ABUIKit
//
//  Created by qp on 2020/6/22.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUITextField.h"
@class ABUITextField;
@interface _ABUITextFieldDelegator : NSObject <ABUITextFieldDelegate, UIScrollViewDelegate>

@property(nonatomic, weak) ABUITextField *textField;
- (void)handleTextChangeEvent:(ABUITextField *)textField;
@end

@interface ABUITextField ()

@property(nonatomic, strong) _ABUITextFieldDelegator *delegator;
@end



@implementation _ABUITextFieldDelegator
- (void)handleTextChangeEvent:(ABUITextField *)textField {
    
}
@end


@implementation ABUITextField
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self didInitialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self didInitialize];
    }
    return self;
}

- (void)didInitialize {
    self.delegator = [[_ABUITextFieldDelegator alloc] init];
    self.delegator.textField = self;
    self.delegate = self.delegator;
    [self addTarget:self.delegator action:@selector(handleTextChangeEvent:) forControlEvents:UIControlEventEditingChanged];
    
    self.shouldResponseToProgrammaticallyTextChanges = YES;
    self.maximumTextLength = NSUIntegerMax;
    
}

- (void)dealloc {
    self.delegate = nil;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    if (self.placeholder) {
        [self updateAttributedPlaceholderIfNeeded];
    }
}

- (void)setPlaceholder:(NSString *)placeholder {
    [super setPlaceholder:placeholder];
    if (self.placeholderColor) {
        [self updateAttributedPlaceholderIfNeeded];
    }
}

- (void)updateAttributedPlaceholderIfNeeded {
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: self.placeholderColor}];
    
}

#pragma mark - Positioning Overrides

- (CGRect)textRectForBounds:(CGRect)bounds {
    bounds = UIEdgeInsetsInsetRect(bounds, self.textInsets);
    CGRect resultRect = [super textRectForBounds:bounds];
    return resultRect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    bounds = UIEdgeInsetsInsetRect(bounds, self.textInsets);
    return [super editingRectForBounds:bounds];
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
    CGRect result = [super clearButtonRectForBounds:bounds];
    result = CGRectOffset(result, self.clearButtonPositionAdjustment.horizontal, self.clearButtonPositionAdjustment.vertical);
    return result;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // iOS 10 之后，UITextField 输入中文超过文本框宽度后再删除，文字会往下掉
    if (@available(iOS 10.0, *)) {
        UIScrollView *scrollView = self.subviews.firstObject;
        if (![scrollView isKindOfClass:[UIScrollView class]]) {
            return;
        }
        
        // 默认 delegate 是为 nil 的，所以我们才利用 delegate 修复这 个 bug，如果哪一天 delegate 不为 nil，就先不处理了。
        if (scrollView.delegate) {
            return;
        }
        
        scrollView.delegate = self.delegator;
    }
}



@end
