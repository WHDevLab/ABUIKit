//
//  ABUIListView007ItemView.m
//  ABUIKit
//
//  Created by qp on 2021/3/11.
//  Copyright © 2021 abteam. All rights reserved.
//

#import "ABUIListView007ItemView.h"

@interface ABUIListView007ItemView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *phLabel;//placeholder
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@end
@implementation ABUIListView007ItemView

+(void)load {
    [[ABUIListViewMapping shared] registerClassString:@"ABUIListView007ItemView" native_id:@"ablist_item_007"];
}

- (void)setupAdjustContents {
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.textColor = [UIColor hexColor:@"#292B32"];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.titleLabel];
    
    self.phLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.right+10, 0, self.width-10-self.titleLabel.right-15, self.frame.size.height)];
    self.phLabel.font = [UIFont PingFangSC:16];
    self.phLabel.textColor = [UIColor hexColor:@"666666"];
    [self addSubview:self.phLabel];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.right+10, 0, self.width-10-self.titleLabel.right-15, self.frame.size.height)];
    self.contentLabel.font = [UIFont PingFangSC:16];
    self.contentLabel.textColor = [UIColor hexColor:@"222222"];
    [self.contentLabel setUserInteractionEnabled:true];
    [self addSubview:self.contentLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onAction)];
    [self.contentLabel addGestureRecognizer:tap];
    
    self.arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8, 12)];
    self.arrowImageView.image = [UIImage imageNamed:[ABUIListViewConfigure shared].cellArrowImageName];
    self.arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.arrowImageView];
}

- (void)layoutAdjustContents {
    if (self.titleLabel.text.length > 0) {
        self.titleLabel.left = 15;
        self.contentLabel.left = self.titleLabel.right+10;
        self.contentLabel.width = self.width-self.titleLabel.right-15;
        self.titleLabel.centerY = self.height/2;
    }else{
        self.contentLabel.left = 15;
        self.contentLabel.width = self.width-30;
    }
    
    self.phLabel.left = self.contentLabel.left;
    
    self.arrowImageView.left = self.width-15-self.arrowImageView.width;
    self.arrowImageView.centerY = self.height/2;
}

- (void)reload:(NSDictionary *)item {
    if (item[@"css.title.font"]) {
        self.titleLabel.font = item[@"css.title.font"];
    }else{
        self.titleLabel.font = [UIFont PingFangSC:16];
    }
    [self.titleLabel setHidden:item[@"data.title"] == nil];
    self.titleLabel.text = item[@"data.title"];
    [self.titleLabel sizeToFit];
    self.contentLabel.textColor = [UIColor hexColor:@"222222"];
    
    self.phLabel.text = item[@"data.placeholder"];
    
    id rData = [self.cell userProvideData];
    if (rData != nil && [rData isKindOfClass:[NSString class]]) {
        self.contentLabel.text = (NSString *)rData;
    }
    
    if (self.contentLabel.text.length == 0) {
        [self.phLabel setHidden:false];
    }else{
        [self.phLabel setHidden:true];
    }
    

}

- (void)onAction {
    [[UIApplication sharedApplication].keyWindow endEditing:true];
    [self.cell sendActionWithKey:@"select" actionData:@""];
}

@end
