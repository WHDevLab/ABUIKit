//
//  ABUIAnimateBannerRawProtocol.h
//  ABUIKit
//
//  Created by qp on 2020/7/17.
//  Copyright © 2020 abteam. All rights reserved.
//

#ifndef ABUIAnimateBannerRawProtocol_h
#define ABUIAnimateBannerRawProtocol_h

@protocol ABUIAnimateBannerRawProtocol
@optional
//创建内容
- (void)setupAdjustContents;
//布局内容
- (void)layoutAdjustContents;
//设置数据
- (void)reload:(NSDictionary *)item;
@end

#endif /* ABUIAnimateBannerRawProtocol_h */
