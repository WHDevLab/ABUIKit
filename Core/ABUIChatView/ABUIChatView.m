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
@interface ABUIChatView ()
@property (nonatomic, strong) UIView *safeView;
@end

@implementation ABUIChatView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self listenKeyboard];
        
        self.backgroundColor = [UIColor hexColor:@"ededed"];
        
        self.safeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, SAFEHEIGHT)];
        self.safeView.backgroundColor = [UIColor hexColor:@"f6f6f6"];
        [self addSubview:self.safeView];
        
        self.toolBar = [[ABUIChatBottomBar alloc] initWithFrame:CGRectMake(0, 0, self.width, 50)];
        self.toolBar.backgroundColor = [UIColor hexColor:@"f6f6f6"];
        [self addSubview:self.toolBar];
    }
    return self;
}

- (void)listenKeyboard {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - Keyboard notifications
- (void)handleKeyboardWillChangeFrame:(NSNotification *)notification{
    NSLog(@"keyboard change frame");
//    [self.chatToolbar chatKeyboardWillChangeFrame:notification];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.safeView.top = self.height-self.safeView.height;
    self.toolBar.top = self.height-self.toolBar.height-SAFEHEIGHT;
}

@end
