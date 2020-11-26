//
//  ABUIChatView.m
//  ABUIKit
//
//  Created by qp on 2020/9/16.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIChatView.h"
#import "ABUIChatBottomBar.h"
#import "UIView+AB.h"
#import "ABDefines.h"
#import "UIColor+AB.h"
#import "ABUIListView.h"
#import "ABIteration.h"
#import "NSString+AB.h"
#import "ABUIChatConfirgure.h"
#import <QMUIKit/QMUIKit.h>
#import "ABUIChatFaceView.h"
#import "ABUIChatMutiFuncView.h"
#import "ABUIChatHelper.h"
@interface ABUIChatView ()<ABUIChatBottomBarDelegate, ABUIListViewDelegate, QMUIKeyboardManagerDelegate, ABUIChatFaceViewDelegate>
@property (nonatomic, strong) UIView *safeView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) ABUIListView *mainListView;
@property (nonatomic, strong) NSMutableArray *tmessageList;
@property (nonatomic, strong) QMUIKeyboardManager *manager;
@property (nonatomic, assign) CGFloat distanceFromBottom;
@property (nonatomic, strong) ABUIChatFaceView *faceView;
@property (nonatomic, strong) ABUIChatMutiFuncView *mutiFuncView;
@end

@implementation ABUIChatView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpData];
        [self appendSafeView];
        [self setUpUI];

    }
    
    return self;
}

#pragma mark ------- setUp ui、data -------
- (void)setUpData {
    self.tmessageList = [[NSMutableArray alloc] init];
    self.backgroundColor = [UIColor hexColor:@"ededed"];
    
    self.insetBottom = SAFEHEIGHT;
    self.distanceFromBottom = self.insetBottom;
    self.manager = [[QMUIKeyboardManager alloc] initWithDelegate:self];
}

- (void)setUpUI {
    //聊天主视图
    self.mainListView = [[ABUIListView alloc] initWithFrame:self.bounds];
    self.mainListView.delegate = self;
    self.mainListView.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    [self addSubview:self.mainListView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap)];
    [self.mainListView addGestureRecognizer:tap];
    
    
    //控制视图
    self.toolBar = [[ABUIChatBottomBar alloc] initWithFrame:CGRectMake(0, 0, self.width, 50)];
    self.toolBar.delegate = self;
    [self.toolBar.emojiButton addTarget:self action:@selector(previewEmojiView) forControlEvents:UIControlEventTouchUpInside];
    [self.toolBar.moreButton addTarget:self action:@selector(previewMutiFuncView) forControlEvents:UIControlEventTouchUpInside];
    self.toolBar.backgroundColor = [UIColor hexColor:@"f6f6f6"];
    [self addSubview:self.toolBar];
    
    //表情
    self.faceView = [[ABUIChatFaceView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    self.faceView.delegate = self;
    [self addSubview:self.faceView];
    self.toolBar.faceView = _faceView;

    //多功能
    self.mutiFuncView = [[ABUIChatMutiFuncView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
    [self addSubview:self.mutiFuncView];
    [self.mutiFuncView addLineDirection:LineDirectionTop color:[UIColor hexColor:@"dedede"] width:LINGDIANWU];
    
}

- (void)appendSafeView {
    CGFloat safeHeight = 0;
    if (IS_iPhoneX) {
        safeHeight = SAFEHEIGHT+44;
    }
    self.safeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, safeHeight)];
//    self.safeView.backgroundColor = [UIColor hexColor:@"ededed"];
    self.safeView.backgroundColor = [UIColor hexColor:@"f6f6f6"];
    [self addSubview:self.safeView];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.safeView.top = self.height-self.safeView.height;
    self.toolBar.bottom = self.height-self.distanceFromBottom;
    self.mainListView.frame = CGRectMake(0, 0, self.width, self.toolBar.top);
    self.faceView.top = self.height;
    self.mutiFuncView.top = self.height;
}

#pragma mark ------------ actions ----------
- (void)keyboardWillShowWithUserInfo:(QMUIKeyboardUserInfo *)keyboardUserInfo {
    NSLog(@"keyboardWillShowWithUserInfo");
    self.distanceFromBottom = [QMUIKeyboardManager distanceFromMinYToBottomInView:self keyboardRect:keyboardUserInfo.endFrame];
    self.previewType = ABUIChatPreviewTypeKeyboard;
}

- (void)keyboardWillHideWithUserInfo:(QMUIKeyboardUserInfo *)keyboardUserInfo {
    NSLog(@"keyboardWillHideWithUserInfo");
    if (self.previewType == ABUIChatPreviewTypeKeyboard) { //键盘开启，直接直接点击表情情况规避动画下去又上来
        self.distanceFromBottom = SAFEHEIGHT;
        self.previewType = ABUIChatPreviewTypeNone;
    }
}

- (void)setDistanceFromBottom:(CGFloat)distanceFromBottom {
    _distanceFromBottom = distanceFromBottom;
    NSLog(@"distanceFromBottom%f", distanceFromBottom);
}

- (void)onTap {
    if (self.previewType == ABUIChatPreviewTypeNone) {
        return;
    }
    self.distanceFromBottom = SAFEHEIGHT;
    self.previewType = ABUIChatPreviewTypeNone;
}

#pragma mark ------------ time to preview ----------
//显示表情
- (void)previewEmojiView {
    self.distanceFromBottom = self.faceView.height;
    self.previewType = ABUIChatPreviewTypeEmoji;
}

//显示多功能
- (void)previewMutiFuncView {
    self.distanceFromBottom = self.mutiFuncView.height;
    self.previewType = ABUIChatPreviewTypeMutiFunc;
}

- (void)adjustListAndBar {
    self.mainListView.height = self.height-self.distanceFromBottom-self.toolBar.height;
    if ([self.mainListView isContentFull]) {
        self.mainListView.bottom = self.toolBar.top+50;
    }
    [self.mainListView scrollToBottom:false];
    self.toolBar.bottom = self.height-self.distanceFromBottom;
    self.mainListView.bottom = self.toolBar.top;
    
    if (self.distanceFromBottom == 0) {
        [self endEditing:true];
        self.faceView.top = self.height;
        self.mutiFuncView.top = self.height;
    }
}

#pragma mark ------------ status ----------
- (void)setPreviewType:(ABUIChatPreviewType)previewType {
    NSLog(@"setPreviewType");
    _previewType = previewType;
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 delay:0 options:458752 animations:^{
        [weakSelf adjustListAndBar];
        if (weakSelf.previewType == ABUIChatPreviewTypeKeyboard) {
            weakSelf.faceView.top = self.height;
            weakSelf.mutiFuncView.top = self.height;
        }
        if (weakSelf.previewType == ABUIChatPreviewTypeEmoji) {
            [weakSelf endEditing:true];
            weakSelf.faceView.top = self.toolBar.bottom;
            weakSelf.mutiFuncView.top = self.height;
        }
        if (weakSelf.previewType == ABUIChatPreviewTypeMutiFunc) {
            [weakSelf endEditing:true];
            weakSelf.mutiFuncView.top = self.toolBar.bottom;
            weakSelf.faceView.top = self.height;
        }
        if (weakSelf.previewType == ABUIChatPreviewTypeNone) {
            [weakSelf endEditing:true];
            weakSelf.faceView.top = self.height;
            weakSelf.mutiFuncView.top = self.height;
        }
    } completion:^(BOOL finished) {
        
    }];

}


