//
//  ABUIChatConfirgure.h
//  ABUIKit
//
//  Created by qp on 2020/11/3.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface ABUIChatConfirgure : NSObject
+ (ABUIChatConfirgure *)shared;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) NSMutableArray *emojiSets;
@property (nonatomic, strong) NSMutableArray *emojiDataList;
@property (nonatomic, strong) NSMutableArray *mutiFuncDataList;
@property (nonatomic, assign) CGFloat safeHeight;
@end

NS_ASSUME_NONNULL_END
