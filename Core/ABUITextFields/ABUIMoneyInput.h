//
//  ABUIMoneyInput.h
//  ABUIKit
//
//  Created by qp on 2020/9/2.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABUITextField.h"
NS_ASSUME_NONNULL_BEGIN

@interface ABUIMoneyInput : UIView
@property (nonatomic, strong) ABUITextField *textField;
@property (nonatomic, assign) int maxdecimal; //最大小数点数
@end

NS_ASSUME_NONNULL_END
