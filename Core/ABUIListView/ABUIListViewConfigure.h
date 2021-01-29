//
//  ABUIListViewConfigure.h
//  ABUIKit
//
//  Created by qp on 2020/11/11.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ABUIListViewLayoutTypeDefault,
    ABUIListViewLayoutTypeSectionColor,
    ABUIListViewLayoutTypeHor,
} ABUIListViewLayoutType;

@interface ABUIListViewConfigure : NSObject
@property (nonatomic, assign) ABUIListViewLayoutType layoutType;
@property (nonatomic, strong) UICollectionViewLayout *layout;
@property (nonatomic, assign) BOOL enableMove;
@property (nonatomic, strong) UIColor *sectionColor;

+ (ABUIListViewConfigure *)defaultSectionColor;
+ (ABUIListViewConfigure *)hor;
@end

NS_ASSUME_NONNULL_END
