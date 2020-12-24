//
//  ABUISearchBar.h
//  ABUIKit
//
//  Created by qp on 2020/11/26.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ABUISearchBarDelegate <NSObject>
- (void)searchBarOnSearch:(NSString *)text;
@end
@interface ABUISearchBar : UIView
@property (nonatomic, weak) id<ABUISearchBarDelegate> delegate;
@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) NSString *text;
@end

NS_ASSUME_NONNULL_END