#pragma mark - Keyboard notifications
- (void)setMessageList:(NSArray *)messageList {
    NSArray *list = [ABIteration iterationList:messageList block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
        return [self _calcMessageItem:dic];
    }];
    self.tmessageList = [[NSMutableArray alloc] initWithArray:list];
    [self.mainListView setDataList:self.tmessageList css:@{@"item.rowSpacing":@(10)}];
}


- (NSMutableDictionary *)_calcMessageItem:(NSDictionary *)item {
    CGFloat maxWidth = ceil(SCREEN_WIDTH*0.62);
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:item];
    NSString *nid = dic[@"native_id"];
    if ([nid isEqualToString:@"item_chat_text"]) {
        NSAttributedString *content = [ABUIChatHelper formatMessageString:dic[@"content"] withFont:[ABUIChatConfirgure shared].textFont];
        
        NSStringDrawingOptions option = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
//        CGRect rect = [content boundingRectWithSize:size
//                                           options:option
//                                        attributes:attributes
//                                           context:nil];
        CGRect s = [content boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:option context:nil];
//        CGSize s = [content sizeWithFont:[ABUIChatConfirgure shared].textFont constrainedToSize:CGSizeMake(maxWidth, MAXFLOAT)];
        dic[@"content.width"] = @(ceil(s.size.width));
        dic[@"content.height"] = @(s.size.height);
        dic[@"item.size.height"] = @(MAX(s.size.height+16, 40));
    }
    
    return dic;
}

- (void)appendMessage:(NSDictionary *)message {
    NSDictionary *dic = [self _calcMessageItem:message];
    [self.tmessageList addObject:dic];
    [self.mainListView reloadData];
}


- (void)bottomBar:(ABUIChatBottomBar *)bottomBar onSendText:(NSString *)text {
    [self sendText];
}

- (void)bottomBar:(ABUIChatBottomBar *)bottomBar heightChanged:(CGFloat)newHeight {
    [self adjustListAndBar];
}

- (void)layout {
    self.toolBar.bottom = self.height-self.distanceFromBottom;
    self.mainListView.bottom = self.toolBar.top;
}

#pragma mark ------------- delegate ------------

- (void)faceViewDidSelect:(NSDictionary *)item {
    [self.toolBar appendText:item[@"name"]];
}


#pragma mark ----------- send date ------------
- (void)sendText {
    NSString *tt = self.toolBar.text;
    if (tt.length == 0) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(abUIChatView:onSendText:)]) {
        [self.delegate abUIChatView:self onSendText:tt];
    }
    [self.toolBar clearText];
}

- (void)faceViewDidClickSend {
    [self sendText];
}

- (void)faceViewDidClickDelete {
    NSString *text = self.toolBar.textView.text;
    if (text.length == 0) {
        return;
    }
    if ([[text substringFromIndex:text.length-1] isEqualToString:@"]"]) {
        //匹配表情
        NSRange r = [text rangeOfString:@"[" options:NSBackwardsSearch];
        NSString *str = [text substringWithRange:NSMakeRange(r.location, text.length-r.location)];
        if ([self.faceView isEmojiString:str]) {
            self.toolBar.textView.text = [text substringWithRange:NSMakeRange(0, r.location)];
        }else{
            [self.toolBar.textView deleteBackward];
        }

    }else{
        [self.toolBar.textView deleteBackward];
    }
}

- (void)listViewBeginDragging:(ABUIListView *)listView {
    [self onTap];
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    
}


- (void)listViewDidReload:(ABUIListView *)listView {
    [listView scrollToBottom:true];
}

@end
