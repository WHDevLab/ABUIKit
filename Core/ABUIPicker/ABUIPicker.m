//
//  ABUIPicker.m
//  ABUIKit
//
//  Created by qp on 2021/3/11.
//  Copyright © 2021 abteam. All rights reserved.
//

#import "ABUIPicker.h"
#import "ABUIPickerView.h"
@interface ABUIPicker ()
@property (nonatomic, strong) ABUIPickerView *pickerView;
@end
@implementation ABUIPicker
+ (ABUIPicker *)shared {
    static ABUIPicker *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pickerView = [[ABUIPickerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    
    }
    return self;
}

- (void)showAddress {
    
}

@end
