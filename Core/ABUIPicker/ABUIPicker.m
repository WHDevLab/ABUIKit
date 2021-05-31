//
//  ABUIPicker.m
//  ABUIKit
//
//  Created by qp on 2021/3/11.
//  Copyright © 2021 abteam. All rights reserved.
//

#import "ABUIPicker.h"
#import "ABUIPickerView.h"
#import "ABUIPopUp.h"
@interface ABUIPicker ()<ABUIPickerViewDelegate>
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
//        self.pickerView = [[ABUIPickerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300)];
//        self.pickerView.delegate = self;
    }
    return self;
}

+ (void)showAddress {
    
}

- (void)showItems:(NSArray<NSDictionary *> *)items result:(ABUIPickerResultBlock)result {
    [self showItems:items titleKey:@"title" result:result];
}

- (void)showItems:(NSArray<NSDictionary *> *)items titleKey:(NSString *)titleKey result:(ABUIPickerResultBlock)result {
    self.pickerView = [[ABUIPickerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300)];
    self.pickerView.delegate = self;
    self.rBlock = result;
    self.pickerView.titleKey = titleKey;
    [self.pickerView setDataList:items];
    [[ABUIPopUp shared] show:self.pickerView from:ABPopUpDirectionBottom];
}

- (void)abUIPickerView:(ABUIPickerView *)pickerView didSelected:(nonnull NSDictionary *)item{
    self.rBlock(item);
}

- (void)showDatePicker {
    
}
@end
