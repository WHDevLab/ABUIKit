//
//  ABUIPickerView.m
//  ABUIKit
//
//  Created by qp on 2021/3/11.
//  Copyright © 2021 abteam. All rights reserved.
//

#import "ABUIPickerView.h"
#import "ABUIPickerViewToolBar.h"
#import "UIView+AB.h"
#import "UIColor+AB.h"
#import "ABUIPopUp.h"
@interface ABUIPickerView()<UIPickerViewDelegate, UIPickerViewDataSource, NSXMLParserDelegate>
@property (nonatomic, strong) ABUIPickerViewToolBar *pickerToolBar;
@property (nonatomic, strong) UIPickerView *pickerView; // 选择器视图
@property (nonatomic, strong) NSDictionary* selectItem;
@end
@implementation ABUIPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.pickerToolBar = [[ABUIPickerViewToolBar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
        [self addSubview:self.pickerToolBar];
        [self.pickerToolBar.okButton addTarget:self action:@selector(onOk) forControlEvents:UIControlEventTouchUpInside];
        [self.pickerToolBar addLineDirection:LineDirectionBottom color:[UIColor hexColor:@"999999"] width:1];
        
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.pickerToolBar.bottom+1, self.frame.size.width, self.frame.size.height-self.pickerToolBar.bottom)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        [self addSubview:self.pickerView];
        
    }
    return self;
}

- (void)setDataList:(NSArray *)dataList {
    _dataList = dataList;
    self.selectItem = self.dataList[0];
}

#pragma mark - UIPickerViewDataSource

// 返回需要展示的列（columns）的数目
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// 返回每一列的行（rows）数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataList.count;
}

#pragma mark - UIPickerViewDelegate

// 返回每一行的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataList[row][self.titleKey];
}

// 某一行被选择时调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectItem = self.dataList[row];
}

- (void)onOk {
    if (self.selectItem == nil) {
        return;
    }
    [self.delegate abUIPickerView:self didSelected:self.selectItem];
    [[ABUIPopUp shared] remove];
}

@end
