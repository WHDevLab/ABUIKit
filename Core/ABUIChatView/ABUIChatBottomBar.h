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
#import "ABUIChatFaceView.h"
NS_ASSUME_NONNULL_BEGIN
@class ABUIChatBottomBar;
@protocol ABUIChatBottomBarDelegate <NSObject>

- (void)bottomBar:(ABUIChatBottomBar *)bottomBar onSendText:(NSString *)text;
- (void)bottomBar:(ABUIChatBottomBar *)bottomBar heightChanged:(CGFloat)newHeight;
- (void)bottomBar:(ABUIChatBottomBar *)bottomBar zeroText:(BOOL)zeroText;
@end
@interface ABUIChatBottomBar : UIView
@property (nonatomic, weak) id<ABUIChatBottomBarDelegate> delegate;
@property (nonatomic, strong) QMUITextView *textView;

@property (nonatomic, strong) QMUIButton *emojiButton;
@property (nonatomic, strong) QMUIButton *moreButton;

@property (nonatomic, weak) ABUIChatFaceView *faceView;
@property (nonatomic, strong) NSString *text;

- (void)appendText:(NSString *)text;
- (void)clearText;
@end

NS_ASSUME_NONNULL_END
