//
//  ABUIChatFaceView.h
//  ABUIKit
//
//  Created by qp on 2020/11/7.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABUIListViewBaseItemView.h"
NS_ASSUME_NONNULL_BEGIN

@protocol ABUIChatFaceViewDelegate <NSObject>

- (void)faceViewDidClickDelete;

- (void)faceViewDidClickSend;
- (void)faceViewDidSelect:(NSDictionary *)item;

@end

@interface ABUIChatFaceItemView : ABUIListViewBaseItemView

@end

@interface ABUIChatFaceView : UIView
@property (nonatomic, weak) id<ABUIChatFaceViewDelegate> delegate;
- (BOOL)isEmojiString:(NSString *)str;
- (void)setZero:(BOOL)zero;
@end

NS_ASSUME_NONNULL_END
