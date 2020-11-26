//
//  ABUIChatHelper.h
//  ABUIKit
//
//  Created by qp on 2020/11/3.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ABUIChatHelper : NSObject
+ (NSAttributedString *)formatMessageString:(NSString *)text withFont:(UIFont*)font;
@end

NS_ASSUME_NONNULL_END
