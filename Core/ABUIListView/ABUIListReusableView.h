//
//  ABUIListReusableView.h
//  Demo
//
//  Created by qp on 2020/5/9.
//  Copyright © 2020 ab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABUIListView.h"
NS_ASSUME_NONNULL_BEGIN

@interface ABUIListReusableView : UICollectionReusableView
@property (nonatomic, weak) ABUIListView *ppx;
@property (nonatomic, assign) NSInteger section;
- (void)reload:(NSDictionary *)item clsStr:(NSString *)clsStr;
@end

NS_ASSUME_NONNULL_END
