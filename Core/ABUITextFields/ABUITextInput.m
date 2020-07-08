//
//  ABUITexttInput.m
//  ABUIKit
//
//  Created by qp on 2020/7/2.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUITextInput.h"
#import "UIView+AB.h"
@implementation ABUITextInput

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:self.titleLabel];
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.iconImageView];
        
        self.textField = [[ABUITextField alloc] initWithFrame:CGRectZero];
        [self addSubview:self.textField];
        
        self.titleLabel.frame = CGRectMake(0, 0, 68, 44);
        self.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        self.titleLabel.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
        
        self.textField.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
}

- (void)setIconImageName:(NSString *)iconImageName {
    self.iconImageView.image = [UIImage imageNamed:iconImageName];
}

- (NSString *)text {
    return self.textField.text;
}

- (void)setText:(NSString *)text {
    self.textField.text = text;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconImageView.left = self.width-self.iconImageView.width;
    self.iconImageView.centerY = self.height/2;
    
    self.titleLabel.left = 0;
    self.titleLabel.centerY = self.height/2;
    
    self.textField.frame = CGRectMake(self.titleLabel.right, 0, self.width-self.titleLabel.width-self.iconImageView.width, self.height);
}

@end
