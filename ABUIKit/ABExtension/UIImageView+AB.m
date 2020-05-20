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
//        [self sd_setImageWithURL:[NSURL URLWithString:str]];
    }
    else{
        self.image = [UIImage imageNamed:str];
    }
}
@end
