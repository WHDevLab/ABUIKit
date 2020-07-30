//
//  ABUIListViewCell.m
//  Demo
//
//  Created by qp on 2020/5/8.
//  Copyright © 2020 ab. All rights reserved.
//

#import "ABUIListViewCell.h"
#import "ABUIListViewProtocols.h"
@interface ABUIListViewCell ()
@property (nonatomic, strong) UIView *mainView;
@end
@implementation ABUIListViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = true;
    }
    return self;
}

- (void)reload:(NSDictionary *)item extra:(nullable NSDictionary *)extra clsStr:(nonnull NSString *)clsStr{
    if (clsStr == nil) {
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
        self.mainView = [(UIView *)[NSClassFromString(clsStr) alloc] initWithFrame:self.bounds];
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
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if ([self.mainView respondsToSelector:@selector(setHighlighted:)]) {
        [(id<ABUIListItemViewProtocol>)self.mainView setHighlighted:highlighted];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.mainView.frame = self.bounds;
    [(id<ABUIListItemViewProtocol>)self.mainView layoutAdjustContents];
}
@end
