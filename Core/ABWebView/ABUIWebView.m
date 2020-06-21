//
//  ABWebView.m
//  ABUIKit
//
//  Created by qp on 2020/6/18.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIWebView.h"
#import <WebKit/WebKit.h>
#import "UIView+AB.h"
@interface ABUIWebView ()<WKNavigationDelegate, WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic,strong)  UIView *progressView;
@end
@implementation ABUIWebView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.bridgeMethod = @"bridge";
        
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        [configuration.userContentController addScriptMessageHandler:self name:self.bridgeMethod];
        
        self.webView = [[WKWebView alloc] initWithFrame:self.bounds configuration:configuration];
        self.webView.navigationDelegate = self;
        [self addSubview:self.webView];
        
        self.progressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 2)];
        self.progressView.backgroundColor = [UIColor redColor];
        [self addSubview:self.progressView];
        
        //TODO:kvo监听，获得页面title和加载进度值
        [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
        [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if (message.name == self.bridgeMethod) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(abwebview:onReceiveMessage:)]) {
            if ([message.body isKindOfClass:[NSDictionary class]]) {
                [self.delegate abwebview:self onReceiveMessage:(NSDictionary *)message.body];
            }
        }
    }
}

- (void)loadWebWithURL:(NSURL *)url {
    self.progressView.width = 0;
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:url];
    
    if ([url.absoluteString hasPrefix:@"http"]) {
        [self.webView loadRequest:req];
    }else{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"web" ofType:@"html"];
        NSString *indexContent = [NSString stringWithContentsOfFile:path encoding: NSUTF8StringEncoding error:nil];
        [self.webView loadHTMLString:indexContent baseURL:nil];
    }
    
}

- (void)callFuncName:(NSString *)funcName data:(NSString *)data completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))completionHandler {
    NSString *script = [NSString stringWithFormat:@"%@('%@')", funcName, data];
    [self.webView evaluateJavaScript:script completionHandler:completionHandler];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
}

//WKWeView在每次加载请求前会调用此方法来确认是否进行请求跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    if ([navigationAction.request.URL.scheme caseInsensitiveCompare:self.bridgeMethod] == NSOrderedSame) {
        decisionHandler(WKNavigationActionPolicyCancel);
        NSString *queryString = navigationAction.request.URL.query;
        NSArray *sets = [queryString componentsSeparatedByString:@"&"];
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        for (NSString *item in sets) {
            NSArray *xx = [item componentsSeparatedByString:@"="];
            params[xx[0]] = xx[1];
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(abwebview:onReceiveMessage:)]) {
            [self.delegate abwebview:self onReceiveMessage:params];
        }
    }else{
         decisionHandler(WKNavigationActionPolicyAllow);
    }
}

#pragma mark KVO的监听代理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object != self.webView)
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    
    //加载进度值
    if ([keyPath isEqualToString:@"estimatedProgress"])
    {
        self.progressView.width = self.bounds.size.width*self.webView.estimatedProgress;
        if (self.webView.estimatedProgress >= 1) {
            [self.progressView setHidden:true];
        }else{
            [self.progressView setHidden:false];
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(abwebview:onLoadedProgress:)]) {
            [self.delegate abwebview:self onLoadedProgress:self.webView.estimatedProgress];
        }
    }
    //网页title
    else if ([keyPath isEqualToString:@"title"])
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(abwebview:onTitleLoaded:)]) {
            [self.delegate abwebview:self onTitleLoaded:self.webView.title];
        }
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}

@end
