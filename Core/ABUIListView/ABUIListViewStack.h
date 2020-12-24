//
//  ABUIListViewStack.h
//  ABUIKit
//
//  Created by qp on 2020/10/21.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABUIListViewStack : NSObject
- (void)setData:(NSDictionary *)data;
- (void)set:(id)value key:(NSString *)key;
- (id)get:(NSString *)key;
- (NSDictionary *)all;
@end

NS_ASSUME_NONNULL_END
