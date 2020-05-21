//
//  ABUIListViewMapping.h
//  Demo
//
//  Created by qp on 2020/5/13.
//  Copyright © 2020 ab. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABUIListViewMapping : NSObject
@property (nonatomic, strong) NSDictionary *mapping;
+ (ABUIListViewMapping *)shared;
- (NSString *)classString:(NSString *)native_id;
@end

NS_ASSUME_NONNULL_END
