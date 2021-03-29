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
    return [self getStringSize:string font:font constrainedToSize:size lineSpacing:0 lineBreakMode:NSLineBreakByWordWrapping];
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
        NSStringDrawingOptions option = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
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

- (NSString *)trim {
    return [self trimmingNewLineAndWhiteSpace];
}

- (NSString *)decryptAES128WithKey:(NSString *)key iv:(NSString *)iv encryptStr:(NSString *)encryptStr {
    NSString *str = [encryptStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:0x0];
    
    
    char keyPtr[kCCKeySizeAES128 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr, kCCBlockSizeAES128,
                                          ivPtr,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *decryptData = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:decryptData options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@", dic);
        return [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding];
    }
    free(buffer);
    return @"";
}
////AES128加密
//- (NSData *)AES128ParmEncryptWithKey:(NSString *)key iv:(NSString *)iv
//{
//    char keyPtr[kCCKeySizeAES128+1];
//    bzero(keyPtr, sizeof(keyPtr));
//    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
//
//    char ivPtr[kCCBlockSizeAES128 + 1];
//    bzero(ivPtr, sizeof(ivPtr));
//    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
//
//
//    NSUInteger dataLength = [self length];
//    size_t bufferSize = dataLength + kCCBlockSizeAES128;
//    void *buffer = malloc(bufferSize);
//    size_t numBytesEncrypted = 0;
//    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
//                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
//                                          keyPtr, kCCBlockSizeAES128,
//                                          ivPtr,
//                                          [self bytes], dataLength,
//                                          buffer, bufferSize,
//                                          &numBytesEncrypted);
//    if (cryptStatus == kCCSuccess) {
//        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
//    }
//    free(buffer);
//    return nil;
//}
//
////解密
//- (NSData *)AES128ParmDecryptWithKey:(NSString *)key iv:(NSString *)iv
//{
//    char keyPtr[kCCKeySizeAES128 + 1];
//    bzero(keyPtr, sizeof(keyPtr));
//    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
//
//    char ivPtr[kCCBlockSizeAES128 + 1];
//    bzero(ivPtr, sizeof(ivPtr));
//    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
//
//    NSUInteger dataLength = [self length];
//    size_t bufferSize = dataLength + kCCBlockSizeAES128;
//    void *buffer = malloc(bufferSize);
//    size_t numBytesDecrypted = 0;
//    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
//                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
//                                          keyPtr, kCCBlockSizeAES128,
//                                          ivPtr,
//                                          [self bytes], dataLength,
//                                          buffer, bufferSize,
//                                          &numBytesDecrypted);
//    if (cryptStatus == kCCSuccess) {
//        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
//    }
//    free(buffer);
//    return nil;
//}
//


+ (NSString *)linkStrs:(NSString *)strs, ... {
    NSMutableString *str = [[NSMutableString alloc] init];
    if (strs) {
        // 定义一个指向个数可变的参数列表指针；
        [str appendString:strs];
        va_list args;
        // 用于存放取出的参数
        NSString *arg;
        // 初始化变量刚定义的va_list变量，这个宏的第二个参数是第一个可变参数的前一个参数，是一个固定的参数
        va_start(args, strs);
        // 遍历全部参数 va_arg返回可变的参数(a_arg的第二个参数是你要返回的参数的类型)
        while ((arg = va_arg(args, NSString *))) {
            [str appendString:arg];
        }
        // 清空参数列表，并置参数指针args无效
        va_end(args);
    }
    return str;
}

@end
