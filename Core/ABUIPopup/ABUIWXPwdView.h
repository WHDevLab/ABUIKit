//
//  ABUIWXPwdView.h
//  ABUIKit
//
//  Created by qp on 2021/5/31.
//  Copyright © 2021 abteam. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "ABUIListView.h"
#import "ABUIListViewBaseItemView.h"
@protocol ABWXPwdPopupDelegate <NSObject>
- (void)abwxpwdpopupFinished:(NSString *)pwd;
@end


@interface ABWXPwdRawItem : ABUIListViewBaseItemView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) NSArray *infos;
@end

@interface ABWXPwdConfig : NSObject
@property (nonatomic, assign) NSInteger pwdCount;// 密码位数
@property (nonatomic, strong) UIColor *borderColor;// 密码位数
@property (nonatomic, assign) CGSize dotSize;// 黑点大小
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) CGFloat money;
@property (nonatomic, strong) NSString *moneyStr;
@property (nonatomic, strong) NSArray *supplys;
+ (ABWXPwdConfig *)defaultConfig;
@end

@interface ABUIWXPwdView : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) UIView *inputTextFieldWrapper;
@property (nonatomic, strong) NSMutableArray *dotArray; //用于存放黑色的点点
@property (nonatomic, strong) ABWXPwdConfig *config;
@property (nonatomic, weak) id<ABWXPwdPopupDelegate> delegate;
@property (nonatomic, strong) ABUIListView *infoListView;
@end


@interface ABWXPwdPopup : NSObject
@property (nonatomic, weak) id<ABWXPwdPopupDelegate> delegate;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) ABUIWXPwdView *contentView;
@property (nonatomic, strong) ABWXPwdConfig *config;

- (instancetype)initWithConfig:(ABWXPwdConfig *)config;
+ (instancetype)shared;
- (void)show;
@end

