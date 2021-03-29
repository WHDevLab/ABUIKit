//
//  ABUIPickerView.h
//  ABUIKit
//
//  Created by qp on 2021/3/11.
//  Copyright © 2021 abteam. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ABUIPickerView;
NS_ASSUME_NONNULL_BEGIN
@protocol ABUIPickerViewDelegate <NSObject>

- (void)abUIPickerView:(ABUIPickerView *)pickerView didSelected:(NSDictionary *)item;

@end
@interface ABUIPickerView : UIView
@property (nonatomic, weak) id<ABUIPickerViewDelegate> delegate;
@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) NSString *titleKey;
@end

NS_ASSUME_NONNULL_END
