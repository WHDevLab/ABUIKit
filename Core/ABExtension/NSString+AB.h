//
//  NSString+AB.h
//  ABExtension
//
//  Created by qp on 2020/5/5.
//  Copyright © 2020 ab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonCrypto.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString (AB)
-(NSString *)md5;
- (CGFloat)heightWithFont:(UIFont *)font
        constrainedToSize:(CGSize)size;

- (CGSize)sizeWithFont:(UIFont *)font
     constrainedToSize:(CGSize)size;

- (CGSize)sizeWithFont:(UIFont *)font
     constrainedToSize:(CGSize)size
           lineSpacing:(CGFloat)linespace
         lineBreakMode:(NSLineBreakMode)lineBreakMode;

+ (CGSize)getStringSize:(NSString*)string
                   font:(UIFont*)font
      constrainedToSize:(CGSize)size;

/**
 这里计算的只是文本的高度，如果在textview等控件中，默认左右都有5的padding，上下都有7的padding，需要自行加上
 或者用以下代码去除padding
 textView.textContainer.lineFragmentPadding = 0;
 textView.textContainerInset = UIEdgeInsetsZero;
 **/
+ (CGSize)getStringSize:(NSString*)string
                   font:(UIFont*)font
      constrainedToSize:(CGSize)size
            lineSpacing:(CGFloat)linespace
          lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (NSDictionary *)toDictionary;

- (NSString *)trimmingNewLineAndWhiteSpace;
- (NSString *)trim;
- (NSString *)decryptAES128WithKey:(NSString *)key iv:(NSString *)iv encryptStr:(NSString *)encryptStr;
@end

NS_ASSUME_NONNULL_END
