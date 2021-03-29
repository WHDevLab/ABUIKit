//
//  ABUIPicker.h
//  ABUIKit
//
//  Created by qp on 2021/3/11.
//  Copyright © 2021 abteam. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^ABUIPickerResultBlock)(NSDictionary *item);
NS_ASSUME_NONNULL_BEGIN

@interface ABUIPicker : NSObject
+ (ABUIPicker *)shared;
@property (nonatomic, strong) ABUIPickerResultBlock rBlock;
+ (void)showAddress;

// must contain title key
// items:[{"title":"a"}, {"title":"n"}]
- (void)showItems:(NSArray<NSDictionary *> *)items result:(ABUIPickerResultBlock)result;
- (void)showItems:(NSArray<NSDictionary *> *)items titleKey:(NSString *)titleKey result:(ABUIPickerResultBlock)result;

- (void)showDatePicker;
@end

NS_ASSUME_NONNULL_END
