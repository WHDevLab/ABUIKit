//
//  ABUIListViewInputItemView.m
//  ABUIKit
//
//  Created by qp on 2020/10/9.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIListViewInputItemView.h"
#import "ABUIListViewMapping.h"
#import "UIView+AB.h"
#import "UIFont+AB.h"
#import "UIColor+AB.h"
@interface ABUIListViewInputItemView ()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *phTextField;
@end
@implementation ABUIListViewInputItemView

+(void)load {
    [[ABUIListViewMapping shared] registerClassString:@"ABUIListViewInputItemView" native_id:@"abinput"];
}

- (void)setupAdjustContents {
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, self.frame.size.height)];
    self.titleLabel.font = [UIFont PingFangSC:16];
    self.titleLabel.textColor = [UIColor hexColor:@"222222"];
    [self addSubview:self.titleLabel];
    
    self.phTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.titleLabel.right+10, 0, self.width-10-self.titleLabel.right-15, self.frame.size.height)];
    self.phTextField.font = [UIFont PingFangSC:16];
    self.phTextField.textColor = [UIColor hexColor:@"222222"];
    self.phTextField.returnKeyType = UIReturnKeyDone;
    self.phTextField.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTextFieldChanged) name:UITextFieldTextDidChangeNotification object:self.phTextField];
    [self addSubview:self.phTextField];
}

- (void)onTextFieldChanged {
    [self.cell refreshUserProvideData];
}

- (id)userProvideData {
    return self.phTextField.text;
}

- (void)layoutAdjustContents {
    
}

- (void)reload:(NSDictionary *)item {
    self.titleLabel.text = item[@"title"];
    
    self.phTextField.placeholder = item[@"placeholder"];
    self.phTextField.text = item[@"content"];
    
    self.phTextField.keyboardType = UIKeyboardTypeDefault;
    if ([item[@"type"] isEqualToString:@"number"]) {
        self.phTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    id rData = [self.cell userProvideData];
    if (rData != nil && [rData isKindOfClass:[NSString class]]) {
        self.phTextField.text = (NSString *)rData;
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}




- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
