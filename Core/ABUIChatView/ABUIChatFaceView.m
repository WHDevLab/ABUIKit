//
//  ABUIChatFaceView.m
//  ABUIKit
//
//  Created by qp on 2020/11/7.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIChatFaceView.h"
#import "ABUIListView.h"
#import "UIView+AB.h"
#import "UIColor+AB.h"
#import "ABUIChatConfirgure.h"
@interface ABUIChatFaceItemView()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ABUIChatFaceItemView
+ (void)load {
    [[ABUIListViewMapping shared] registerClassString:@"ABUIChatFaceItemView" native_id:@"faceitem"];
}
- (void)layoutAdjustContents {
    
}
- (void)setupAdjustContents {
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, 10, 10)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.imageView];
}

- (void)reload:(NSDictionary *)item {
    [self.imageView setImage:[UIImage imageNamed:item[@"name"]]];
}

@end


@interface ABUIChatFaceView ()<ABUIListViewDelegate>
@property (nonatomic, strong) ABUIListView *mainListView;
@property (nonatomic, strong) UIView *buttonView;
@property (nonatomic, strong) UIButton *delButton;
@property (nonatomic, strong) UIButton *sendButton;
@end
@implementation ABUIChatFaceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor hexColor:@"ededed"];
        
        self.mainListView = [[ABUIListView alloc] initWithFrame:self.bounds];
        [self addSubview:self.mainListView];
        self.mainListView.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 70, 0);
        
        NSMutableArray *emojiList = [ABUIChatConfirgure shared].emojiDataList;
        [self.mainListView setDataList:emojiList css:nil];
        self.mainListView.delegate = self;
        
        self.buttonView = [[UIView alloc] initWithFrame:CGRectMake(self.width-150-15, self.height-80, 100, 80)];
        self.buttonView.backgroundColor = [UIColor hexColor:@"ededed"];
        [self addSubview:self.buttonView];
        
        self.delButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, 60, 40)];
        [self.delButton addTarget:self action:@selector(onDelButton) forControlEvents:UIControlEventTouchUpInside];
        [self.delButton setImage:[UIImage imageNamed:@"DeleteEmoticonBtn"] forState:UIControlStateNormal];
        self.delButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.delButton setTitleColor:[UIColor hexColor:@"333333"] forState:UIControlStateNormal];
        [self.delButton setBackgroundColor:[UIColor whiteColor]];
        self.delButton.layer.cornerRadius = 5;
        [self.buttonView addSubview:self.delButton];
        
        self.sendButton = [[UIButton alloc] initWithFrame:CGRectMake(self.delButton.right+10, 0, 60, 40)];
        [self.sendButton addTarget:self action:@selector(onSendButton) forControlEvents:UIControlEventTouchUpInside];
        [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
        self.sendButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.sendButton setTitleColor:[UIColor hexColor:@"333333"] forState:UIControlStateNormal];
        [self.sendButton setBackgroundColor:[UIColor whiteColor]];
        self.sendButton.layer.cornerRadius = 5;
        [self.buttonView addSubview:self.sendButton];
        self.delButton.centerY = self.buttonView.height/2;
        self.sendButton.centerY = self.buttonView.height/2;
        self.buttonView.width = self.sendButton.right+10;
        self.buttonView.left = self.width-self.buttonView.width-6;
        
        
    }
    return self;
}

- (void)onSendButton {
    [self.delegate faceViewDidClickSend];
}

- (void)onDelButton {
    [self.delegate faceViewDidClickDelete];
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item itemKey:(NSString *)itemKey {
    NSLog(@"%@", item[@"name"]);
    [self.delegate faceViewDidSelect:item];
}

- (BOOL)isEmojiString:(NSString *)str {
    return [[ABUIChatConfirgure shared].emojiSets containsObject:str];
}

- (void)setZero:(BOOL)zero {
    [self.delButton setUserInteractionEnabled:!zero];
    [self.sendButton setUserInteractionEnabled:!zero];
    if (zero) {
        self.delButton.alpha = 0.5;
        self.sendButton.alpha = 0.5;
        self.sendButton.backgroundColor = [UIColor whiteColor];
        [self.sendButton setTitleColor:[UIColor hexColor:@"333333"] forState:UIControlStateNormal];

    }else{
        self.delButton.alpha = 1;
        self.sendButton.alpha = 1;
        self.sendButton.backgroundColor = [UIColor hexColor:@"#04BE02"];
        [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}
@end
