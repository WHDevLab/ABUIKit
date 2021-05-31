//
//  ABUIListViewConfigure.m
//  ABUIKit
//
//  Created by qp on 2020/11/11.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIListViewConfigure.h"

@implementation ABUIListViewItemConfigure

@end
@implementation ABUIListViewConfigure

+ (ABUIListViewConfigure *)shared {
    static ABUIListViewConfigure *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


+ (ABUIListViewConfigure *)defaultSectionColor {
    ABUIListViewConfigure *config = [[ABUIListViewConfigure alloc] init];
    config.layoutType = ABUIListViewLayoutTypeSectionColor;
    config.sectionColor = [UIColor whiteColor];
    return config;
}

+ (ABUIListViewConfigure *)hor {
    ABUIListViewConfigure *config = [[ABUIListViewConfigure alloc] init];
    config.layoutType = ABUIListViewLayoutTypeHor;
    return config;
}
@end
