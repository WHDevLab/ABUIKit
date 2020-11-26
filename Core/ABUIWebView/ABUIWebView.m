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

@interface ABUIWebView ()<WKNavigationDelegate, WKScriptMessageHandler, UIScrollViewDelegate>
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
        self.scrollEnable = true;
        self.isShowProgress = true;
        self.isLoaded = false;
        
        self.scriptQuene = [[NSMutableArray alloc] init];
        
        NSString *jScript = @"var meta = document.createElement('meta');"
                            "meta.name = 'viewport';"
                            "meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';"
                            "var head = document.getElementsByTagName('head')[0];"
                            "head.appendChild(meta);document.documentElement.style.webkitTouchCallout='none';document.documentElement.style.webkitUserSelect='none';";
        
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        
        _configuration = [[WKWebViewConfiguration alloc] init];
        [_configuration.userContentController addScriptMessageHandler:self name:self.bridgeMethod];
        [_configuration.userContentController addUserScript:wkUScript];
        
        self.webView = [[WKWebView alloc] initWithFrame:self.bounds configuration:_configuration];
        self.webView.height = 0;
        self.webView.navigationDelegate = self;
        self.webView.scrollView.delegate = self;
        if (@available(iOS 13.0, *)) {
            [self.webView.scrollView setAutomaticallyAdjustsScrollIndicatorInsets:false];
        } else {
            // Fallback on earlier versions
        }
        if (@available(iOS 11.0, *)) {
//            self.webView.scrollView.scrollIndicatorInsets = self.webView.contentInset;
            [self.webView.scrollView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        } else {
            // Fallback on earlier versions
        }
        self.webView.scrollView.contentInset = UIEdgeInsetsZero;
        self.webView.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
        [self addSubview:self.webView];
        
        self.progressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 2)];
        self.progressView.backgroundColor = [UIColor redColor];
        [self addSubview:self.progressView];
        [self.progressView setHidden:true];
        
        //TODO:kvo监听，获得页面title和加载进度值
        [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
        [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
        [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:NULL];

    }
    return self;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return nil;
}

- (void)setScrollEnable:(BOOL)scrollEnable {
    _scrollEnable = scrollEnable;
    self.webView.scrollView.scrollEnabled = scrollEnable;
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
        NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:5];
        [self.webView loadRequest:req];
    }else{
        NSString *pp = [[NSBundle mainBundle] pathForResource:path ofType:nil];
        NSString *indexContent = [NSString stringWithContentsOfFile:pp encoding: NSUTF8StringEncoding error:nil];
        NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]];
        [self.webView loadHTMLString:indexContent baseURL:baseURL];
    }
}

- (void)loadWebWithHTMLString:(NSString *)string {
    NSString *header =@"<head><meta content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0\" name=\"viewport\"><style>body,html{width: 100%;height: 100%;}*{margin:0;padding:0;}img{max-width:100%;min-width:100%;display:block; width:auto; height:auto;}</style></head>";
    NSString *html = [NSString stringWithFormat:@"<html>%@<body>%@</body></html>",header,string];
    [self.webView loadHTMLString:html baseURL:nil];
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
    [self _runScriptQueue];
    if (self.scrollEnable == true) {
        return;
    }

    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];
    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
    [self.webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.background='rgba(0,0,0,0)'" completionHandler:nil];
    
    NSString *imgjs = @"var imgs = document.getElementsByTagName('div');for(var i=0;i<imgs.length;i++){imgs[i].style.width='100%';};";

    NSString *tablejs = @"var imgs = document.getElementsByTagName('table');for(var i=0;i<imgs.length;i++){imgs[i].style.width='100%';};";
    [self.webView evaluateJavaScript:tablejs completionHandler:^(id obj, NSError * _Nullable error) {

    }];

    [self.webView evaluateJavaScript:imgjs completionHandler:^(id obj, NSError * _Nullable error) {
        NSLog(@"%@", obj);
    }];
    
    [self.webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id obj, NSError * _Nullable error) {
        NSLog(@"%@", obj);
    }];
    
    [self.webView evaluateJavaScript:@"document.readyState" completionHandler:^(id complete, NSError * _Nullable error) {
        if (complete != nil) {
            [self.webView evaluateJavaScript:@"document.documentElement.scrollHeight" completionHandler:^(id height, NSError * _Nullable error1) {
                self.height = [height floatValue];
                if (self.delegate && [self.delegate respondsToSelector:@selector(abwebview:newHeight:)]) {
                    [self.delegate abwebview:self newHeight:self.height];
                }
            }];
        }
    }];
    

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
    
//    if (object != self.webView)
//    {
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//        return;
//    }
//
    //加载进度值
    if ([keyPath isEqualToString:@"estimatedProgress"] && self.isShowProgress)
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
    else if ([keyPath isEqualToString:@"contentSize"] && self.adapterSize) {
        self.height = self.webView.scrollView.contentSize.height;
        self.width = self.webView.scrollView.contentSize.width;
//        self.width = self.webView.scrollView.contentSize.width;
//        NSLog(@"%@", change);
//        if (self.height == self.webView.scrollView.contentSize.height) {
//            return;
//        }
//        self.height = self.webView.scrollView.contentSize.height;
//        NSLog(@"%f", self.height);
//        if (self.delegate && [self.delegate respondsToSelector:@selector(abwebview:newHeight:)]) {
//            [self.delegate abwebview:self newHeight:self.height];
//        }
    }
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.webView.frame = self.bounds;
}

- (void)free {
    self.webView.navigationDelegate = nil;
    self.webView.scrollView.delegate = nil;
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:self.bridgeMethod];
    [self.webView removeFromSuperview];
    self.webView = nil;
}

- (void)dealloc
{
    NSLog(@"webview dealloc");
}


/**
 html 富文本设置

 @param str html 未处理的字符串
 @param font 设置字体
 @param lineSpacing 设置行高
 @return 默认不将 \n替换<br/> 返回处理好的富文本
 */
-(NSMutableAttributedString *)setAttributedString:(NSString *)str font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing
{
    

    //如果有换行，把\n替换成<br/>
    //如果有需要把换行加上
//    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
    //设置HTML图片的宽度
    str = [NSString stringWithFormat:@"<head><style>img{width:%f !important;height:auto}</style></head>%@",[UIScreen mainScreen].bounds.size.width,str];
    NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
    //设置富文本字的大小
//    [htmlString addAttributes:@{NSFontAttributeName:font} range:NSMakeRange(0, htmlString.length)];
    //设置行间距
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle setLineSpacing:lineSpacing];
//    [htmlString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [htmlString length])];
    
    return htmlString;

}



/**
 计算html字符串高度

 @param str html 未处理的字符串
 @param font 字体设置
 @param lineSpacing 行高设置
 @param width 容器宽度设置
 @return 富文本高度
 */
-(CGFloat )getHTMLHeightByStr:(NSString *)str font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing width:(CGFloat)width
{
//    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
    str = [NSString stringWithFormat:@"<head><style>img{width:%f !important;height:auto}</style></head>%@",[UIScreen mainScreen].bounds.size.width,str];
    
    NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
    [htmlString addAttributes:@{NSFontAttributeName:font} range:NSMakeRange(0, htmlString.length)];
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:lineSpacing];
    [htmlString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [htmlString length])];
    
    CGSize contextSize = [htmlString boundingRectWithSize:(CGSize){width, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    return contextSize.height ;
    

}


@end
