//
//  ABUIChatBottomBar.h
//  ABUIKit
//
//  Created by qp on 2020/9/16.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QMUIKit/QMUIKit.h>
#import "UIView+AB.h"
#import "UIFont+AB.h"
#import "UIColor+AB.h"
#import "ABUITips.h"
NS_ASSUME_NONNULL_BEGIN

@interface ABUIChatBottomBar : UIView
@property (nonatomic, strong) QMUITextView *textView;

@property (nonatomic, strong) QMUIButton *emojiButton;
@property (nonatomic, strong) QMUIButton *moreButton;
@end

NS_ASSUME_NONNULL_END
