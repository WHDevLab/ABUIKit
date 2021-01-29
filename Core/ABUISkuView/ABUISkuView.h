//
//  ABUISkuView.h
//  ABUIKit
//
//  Created by qp on 2021/1/22.
//  Copyright © 2021 abteam. All rights reserved.
//  每个分类具有独立的id,通过组合获得skuid，通过skuid查询价格等信息

#import <UIKit/UIKit.h>
#import "ABUIListView.h"
NS_ASSUME_NONNULL_BEGIN
@protocol ABUISkuViewDelegate <NSObject>

- (void)abUISkuViewDidConfirm:(NSString *)text;

@end
@interface ABUISkuView : UIView
@property (nonatomic, strong) ABUIListView *mainListView;
//{
//    "skuinfo":{"4516640581581":{"price":"1099", "quantity":"1"}}
//    "skus":[{"skuId":"4516640581581", "propPath":"20549:44901;1627207:7486129328"}],
//    "props":[{"pid":"20549","name":"鞋码", "values":[{"vid":"44901", "name":"44.5"}]}]
//}
@property (nonatomic, weak) id<ABUISkuViewDelegate> delegate;
- (void)setData:(NSDictionary *)data;
- (NSString *)getSelectResult;
@end

NS_ASSUME_NONNULL_END
