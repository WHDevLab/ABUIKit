//
//  ABUIViewCreator.h
//  ABUIKit
//
//  Created by qp on 2021/3/11.
//  Copyright © 2021 abteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ABUITextField.h"
#import "UIColor+AB.h"
NS_ASSUME_NONNULL_BEGIN

@interface ABUIViewCreator : NSObject
+ (UIButton *)createButtonWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize isBold:(BOOL)isBold;

+ (UIButton *)createButtonWithImageName:(NSString *)imageName;

+ (ABUITextField *)createShadowInput;

@end

NS_ASSUME_NONNULL_END
