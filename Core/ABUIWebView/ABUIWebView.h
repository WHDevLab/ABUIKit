//
//  ABWebView.h
//  ABUIKit
//
//  Created by qp on 2020/6/18.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

//(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))completionHandler
typedef void (^ABUIWebViewScriptBlock)(_Nullable id, NSError * _Nullable error);

@class ABUIWebView;
NS_ASSUME_NONNULL_BEGIN

@protocol ABUIWebViewDelegate<NSObject>
- (void)abwebview:(ABUIWebView *)abwebview onTitleLoaded:(NSString *)string;
- (void)abwebview:(ABUIWebView *)abwebview onLoadedProgress:(CGFloat)progress;
- (void)abwebview:(ABUIWebView *)abwebview onReceiveMessage:(NSDictionary *)message;
- (void)abwebview:(ABUIWebView *)abwebview newHeight:(CGFloat)height;
@end

@interface ABUIWebViewScript : NSObject
@property (nonatomic, strong) NSString *script;
@property (nonatomic, assign) ABUIWebViewScriptBlock completionHandler;

@end

@interface ABUIWebView : UIView
@property (nonatomic, weak) id<ABUIWebViewDelegate> delegate;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, assign) BOOL bounces;
@property (nonatomic, strong) NSString *bridgeMethod;
@property (nonatomic, assign) BOOL adapterSize;
@property (nonatomic, assign) BOOL isShowProgress;
@property (nonatomic, assign) BOOL scrollEnable;

- (void)loadWebWithPath:(NSString *)path;
- (void)loadWebWithHTMLString:(NSString *)string;
- (void)callFuncName:(NSString *)funcName data:(NSString *)data completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))completionHandler;

- (void)free;

@end

NS_ASSUME_NONNULL_END
