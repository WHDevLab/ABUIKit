//
//  ABUIListReusableView.m
//  Demo
//
//  Created by qp on 2020/5/9.
//  Copyright © 2020 ab. All rights reserved.
//

#import "ABUIListReusableView.h"
#import "ABUIListViewProtocols.h"
@interface ABUIListReusableView ()
@property (nonatomic, strong) UIView *mainView;
@end
@implementation ABUIListReusableView
- (void)reload:(NSDictionary *)item clsStr:(NSString *)clsStr {
    if (clsStr == nil) {
        NSLog(@"classString is empty");
        return;
    }
    if (self.mainView == nil) {
        self.mainView = [(UIView *)[NSClassFromString(clsStr) alloc] initWithFrame:self.bounds];
        if ([self.mainView conformsToProtocol:@protocol(ABUIListItemViewProtocol)]) {
            [self addSubview:self.mainView];
            [(id<ABUIListItemViewProtocol>)self.mainView setupAdjustContents];
        }else{
            NSAssert(NO, @"itemview 必须准守协议ListItemViewProtocol");
        }
    }
    
    [(id<ABUIListItemViewProtocol>)self.mainView reload:item];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.mainView.frame = self.bounds;
    [(id<ABUIListItemViewProtocol>)self.mainView layoutAdjustContents];
}
@end
