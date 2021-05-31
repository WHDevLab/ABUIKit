//
//  ABUIBankSelectionView.m
//  ABUIKit
//
//  Created by qp on 2021/5/31.
//  Copyright © 2021 abteam. All rights reserved.
//

#import "ABUIBankSelectionView.h"
#import "ABUIListViewItems.h"
#import "ABUIPopUp.h"
#import "UIColor+AB.h"
#import "UIView+AB.h"
@interface ABUIBankSelectionView()<ABUIListViewDelegate, ABUIListViewDataSource>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *okButton;
@property (nonatomic, assign) int index;
@end
@implementation ABUIBankSelectionView
+ (ABUIBankSelectionView *)shared {
    static ABUIBankSelectionView *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height*0.6)];
    });
    return instance;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.frame.size.width, 50)];
        self.titleLabel.text = @"选择银行卡";
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:self.titleLabel];
        [self.titleLabel addLineDirection:LineDirectionBottom color:[UIColor hexColor:@"dedede"] width:1];
        
        self.closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 44, 44)];
        [self.closeButton setImage:[UIImage imageNamed:[ABUIPopupConfiguration shared].closeImageName] forState:UIControlStateNormal];
        [self.closeButton addTarget:self action:@selector(onClose) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.closeButton];
        self.closeButton.centerY = self.titleLabel.centerY;
        
        self.mainListView = [[ABUIListView alloc] initWithFrame:CGRectMake(0, self.titleLabel.bottom, self.frame.size.width, self.frame.size.height-50)];
        self.mainListView.delegate = self;
        self.mainListView.dataSource = self;
        self.mainListView.separatorColor = [UIColor hexColor:@"f3f3f2"];
        [self addSubview:self.mainListView];
    }
    return self;
}


- (NSDictionary *)listView:(ABUIListView *)listView extraDataAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.index) {
        return @{@"isSelected":@(true)};
    }
    return @{@"isSelected":@(false)};
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    self.index = indexPath.row;
    [self.mainListView reloadData];
}

- (void)listView:(ABUIListView *)listView didActionItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item itemKey:(NSString *)itemKey actionKey:(NSString *)actionKey actionData:(id)actionData {
    [self onClose];
}

- (void)showTitles:(NSArray *)titles {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSString *title in titles) {
        [arr addObject:@{
            @"data.title":title,
            @"native_id":ABUILV_ITEM_TITLE_CHECK,
            @"css.separator.hidden":@(false)
        }];
    }
    [arr addObject:@{
        @"native_id":ABUILV_ITEM_BUTTON,
        @"data.title":@"完成",
        @"item.size.height":@(100)
    }];
    
    [self.mainListView setDataList:arr css:@{
        @"item.size.height":@(50),
        @"item.rowSpacing":@(1)
    }];
    
    [[ABUIPopUp shared] show:self from:ABPopUpDirectionBottom];
}

- (void)onClose {
    [[ABUIPopUp shared] remove];
}

@end
