//
//  ABUISeatView.h
//  ABUIKit
//
//  Created by qp on 2020/11/27.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABUISeatViewConfig : NSObject
@property (nonatomic, assign) NSString *imageName;
@property (nonatomic, assign) NSString *title;
@property (nonatomic, assign) NSString *actionTitle;

+ (ABUISeatViewConfig *)title:(NSString *)title imageName:(NSString *)imageName;
@end

@interface ABUISeatView : UIView
@property (nonatomic, strong) ABUISeatViewConfig *config;
@property (nonatomic, assign) NSString *seatTitle;
@property (nonatomic, assign) NSString *actionTitle;
@property (nonatomic, assign) NSString *seatImageName;
@property (nonatomic, strong) UIButton *actionButton;
@end

NS_ASSUME_NONNULL_END
