//
//  ABUITexttInput.h
//  ABUIKit
//
//  Created by qp on 2020/7/2.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABUITextField.h"
NS_ASSUME_NONNULL_BEGIN

@interface ABUITextInput : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) ABUITextField *textField;
@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *iconImageName;
@end

NS_ASSUME_NONNULL_END
