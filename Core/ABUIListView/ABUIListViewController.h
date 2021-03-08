//
//  ABUIListViewController.h
//  Demo
//
//  Created by qp on 2020/5/14.
//  Copyright © 2020 ab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABUIListView.h"
#import "ABUIViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface ABUIListViewController : ABUIViewController<ABUIListViewDelegate>
@property (nonatomic, strong) ABUIListView *mainListView;
@end

NS_ASSUME_NONNULL_END
