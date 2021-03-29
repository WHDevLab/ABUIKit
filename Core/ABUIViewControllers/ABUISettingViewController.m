//
//  ABUISettingViewController.m
//  ABUIKit
//
//  Created by qp on 2021/3/11.
//  Copyright © 2021 abteam. All rights reserved.
//

#import "ABUISettingViewController.h"
#import "UIViewController+AB.h"
#import "UIView+AB.h"
#import "ABUIViewCreator.h"
#import "UIFont+AB.h"
@interface ABUISettingViewController ()

@end

@implementation ABUISettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mainListView = [[ABUIListView alloc] initWithFrame:self.view.bounds];
    self.mainListView.delegate = self;
    [self.view addSubview:self.mainListView];
    
    NSDictionary *data = self.props;
    self.title = data[@"title"];
    self.key = data[@"key"];
    [self.mainListView setTempleteDataList:data[@"sections"]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.mainListView.frame = self.view.bounds;
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    if (item[@"action.jump"] != nil) {
        UIViewController *vc = [[NSClassFromString(item[@"action.jump"]) alloc] init];
        vc.title = item[@"data.title"];
        vc.props = item[@"action.data"];
        [self.navigationController pushViewController:vc animated:true];
    }
}


@end
