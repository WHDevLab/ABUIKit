//
//  UIImageView+AB.m
//  Demo
//
//  Created by qp on 2020/5/6.
//  Copyright © 2020 ab. All rights reserved.
//

#import "UIImageView+AB.h"
@implementation UIImageView (AB)
- (void)loadImage:(NSString *)str {
    if ([str hasPrefix:@"http"]) {
        [self sd_setImageWithURL:[NSURL URLWithString:str]];
    }
    else{
        self.image = [UIImage imageNamed:str];
    }
}

- (void)loadAni:(NSArray *)names {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSString *str in names) {
        [arr addObject:[UIImage imageNamed:str]];
    }
    self.animationImages = arr;
}

- (void)addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    [self setUserInteractionEnabled:true];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
}

@end
