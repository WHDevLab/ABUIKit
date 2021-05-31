//
//  ABUIBankSelectionView.h
//  ABUIKit
//
//  Created by qp on 2021/5/31.
//  Copyright © 2021 abteam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABUIListView.h"
NS_ASSUME_NONNULL_BEGIN

@interface ABUIBankSelectionView : UIView
@property (nonatomic, strong) ABUIListView *mainListView;
+ (ABUIBankSelectionView *)shared;

- (void)showTitles:(NSArray *)titles;
@end

NS_ASSUME_NONNULL_END
