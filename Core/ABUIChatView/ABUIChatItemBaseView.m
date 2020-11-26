//
//  ABUIChatItemBaseView.m
//  ABUIKit
//
//  Created by qp on 2020/11/2.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIChatItemBaseView.h"
#import <SDWebImage/SDWebImage.h>
#import "UIView+AB.h"
@implementation ABUIChatItemBaseView

- (void)setupAdjustContents {
    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self addSubview:self.avatarImageView];
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarImageView.clipsToBounds = true;
    self.avatarImageView.layer.cornerRadius = 4;
    self.clipsToBounds = true;
}

- (void)layoutAdjustContents {

}


- (BOOL)isLeft {
    NSString *p = _item[@"p"];
    return [p isEqualToString:@"l"];
}

- (void)reload:(NSDictionary *)item extra:(NSDictionary *)extra indexPath:(NSIndexPath *)indexPath {
    self.item = item;
    if ([self isLeft]) {
        self.avatarImageView.left = 15;
    }else{
        self.avatarImageView.left = self.width-15-self.avatarImageView.width;
    }
    [self.avatarImageView sd_setImageWithURL:item[@"avatar"]];
}

@end
