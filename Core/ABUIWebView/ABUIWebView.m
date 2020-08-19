//
//  ABWebView.m
//  ABUIKit
//
//  Created by qp on 2020/6/18.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIWebView.h"
#import "UIView+AB.h"

@implementation ABUIWebViewScript


@end

@interface ABUIWebView ()<WKNavigationDelegate, WKScriptMessageHandler>
@property (nonatomic, strong)  WKWebViewConfiguration *configuration;
@property (nonatomic, strong)  UIView *progressView;
@property (nonatomic, strong) NSMutableArray *scriptQuene;
@property (nonatomic, assign) BOOL isLoaded;
@end

@implementation ABUIWebView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.bridgeMethod = @"bridge";
        self.isLoaded = false;
        
        self.scriptQuene = [[NSMutableArray alloc] init];
        
        _configuration = [[WKWebViewConfiguration alloc] init];
        [_configuration.userContentController addScriptMessageHandler:self name:self.bridgeMethod];
        
        self.webView = [[WKWebView alloc] initWithFrame:self.bounds configuration:_configuration];
        self.webView.navigationDelegate = self;
        [self addSubview:self.webView];
        
        self.progressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 2)];
        self.progressView.backgroundColor = [UIColor redColor];
        [self addSubview:self.progressView];
        
        //TODO:kvo监听，获得页面title和加载进度值
        [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
        [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
//        [self.webView addObserver:self forKeyPath:@"scrollView.contentSize" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if (message.name == self.bridgeMethod) {
        NSLog(@"didReceiveScriptMessage:%@", message.body);
        if (self.delegate && [self.delegate respondsToSelector:@selector(abwebview:onReceiveMessage:)]) {
            if ([message.body isKindOfClass:[NSDictionary class]]) {
                [self.delegate abwebview:self onReceiveMessage:(NSDictionary *)message.body];
            }
        }
    }
}

- (void)setBounces:(BOOL)bounces {
    _bounces = bounces;
    self.webView.scrollView.bounces = bounces;
    self.webView.scrollView.showsVerticalScrollIndicator = false;
    self.webView.scrollView.showsHorizontalScrollIndicator = false;
}

- (void)loadWebWithPath:(NSString *)path {
    self.isLoaded = false;
    self.progressView.width = 0;

    if ([path hasPrefix:@"http"]) {
        NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5];
        [self.webView loadRequest:req];
    }else{
        NSString *pp = [[NSBundle mainBundle] pathForResource:path ofType:nil];
        NSString *indexContent = [NSString stringWithContentsOfFile:pp encoding: NSUTF8StringEncoding error:nil];
        NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]];
        [self.webView loadHTMLString:indexContent baseURL:baseURL];
    }
}

- (void)callFuncName:(NSString *)funcName data:(NSString *)data completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))completionHandler {
    NSString *script = [NSString stringWithFormat:@"%@('%@')", funcName, data];
    if (self.isLoaded) {
        [self.webView evaluateJavaScript:script completionHandler:completionHandler];
    }else{
        ABUIWebViewScript *sc = [[ABUIWebViewScript alloc] init];
        sc.script = script;
        sc.completionHandler = completionHandler;
        [self.scriptQuene addObject:sc];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.isLoaded = true;
    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];
    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
    [self.webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.background='rgba(0,0,0,0)'" completionHandler:nil];
    [self _runScriptQueue];
}

- (void)_runScriptQueue {
    for (ABUIWebViewScript *script in self.scriptQuene) {
        [self.webView evaluateJavaScript:script.script completionHandler:script.completionHandler];
    }
    
    [self.scriptQuene removeAllObjects];
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
    else if ([keyPath isEqualToString:@"scrollView.contentSize"]) {
//        NSLog(self.webView.scrollView.contentSize);
//        self.width = self.webView.scrollView.contentSize.width;
//        self.height = self.webView.scrollView.contentSize.height;
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.webView.frame = self.bounds;
}

- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
//    [self.webView removeObserver:self forKeyPath:@"scrollView.contentSize"];
//    [_configuration.userContentController removeScriptMessageHandlerForName:self._bridgeMethod];
}

@end
