//
//  ABUIListViewCell.h
//  Demo
//
//  Created by qp on 2020/5/8.
//  Copyright © 2020 ab. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABUIListViewCell : UICollectionViewCell
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) NSInteger total;
- (void)reload:(NSDictionary *)item extra:(nullable NSDictionary *)extra clsStr:(NSString *)clsStr;
@end

NS_ASSUME_NONNULL_END
