//
//  ABUIListViewController.m
//  Demo
//
//  Created by qp on 2020/5/14.
//  Copyright © 2020 ab. All rights reserved.
//

#import "ABUIListViewController.h"
#import "ABUIListView.h"
@interface ABUIListViewController ()
@end

@implementation ABUIListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.listView = [[ABUIListView alloc] initWithFrame:self.view.bounds];
    self.listView.delegate = self;
    [self.view addSubview:self.listView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.listView.frame = self.view.bounds;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
