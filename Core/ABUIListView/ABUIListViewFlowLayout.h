//
//  ABUIListViewFlowLayout.h
//  ABUIKit
//
//  Created by qp on 2020/9/26.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABUIListViewConfigure.h"
NS_ASSUME_NONNULL_BEGIN


@interface ABUICollectionViewLayoutAttributes : UICollectionViewLayoutAttributes
@property (nonatomic, strong) UIColor *color;
@end

@interface ABUIListViewDecorationView : UICollectionReusableView
@end

@interface ABUIListViewFlowLayout : UICollectionViewFlowLayout
- (instancetype)initWithType:(ABUIListViewLayoutType)type;
@property (nonatomic, assign) ABUIListViewLayoutType layoutType;
@end

NS_ASSUME_NONNULL_END
