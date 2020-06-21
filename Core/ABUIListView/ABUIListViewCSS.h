//
//  ABUIListViewCSS.h
//  ABUIKit
//
//  Created by qp on 2020/6/18.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABUIListViewCSS : NSObject
@property (nonatomic, strong) NSString *item_rowSpacing;
@property (nonatomic, strong) NSString *item_columnSpacing;
@property (nonatomic, strong) NSString *item_size_width;
@property (nonatomic, strong) NSString *item_size_height;

@property (nonatomic, strong) NSString *header_size_width;
@property (nonatomic, strong) NSString *header_size_height;

@property (nonatomic, strong) NSString *footer_size_width;
@property (nonatomic, strong) NSString *footer_size_height;

@property (nonatomic, strong) NSString *section_insert_top;
@property (nonatomic, strong) NSString *section_insert_left;
@property (nonatomic, strong) NSString *section_insert_right;
@property (nonatomic, strong) NSString *section_insert_bottom;

@end

NS_ASSUME_NONNULL_END
