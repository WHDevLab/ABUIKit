//
//  ABUISearchBar.m
//  ABUIKit
//
//  Created by qp on 2020/11/26.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUISearchBar.h"
#import "UIView+AB.h"
#import "UIColor+AB.h"
@interface ABUISearchBar ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UITextField *inputTextField;
@end
@implementation ABUISearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 20, 20)];
        self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.iconImageView];
        
        self.inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.iconImageView.right+5, 0, self.width-self.iconImageView.right-20, self.height)];
        self.inputTextField.textColor = [UIColor hexColor:@"999999"];
        self.inputTextField.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.inputTextField];
    }
    return self;
}

- (void)setIconImage:(UIImage *)iconImage {
    _iconImage = iconImage;
    self.iconImageView.image = iconImage;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.inputTextField.placeholder = placeholder;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconImageView.centerY = self.height/2;
}

@end
