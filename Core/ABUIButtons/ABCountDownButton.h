//
//  ABCountDownButton.h
//  ABUIKit
//
//  Created by qp on 2020/6/21.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ABCountDownButton;
typedef NSString* _Nullable (^CountDownChanging)(ABCountDownButton *countDownButton,NSUInteger second);
typedef NSString* _Nonnull (^CountDownFinished)(ABCountDownButton *countDownButton,NSUInteger second);
typedef void (^TouchedCountDownButtonHandler)(ABCountDownButton *countDownButton,NSInteger tag);

@interface ABCountDownButton : UIButton
@property(nonatomic,strong) id userInfo;
///倒计时按钮点击回调
- (void)countDownButtonHandler:(TouchedCountDownButtonHandler)touchedCountDownButtonHandler;
//倒计时时间改变回调
- (void)countDownChanging:(CountDownChanging)countDownChanging;
//倒计时结束回调
- (void)countDownFinished:(CountDownFinished)countDownFinished;
///开始倒计时
- (void)startCountDownWithSecond:(NSUInteger)second;
///停止倒计时
- (void)stopCountDown;
@end

NS_ASSUME_NONNULL_END
