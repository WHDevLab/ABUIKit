//
//  ABUIBorderLabel.h
//  ABUIKit
//
//  Created by qp on 2020/6/23.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABUIBorderLabel : UILabel
@property (nonatomic, assign) CGFloat outerWidth;
//描边颜色
@property (nonatomic, strong) UIColor *outerColor;
//文字颜色
@property (nonatomic, strong) UIColor *interColor;
@end

NS_ASSUME_NONNULL_END
