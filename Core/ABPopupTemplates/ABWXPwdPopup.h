//
//  ABWXPwdPopup.h
//  ABUIKit
//
//  Created by qp on 2021/3/8.
//  Copyright © 2021 abteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABUIListView.h"
#import "ABUIListViewBaseItemView.h"
@protocol ABWXPwdPopupDelegate <NSObject>
- (void)abwxpwdpopupFinished:(NSString *)pwd;
@end
NS_ASSUME_NONNULL_BEGIN


@interface ABWXPwdRawItem : ABUIListViewBaseItemView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) NSArray *infos;
@end

@interface ABWXPwdPopupConfig : NSObject
@property (nonatomic, assign) NSInteger pwdCount;// 密码位数
@property (nonatomic, strong) UIColor *borderColor;// 密码位数
@property (nonatomic, assign) CGSize dotSize;// 黑点大小
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) CGFloat money;
@property (nonatomic, strong) NSString *moneyStr;
@property (nonatomic, strong) NSArray *supplys;
+ (ABWXPwdPopupConfig *)defaultConfig;
@end

@interface ABWXPwdView : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) UIView *inputTextFieldWrapper;
@property (nonatomic, strong) NSMutableArray *dotArray; //用于存放黑色的点点
@property (nonatomic, strong) ABWXPwdPopupConfig *config;
@property (nonatomic, weak) id<ABWXPwdPopupDelegate> delegate;
@property (nonatomic, strong) ABUIListView *infoListView;
@end


@interface ABWXPwdPopup : NSObject
@property (nonatomic, weak) id<ABWXPwdPopupDelegate> delegate;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) ABWXPwdView *contentView;
@property (nonatomic, strong) ABWXPwdPopupConfig *config;

- (instancetype)initWithConfig:(ABWXPwdPopupConfig *)config;
+ (instancetype)shared;
- (void)show;
@end

NS_ASSUME_NONNULL_END
