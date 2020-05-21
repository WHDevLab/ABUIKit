//
//  UIViewController+AB.m
//  Demo
//
//  Created by qp on 2020/5/6.
//  Copyright © 2020 ab. All rights reserved.
//

#import "UIViewController+AB.h"
#import <objc/runtime.h>
static char const * const isVisableNavigationBarKey = "isVisableNavigationBarKey";
@implementation UIViewController (AB)

- (BOOL)isVisableNavigationBar {
    NSNumber *number = objc_getAssociatedObject(self, isVisableNavigationBarKey);
    if (number == nil) {
        return true;
    }
    return [number boolValue];
}

- (void)setIsVisableNavigationBar:(BOOL)isVisableNavigationBar {
    objc_setAssociatedObject(self, isVisableNavigationBarKey, [NSNumber numberWithBool:isVisableNavigationBar], OBJC_ASSOCIATION_ASSIGN);
}

- (UIViewController *)parent {
    return objc_getAssociatedObject(self, @"parentKey");
}

- (void)setParent:(UIViewController *)parent {
    objc_setAssociatedObject(self, @"parentKey", parent, OBJC_ASSOCIATION_ASSIGN);
}

- (NSDictionary *)props {
    return objc_getAssociatedObject(self, @"propsKey");
}

- (void)setProps:(NSDictionary *)props {
    objc_setAssociatedObject(self, @"propsKey", props, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
