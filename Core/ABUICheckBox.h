//
//  ABUICheckBox.h
//  ABUIKit
//
//  Created by qp on 2020/7/20.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABUICheckBox : UIView
@property (nonatomic, assign) UIColor *contentColor;
@property (nonatomic, assign) UIColor *normalBorderColor;
@property (nonatomic, assign) UIColor *selectBorderColor;
@property (nonatomic, assign) BOOL isSelected;
@end

NS_ASSUME_NONNULL_END
