//
//  ABUICodeInput.h
//  ABUIKit
//
//  Created by qp on 2020/7/2.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABUITextField.h"
#import "ABCountDownButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface ABUICodeInput : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) ABUITextField *textField;
@property (nonatomic, strong) ABCountDownButton *cbButton;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger downCount;
@end

NS_ASSUME_NONNULL_END
