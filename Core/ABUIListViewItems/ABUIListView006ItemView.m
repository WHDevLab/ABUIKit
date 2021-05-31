//
//  ABUIListView006ItemView.m
//  ABUIKit
//
//  Created by qp on 2021/3/11.
//  Copyright © 2021 abteam. All rights reserved.
//

#import "ABUIListView006ItemView.h"
@implementation ABUIListView006ItemView
+ (void)load {
    [[ABUIListViewMapping shared] registerClassString:@"ABUIListView006ItemView" native_id:@"ablist_item_006"];
}
- (void)setupAdjustContents {
    self.actionButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 0, self.width-60, 50)];
    [self.actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.actionButton.backgroundColor = [UIColor hexColor:@"#FF2A40"];
    self.actionButton.titleLabel.font = [UIFont PingFangMedium:18];
    self.actionButton.layer.cornerRadius = 25;
    self.actionButton.clipsToBounds = true;
    [self.actionButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.actionButton];
}

- (void)layoutAdjustContents {
    self.actionButton.layer.cornerRadius = self.actionButton.height/2;
    self.actionButton.centerY = self.height/2;
}

- (void)reload:(NSDictionary *)item {
    [self.actionButton setTitle:item[@"data.title"] forState:UIControlStateNormal];
    if ([item[@"css.button.backgroundColor"] isKindOfClass:[UIColor class]]) {
        [self.actionButton setBackgroundColor:item[@"css.button.backgroundColor"]];
    }else{
        if (item[@"css.button.backgroundColor"] == nil) {
            [self.actionButton setBackgroundColor:[UIColor redColor]];
        }else{
            [self.actionButton setBackgroundColor:[UIColor hexColor:item[@"css.button.backgroundColor"]]];
        }

    }
    if (item[@"css.button.height"] != nil) {
        self.actionButton.height = [item[@"css.button.height"] floatValue];
    }

}

- (void)buttonAction {
    [self.cell sendActionWithKey:@"button" actionData:self.cell.item];
}
@end
