//
//  ABUINavigationConfig.h
//  ABUIKit
//
//  Created by qp on 2020/9/26.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABUINavigationConfig : NSObject
+ (ABUINavigationConfig *)shared;
@property (nonatomic, strong) UIImage *backImage;
@property (nonatomic, strong) UIImage *whiteBackImage;
@end

NS_ASSUME_NONNULL_END
