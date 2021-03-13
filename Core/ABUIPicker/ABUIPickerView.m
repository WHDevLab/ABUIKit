//
//  ABUIPickerView.m
//  ABUIKit
//
//  Created by qp on 2021/3/11.
//  Copyright © 2021 abteam. All rights reserved.
//

#import "ABUIPickerView.h"
#import "ABUIPickerViewToolBar.h"
@interface ABUIPickerView()<UIPickerViewDelegate, UIPickerViewDataSource, NSXMLParserDelegate>
@property (nonatomic, strong) ABUIPickerViewToolBar *pickerToolBar;
@end
@implementation ABUIPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.pickerToolBar = [[ABUIPickerViewToolBar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
        [self addSubview:self.pickerToolBar];
    }
    return self;
}

@end
