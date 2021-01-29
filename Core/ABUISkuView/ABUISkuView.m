//
//  ABUISkuView.m
//  ABUIKit
//
//  Created by qp on 2021/1/22.
//  Copyright © 2021 abteam. All rights reserved.
//

#import "ABUISkuView.h"
#import "ABUISkuItemView.h"
#import "ABUITips.h"
#import "ABUISkuTopView.h"
#import <SDWebImage/SDWebImage.h>
@interface ABUISkuView ()<ABUIListViewDelegate, ABUIListViewDataSource>
@property (nonatomic, strong) ABUISkuTopView *topView;
@property (nonatomic, strong) NSMutableDictionary *selectMap;
@property (nonatomic, strong) NSDictionary *skus;
@property (nonatomic, strong) NSArray *props;
@property (nonatomic, strong) NSMutableArray *sectionKeys;
@property (nonatomic, strong) UIButton *confirmButton;
@end
@implementation ABUISkuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectMap = [[NSMutableDictionary alloc] init];
        
        self.topView = [[ABUISkuTopView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 120)];
        self.topView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.topView];
        
        self.mainListView = [[ABUIListView alloc] initWithFrame:CGRectMake(10, 100, self.frame.size.width-20, self.frame.size.height-100)];
        self.mainListView.delegate = self;
        self.mainListView.dataSource = self;
        [self addSubview:self.mainListView];
        
        self.confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
        [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        self.confirmButton.backgroundColor = [UIColor redColor];
        [self.confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.confirmButton addTarget:self action:@selector(onConfirm) forControlEvents:UIControlEventTouchUpInside];
//        self.mainListView.footerView = self.confirmButton;
    }
    return self;
}

- (void)setData:(NSDictionary *)data {
    self.skus = data[@"skus"];
    self.props = data[@"props"];
    self.sectionKeys = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in self.props) {
        [self.sectionKeys addObject:dic[@"pid"]];
    }
    [self.mainListView setTempleteDataList:self.props];
}

- (CGSize)listView:(ABUIListView *)listView sizeForItemAtIndexPath:(NSIndexPath *)indexPath item:(nonnull NSDictionary *)item {
    NSString *vv = item[@"title"];
    CGSize s = [vv sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    CGFloat w = ceil(s.width+20);
    CGFloat h = ceil(s.height+10);
    return CGSizeMake(w, h);
}

- (NSDictionary *)listView:(ABUIListView *)listView extraDataAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    NSArray *sectionKeys = @[@"0", @"1", @"2", @"3"];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSString *kk in sectionKeys) {
        if (indexPath.section == [kk intValue]) {
            [arr addObject:item[@"vid"]];
        }else{
            if (self.selectMap[kk] != nil) {
                [arr addObject:self.selectMap[kk]];
            }
        }
    }
    
    NSString *str = [arr componentsJoinedByString:@";"];
    if (self.skus[str] != nil) {
        int count = [self.skus[str][@"count"] intValue];
        if (count == 0) {
            return @{@"status":@(0)};
        }
    }
    NSString *keystr = [NSString stringWithFormat:@"%li", (long)indexPath.section];
    NSString *vid = self.selectMap[keystr];
    int status = 1;
    if ([vid isEqualToString:item[@"vid"]]) {
        status = 2;
    }
    return @{@"status":@(status)};
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item extra:(nonnull NSDictionary *)extra {
    if ([extra[@"status"] intValue] == 0) {
        return;
    }
    [self.topView.imageView sd_setImageWithURL:item[@"image"]];
    NSString *keystr = [NSString stringWithFormat:@"%li", (long)indexPath.section];
    if ([self.selectMap[keystr] isEqualToString:item[@"vid"]]) {
        [self.selectMap removeObjectForKey:keystr];
    }else{
        self.selectMap[keystr] = item[@"vid"];
    }
    [self.mainListView reloadData];
}


- (NSString *)getSelectResult {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i=0; i<self.props.count; i++) {
        NSString *key = [NSString stringWithFormat:@"%i", i];
        if (self.selectMap[key] == nil) {
            [ABUITips showError:[NSString stringWithFormat:@"请选择%@", self.props[i][@"name"]]];
            return nil;
        }
        
        [arr addObject:self.selectMap[key]];
    }
    
    NSString *str = [arr componentsJoinedByString:@";"];
    return str;
}

- (void)onConfirm {
    NSString *text = [self getSelectResult];
    if (text == nil) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(abUISkuViewDidConfirm:)]) {
        [self.delegate abUISkuViewDidConfirm:text];
    }
}

@end
