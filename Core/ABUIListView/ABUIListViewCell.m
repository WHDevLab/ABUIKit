//
//  ABUIListViewCell.m
//  Demo
//
//  Created by qp on 2020/5/8.
//  Copyright © 2020 ab. All rights reserved.
//

#import "ABUIListViewCell.h"
#import "ABUIListViewBaseItemView.h"
@interface ABUIListViewCell ()
@property (nonatomic, strong) NSString *itemKey;
@end
@implementation ABUIListViewCell

- (void)reload:(NSDictionary *)item extra:(nullable NSDictionary *)extra clsStr:(nonnull NSString *)clsStr{
    self.item = item;
    self.itemKey = item[@"itemKey"];
    if (self.itemKey == nil) {
        self.itemKey = clsStr;
    }
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
        if ([self.ppx.runData isKindOfClass:[NSMutableDictionary class]]) {
            [self.ppx.runData setValue:data forKey:self.itemKey];
        }
        [self.ppx.stack set:data key:self.itemKey];
    }
}

- (void)setUserProvideData:(id)data {
    [self.ppx.stack set:data key:self.itemKey];
}

- (void)sendActionWithKey:(NSString *)actionKey actionData:(nullable id)actionData {
    if (self.ppx.delegate && [self.ppx.delegate respondsToSelector:@selector(listView:didActionItemAtIndexPath:item:itemKey:actionKey:actionData:)]) {
        [self.ppx.delegate listView:self.ppx didActionItemAtIndexPath:self.indexPath item:self.item itemKey:self.itemKey actionKey:actionKey actionData:actionData];
    }
}

- (void)sendActionWithData:(id)actionData forKey:(NSString *)actionKey {
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
    id v = [self.ppx.stack get:self.itemKey];
    if (self.item[@"show"] != nil) {
        NSDictionary *show = self.item[@"show"];
        if (show.count > 0) {
            return show[v];
        }
    }
    return v;
    return self.ppx.runData[self.itemKey];
}

- (void)save:(id)value forKey:(NSString *)key {
    NSString *_identifier = self.item[@"_identifier"];
    if (_identifier == nil) {
        return;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:[self.innerStack get:_identifier]];
    dic[key] = value;
    [self.innerStack set:dic key:_identifier];
}

- (id)get:(NSString *)key {
    NSString *_identifier = self.item[@"_identifier"];
    if (_identifier == nil) {
        return nil;
    }
    
    return [self.innerStack get:_identifier][key];
}

- (void)changeHeightIfNeed:(CGFloat)height {
    NSString *_identifier = self.item[@"_identifier"];
    if (_identifier == nil) {
        return;
    }
    if ([self.innerStack get:_identifier] == nil) {
        [self changeHeight:ceil(height)];
    }
}

- (void)changeHeight:(CGFloat)height {
    NSString *_identifier = self.item[@"_identifier"];
    if (_identifier == nil) {
        return;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:[self.innerStack get:_identifier]];
    if ([dic[@"height"] floatValue] == ceil(height)) {
        return;
    }
    dic[@"height"] = @(ceil(height));
    [self.innerStack set:dic key:_identifier];
    [self sendActionWithData:nil forKey:@"im"];
}

@end
