//
//  ABUIChatItemImageView.m
//  ABUIKit
//
//  Created by qp on 2020/11/2.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIChatItemImageView.h"
#import "SDWebImage.h"
@interface ABUIChatItemImageView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;
@end
@implementation ABUIChatItemImageView

+(void)load {
    [[ABUIListViewMapping shared] registerClassString:@"ABUIChatItemImageView" native_id:@"item_chat_image"];
}

- (void)setupAdjustContents {
    [super setupAdjustContents];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    self.imageView.backgroundColor = [UIColor redColor];
    self.imageView.layer.cornerRadius = 4;
    self.imageView.clipsToBounds = true;
    [self addSubview:self.imageView];
}

- (void)layoutAdjustContents {
    [super layoutAdjustContents];
    self.imageView.height = self.h;
    self.imageView.width = self.w;
}

- (void)reload:(NSDictionary *)item extra:(NSDictionary *)extra indexPath:(NSIndexPath *)indexPath {
    [super reload:item extra:extra indexPath:indexPath];
    self.imageView.height = self.height;
    __weak __typeof(self) weakSelf = self;
    [self.imageView sd_setImageWithURL:item[@"content"] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        dispatch_async(dispatch_get_main_queue(), ^{
            CGFloat p = image.size.width/image.size.height;
            CGFloat h = self.height;
            CGFloat w = h*p;
            
            weakSelf.imageView.width = w;
            weakSelf.imageView.height = h;
            weakSelf.w = w;
            weakSelf.h = h;
            
            if ([self isLeft]) {
                self.imageView.left = self.avatarImageView.right+10;
            }else{
                self.imageView.left = self.avatarImageView.left-self.imageView.width-10;
                
            }

        });

    }];

}

@end
