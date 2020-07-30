//
//  ABWebView.h
//  ABUIKit
//
//  Created by qp on 2020/6/18.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ABUIWebView;
NS_ASSUME_NONNULL_BEGIN

@protocol ABUIWebViewDelegate<NSObject>
- (void)abwebview:(ABUIWebView *)abwebview onTitleLoaded:(NSString *)string;
- (void)abwebview:(ABUIWebView *)abwebview onLoadedProgress:(CGFloat)progress;
- (void)abwebview:(ABUIWebView *)abwebview onReceiveMessage:(NSDictionary *)message;
@end

@interface ABUIWebView : UIView
@property (nonatomic, weak) id<ABUIWebViewDelegate> delegate;
@property (nonatomic, strong) NSString *bridgeMethod;

- (void)loadWebWithPath:(NSString *)path;

- (void)callFuncName:(NSString *)funcName data:(NSString *)data completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
