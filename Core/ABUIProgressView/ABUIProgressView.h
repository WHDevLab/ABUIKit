//
//  ABUIProgressView.h
//  ABUIKit
//
//  Created by qp on 2020/12/14.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABUIProgressView : UIView
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) CGFloat cornerRadius;
@property(nonatomic, strong, nullable) UIColor* progressTintColor;
@property(nonatomic, strong, nullable) UIColor* trackTintColor;
@end

NS_ASSUME_NONNULL_END
