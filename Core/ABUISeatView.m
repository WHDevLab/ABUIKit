//
//  ABUISeatView.m
//  ABUIKit
//
//  Created by qp on 2020/11/27.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUISeatView.h"
#import "UIColor+AB.h"
#import "UIView+AB.h"
#import "UIFont+AB.h"

@implementation ABUISeatViewConfig

+ (ABUISeatViewConfig *)title:(NSString *)title imageName:(NSString *)imageName {
    ABUISeatViewConfig *cc = [[ABUISeatViewConfig alloc] init];
    cc.title = title;
    cc.imageName = imageName;
    cc.actionTitle = @"点击刷新";
    return cc;
}

@end

@interface ABUISeatView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;
@end
@implementation ABUISeatView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:self.imageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.textColor = [UIColor hexColor:@"#B9B9C8"];
        self.titleLabel.font = [UIFont PingFangSC:15];
        [self addSubview:self.titleLabel];
        
        self.actionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        [self.actionButton setTitleColor:[UIColor hexColor:@"#2488FC"] forState:UIControlStateNormal];
        [self.actionButton setTitleColor:[[UIColor hexColor:@"#2488FC"] colorWithAlphaComponent:0.6] forState:UIControlStateHighlighted];
        self.actionButton.titleLabel.font = [UIFont PingFangSC:15];
        [self addSubview:self.actionButton];
        [self.actionButton addTarget:self action:@selector(onActionDown) forControlEvents:UIControlEventTouchDown];
        self.actionButton.layer.borderColor = [[UIColor hexColor:@"#2488FC"] colorWithAlphaComponent:0.8].CGColor;
        self.actionButton.layer.borderWidth = 1;
        self.actionButton.layer.cornerRadius = 15;
        
        [self setActionTitle:@"点击刷新"];
    }
    return self;
}

- (void)onActionDown {
    
}

- (void)setConfig:(ABUISeatViewConfig *)config {
    _config = config;
    [self setSeatImageName:config.imageName];
    [self setSeatTitle:config.title];
    [self setActionTitle:config.actionTitle];
}


- (void)setSeatTitle:(NSString *)seatTitle {
    _seatTitle = seatTitle;
    self.titleLabel.text = seatTitle;
    [self.titleLabel sizeToFit];
    self.titleLabel.centerX = self.width/2;
    self.titleLabel.top = self.height/2;
}

- (void)setSeatImageName:(NSString *)seatImageName {
    _seatImageName = seatImageName;
    
    UIImage *im = [UIImage imageNamed:seatImageName];
    [self.imageView setImage:[UIImage imageNamed:seatImageName]];
    self.imageView.width = im.size.width;
    self.imageView.height = im.size.height;
    self.imageView.centerX = self.width/2;
}

- (void)setActionTitle:(NSString *)actionTitle {
    _actionTitle = actionTitle;
    if (actionTitle == nil) {
        [self.actionButton setHidden:true];
    }else{
        [self.actionButton setHidden:false];
        [self.actionButton setTitle:actionTitle forState:UIControlStateNormal];
        self.actionButton.width = self.actionButton.width+30;
    }
   
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.top = self.height/2-self.imageView.height-40;
    self.titleLabel.top = self.imageView.bottom+10;
    
    self.actionButton.centerX = self.width/2;
    self.actionButton.top = self.titleLabel.bottom+30;
}

@end
