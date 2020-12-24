//
//  NSArray+AB.h
//  ABUIKit
//
//  Created by qp on 2020/7/2.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (AB)
- (void)iterationInBlock:(void (^)(NSMutableDictionary *dic))block;
- (NSString *)toJSONString;
@end

NS_ASSUME_NONNULL_END
