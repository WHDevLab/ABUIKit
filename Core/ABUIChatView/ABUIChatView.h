//
//  ABUIChatView.h
//  ABUIKit
//
//  Created by qp on 2020/9/16.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABUIChatBottomBar.h"
#import "ABUIChatItemTimeView.h"

typedef enum : NSUInteger {
    ABUIChatPreviewTypeNone,
    ABUIChatPreviewTypeKeyboard,
    ABUIChatPreviewTypeEmoji,
    ABUIChatPreviewTypeMutiFunc,
} ABUIChatPreviewType;

NS_ASSUME_NONNULL_BEGIN
@class ABUIChatView;
@protocol ABUIChatViewDelegate <NSObject>

- (void)abUIChatView:(ABUIChatView *)abUIChatView onSendText:(NSString *)text;

@end
@interface ABUIChatView : UIView
@property (nonatomic, weak) id<ABUIChatViewDelegate> delegate;
@property (nonatomic, strong) ABUIChatBottomBar *toolBar;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) CGFloat insetBottom;
@property (nonatomic, assign) ABUIChatPreviewType previewType;
- (void)setMessageList:(NSArray *)messageList;
- (void)appendMessage:(NSDictionary *)message;

- (void)layout;

@end

NS_ASSUME_NONNULL_END
