//
//  ABUIListReusableView.m
//  Demo
//
//  Created by qp on 2020/5/9.
//  Copyright © 2020 ab. All rights reserved.
//

#import "ABUIListReusableView.h"
#import "ABUIListViewProtocols.h"
#import "ABUIListViewBaseItemView.h"
@interface ABUIListReusableView ()
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, assign) CGFloat lPadding;
@property (nonatomic, assign) CGFloat rPadding;
@property (nonatomic, strong) NSString *itemKey;
@property (nonatomic, strong) NSDictionary *item;
@end
@implementation ABUIListReusableView
- (void)reload:(NSDictionary *)item clsStr:(NSString *)clsStr {
    if (clsStr == nil) {
        NSLog(@"classString is empty");
        return;
    }
    self.item = item;
    self.itemKey = item[@"itemKey"];
    if (self.mainView == nil) {
        CGFloat lPadding = [item[@"padding.left"] floatValue];
        CGFloat rPadding = [item[@"padding.right"] floatValue];
        self.lPadding = lPadding;
        self.rPadding = rPadding;
        self.mainView = [(UIView *)[NSClassFromString(clsStr) alloc] initWithFrame:CGRectMake(lPadding, 0, self.frame.size.width-lPadding-rPadding, self.frame.size.height)];
        if ([self.mainView isKindOfClass:[ABUIListViewBaseItemView class]]) {
            [(ABUIListViewBaseItemView *)self.mainView setCell:self];
        }
        if ([self.mainView conformsToProtocol:@protocol(ABUIListItemViewProtocol)]) {
            [self addSubview:self.mainView];
            [(id<ABUIListItemViewProtocol>)self.mainView setupAdjustContents];
        }else{
            NSAssert(NO, @"itemview 必须准守协议ListItemViewProtocol");
        }
    }
    
    [(id<ABUIListItemViewProtocol>)self.mainView reload:item];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [(id<ABUIListItemViewProtocol>)self.mainView layoutAdjustContents];
    });


    
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.mainView.frame = CGRectMake(self.lPadding, 0, self.frame.size.width-self.lPadding-self.rPadding, self.frame.size.height);
    [(id<ABUIListItemViewProtocol>)self.mainView layoutAdjustContents];
}

- (void)sendActionWithKey:(NSString *)actionKey actionData:(nullable id)actionData {
    if (self.ppx.delegate && [self.ppx.delegate respondsToSelector:@selector(listView:didActionItemAtSection:item:itemKey:actionKey:actionData:)]) {
        [self.ppx.delegate listView:self.ppx didActionItemAtSection:0 item:self.item itemKey:self.itemKey actionKey:actionKey actionData:actionData];
    }
}

@end
