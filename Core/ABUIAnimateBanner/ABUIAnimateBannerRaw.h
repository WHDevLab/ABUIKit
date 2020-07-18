//
//  ABUIAnimateBannerRaw.h
//  ABUIKit
//
//  Created by qp on 2020/7/16.
//  Copyright © 2020 abteam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABUIAnimateBannerRaw : UIView
@property (nonatomic, strong) NSDictionary *data;
- (void)reload:(NSDictionary *)item clsStr:(nonnull NSString *)clsStr;
@end

NS_ASSUME_NONNULL_END
