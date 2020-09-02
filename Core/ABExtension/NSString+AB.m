//
//  NSString+AB.m
//  ABExtension
//
//  Created by qp on 2020/5/5.
//  Copyright © 2020 ab. All rights reserved.
//

#import "NSString+AB.h"
#import <CommonCrypto/CommonCrypto.h>
@implementation NSString (AB)
- (NSString *)md5
{
    const char *data = [self UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];

    CC_MD5(data, (CC_LONG)strlen(data), result);
    NSMutableString *mString = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        //02:不足两位前面补0,   %02x:十六进制数
        [mString appendFormat:@"%02x",result[i]];
    }
    
    return mString;
}
-(CGFloat)heightWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    return [self sizeWithFont:font constrainedToSize:size].height;
}

- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    return [NSString getStringSize:self font:font constrainedToSize:size];
}

-(CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineSpacing:(CGFloat)linespace lineBreakMode:(NSLineBreakMode)lineBreakMode{
    return [NSString getStringSize:self font:font constrainedToSize:size lineSpacing:linespace lineBreakMode:lineBreakMode];
}

+ (CGSize)getStringSize:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)size{
    return [self getStringSize:string font:font constrainedToSize:size lineSpacing:0 lineBreakMode:NSLineBreakByCharWrapping];
}

+ (CGSize)getStringSize:(NSString*)string font:(UIFont*)font constrainedToSize:(CGSize)size lineSpacing:(CGFloat)linespace lineBreakMode:(NSLineBreakMode)lineBreakMode{
    CGSize textSize;
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:linespace];
    paragraphStyle.lineBreakMode = lineBreakMode;
    NSDictionary *attributes = @{NSFontAttributeName:font,
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    if (CGSizeEqualToSize(size, CGSizeZero))
    {
        textSize = [string sizeWithAttributes:attributes];
    }
    else
    {
        //NSStringDrawingTruncatesLastVisibleLine如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。 如果指定了NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略 NSStringDrawingUsesFontLeading计算行高时使用行间距。（注：字体大小+行间距=行高）
        NSStringDrawingOptions option = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading ;
        CGRect rect = [string boundingRectWithSize:size
                                           options:option
                                        attributes:attributes
                                           context:nil];
        //经测试，向上取整可以减少误差
        textSize.height = ceilf(rect.size.height);
        textSize.width = ceilf(rect.size.width);
    }
    return textSize;
}

- (NSDictionary *)toDictionary {
    if (self == nil)
    {
        return nil;
    }
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding]; NSError *err; NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

- (NSString *)trimmingNewLineAndWhiteSpace {
    NSString *content = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    content = [content stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    return content;
}

@end
