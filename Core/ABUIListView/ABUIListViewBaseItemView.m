//
//  ABUIListViewBaseItemView.m
//  ABUIKit
//
//  Created by qp on 2020/10/9.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIListViewBaseItemView.h"
@interface ABUIListViewBaseItemView()
@property (nonatomic, weak)UITextField *_ownTextField;
@end

@implementation ABUIListViewBaseItemView
- (ABUIListViewStack *)stack {
    return self.cell.stack;
}

- (void)listenInput:(UITextField *)textField {
    self._ownTextField = textField;
    
}

- (void)reloadTextFiedData {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    id rData = [self.cell userProvideData];
    if (rData != nil && [rData isKindOfClass:[NSString class]]) {
        self._ownTextField.text = (NSString *)rData;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTextFieldChanged) name:UITextFieldTextDidChangeNotification object:self._ownTextField];
}

- (void)onTextFieldChanged {
    [self.cell setUserProvideData:self._ownTextField.text];
}
@end
