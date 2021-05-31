//
//  ABUIPopupConfiguration.h
//  ABUIKit
//
//  Created by qp on 2021/5/31.
//  Copyright © 2021 abteam. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABUIPopupConfiguration : NSObject
+ (instancetype)shared;
@property (nonatomic, strong) NSString *closeImageName;
@end

NS_ASSUME_NONNULL_END
