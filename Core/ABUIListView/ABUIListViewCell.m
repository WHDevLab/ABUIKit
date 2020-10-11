//
//  ABUIListViewCell.m
//  Demo
//
//  Created by qp on 2020/5/8.
//  Copyright © 2020 ab. All rights reserved.
//

#import "ABUIListViewCell.h"
#import "ABUIListViewProtocols.h"
#import "ABUIListViewBaseItemView.h"
@interface ABUIListViewCell ()
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) NSString *itemKey;

@property (nonatomic, strong) NSDictionary *item;
@end
@implementation ABUIListViewCell

- (void)reload:(NSDictionary *)item extra:(nullable NSDictionary *)extra clsStr:(nonnull NSString *)clsStr{
    self.item = item;
    self.itemKey = item[@"itemKey"];
    if (clsStr == nil) {
        NSLog(@"%@", item);
        NSLog(@"classString is empty");
        return;
    }

    if (self.mainView != nil) {
        NSString *curClsStr = [[self.mainView class] description];
        if (![clsStr isEqualToString:curClsStr]) {
            [self.mainView removeFromSuperview];
            self.mainView = nil;
        }
    }
    
    if (self.mainView == nil) {
        self.mainView = [[NSClassFromString(clsStr) alloc] initWithFrame:self.bounds];
        if ([self.mainView isKindOfClass:[ABUIListViewBaseItemView class]]) {
            [(ABUIListViewBaseItemView *)self.mainView setCell:self];
        }
        if ([self.mainView conformsToProtocol:@protocol(ABUIListItemViewProtocol)]) {
            [self addSubview:self.mainView];
            [(id<ABUIListItemViewProtocol>)self.mainView setupAdjustContents];
        }else{
            NSAssert(NO, @"itemview 必须准守协议ABUIListItemViewProtocol");
        }
    }
    
    if ([self.mainView respondsToSelector:@selector(reload:extra:indexPath:)]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:extra];
        dic[@"isFirst"] = @(self.indexPath.row == 0);
        dic[@"isEnd"] = @(self.indexPath.row == self.total-1);
        [(id<ABUIListItemViewProtocol>)self.mainView reload:item extra:dic indexPath:self.indexPath];
    }else{
        [(id<ABUIListItemViewProtocol>)self.mainView reload:item];
    }
    
    [(id<ABUIListItemViewProtocol>)self.mainView layoutAdjustContents];
    
    if (item[@"itemKey"] != nil) {
        self.itemKey = item[@"itemKey"];
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if ([self.mainView respondsToSelector:@selector(setHighlighted:)]) {
        [(id<ABUIListItemViewProtocol>)self.mainView setHighlighted:highlighted];
    }
}

- (void)refreshUserProvideData {
    if ([self.mainView respondsToSelector:@selector(userProvideData)]) {
        id data = [(id<ABUIListItemViewProtocol>)self.mainView userProvideData];
        [self.ppx.runData setValue:data forKey:self.itemKey];
    }
}

- (void)sendActionWithKey:(NSString *)actionKey actionData:(nullable id)actionData {
    if (self.ppx.delegate && [self.ppx.delegate respondsToSelector:@selector(listView:didActionItemAtIndexPath:item:itemKey:actionKey:actionData:)]) {
        [self.ppx.delegate listView:self.ppx didActionItemAtIndexPath:self.indexPath item:self.item itemKey:self.itemKey actionKey:actionKey actionData:actionData];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.mainView.frame = self.bounds;
    [(id<ABUIListItemViewProtocol>)self.mainView layoutAdjustContents];
}

- (nullable id)userProvideData {
    return self.ppx.runData[self.itemKey];
}

@end
