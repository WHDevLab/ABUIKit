//
//  ABUIChatConfirgure.m
//  ABUIKit
//
//  Created by qp on 2020/11/3.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIChatConfirgure.h"
@implementation ABUIChatConfirgure
+ (ABUIChatConfirgure *)shared {
    static ABUIChatConfirgure *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textFont = [UIFont systemFontOfSize:17];
        NSString *kWXFaces = @"微笑, 撇嘴, 色, 发呆, 得意, 流泪, 害羞, 闭嘴, 睡, 大哭, 尴尬, 发怒, 调皮, 呲牙,惊讶, 难过, 冷汗, 抓狂, 吐, 偷笑, 愉快, 白眼, 饥饿, 困, 惊恐, 流汗, 憨笑, 悠闲,奋斗, 咒骂, 疑问, 嘘, 晕, 衰, 骷髅, 敲打, 再见, 擦汗, 抠鼻, 鼓掌, 坏笑, 左哼哼,右哼哼, 哈欠, 鄙视, 委屈, 快哭了, 阴险, 亲亲, 可怜, 菜刀, 西瓜, 啤酒, 咖啡, 猪头, 玫瑰, 凋谢, 嘴唇, 爱心, 心碎, 蛋糕, 炸弹, 便便, 月亮, 太阳,拥抱, 强, 弱, 握手, 胜利, 抱拳, 勾引, 拳头, OK, 跳跳,发抖, 怄火, 转圈, 嘿哈, 捂脸, 奸笑, 机智, 皱眉,  耶, 红包, 發, 福";

        self.emojiSets = [[NSMutableArray alloc] init];
        self.emojiDataList = [[NSMutableArray alloc] init];
        NSArray *wxFaces = [kWXFaces componentsSeparatedByString:@","];
        CGFloat w = floor([UIScreen mainScreen].bounds.size.width/8);
        for (NSString *item in wxFaces) {
            NSString *name = [item stringByReplacingOccurrencesOfString:@" " withString:@""];
            name = [NSString stringWithFormat:@"[%@]", name];
            [self.emojiDataList addObject:@{
                @"native_id":@"faceitem",
                @"item.size.width":@(w),
                @"item.size.height":@(w),
                @"name":name
            }];
            
            [self.emojiSets addObject:name];
        }
        
        self.mutiFuncDataList = [[NSMutableArray alloc] init];
        self.mutiFuncDataList = @[
            @{
                @"native_id":@"mutifuncitem",
                @"title":@"照片"
            },
            @{
                @"native_id":@"mutifuncitem",
                @"title":@"拍摄",
            },
            @{
                @"native_id":@"mutifuncitem",
                @"title":@"视频通话",
            },
            @{
                @"native_id":@"mutifuncitem",
                @"title":@"位置",
            },
            @{
                @"native_id":@"mutifuncitem",
                @"title":@"红包",
            },
            @{
                @"native_id":@"mutifuncitem",
                @"title":@"转账",
            },
            @{
                @"native_id":@"mutifuncitem",
                @"title":@"语言输入",
            },
            @{
                @"native_id":@"mutifuncitem",
                @"title":@"收藏",
            },
            @{
                @"native_id":@"mutifuncitem",
                @"title":@"个人名片",
            },
            @{
                @"native_id":@"mutifuncitem",
                @"title":@"文件",
            },
            @{
                @"native_id":@"mutifuncitem",
                @"title":@"卡券",
            },
        ];
    }
    return self;
}
@end
