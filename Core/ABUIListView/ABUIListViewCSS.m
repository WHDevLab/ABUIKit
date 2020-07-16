//
//  ABUIListViewCSS.m
//  ABUIKit
//
//  Created by qp on 2020/6/18.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIListViewCSS.h"

@implementation ABUIListViewCSS
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.item_rowSpacing = @"0";
        self.item_columnSpacing = @"0";
        self.item_size_width = @"100%";
        self.item_size_height = @"44";
        
        self.footer_size_height = @"0";
        self.footer_size_width = @"0";
        
        self.header_size_height = @"0";
        self.header_size_width = @"0";
        
        self.section_insert_left = @"0";
        self.section_insert_right = @"0";
        self.section_insert_bottom = @"0";
        self.section_insert_top = @"0";
    }
    return self;
}
@end
