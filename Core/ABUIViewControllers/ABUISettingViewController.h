//
//  ABUISettingViewController.h
//  ABUIKit
//
//  Created by qp on 2021/3/11.
//  Copyright © 2021 abteam. All rights reserved.
// {"title":"设置", "sections":[{"css":{}, "items":[]}]}

#import "ABUIViewController.h"
#import "ABUIListView.h"
NS_ASSUME_NONNULL_BEGIN

@interface ABUISettingViewController : ABUIViewController<ABUIListViewDelegate>
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) ABUIListView *mainListView;
@end

NS_ASSUME_NONNULL_END
