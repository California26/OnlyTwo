//
//  NSString+GRMD5.m
//  GoldRush
//
//  Created by Jack on 2016/12/20.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "NSString+GRMD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (GRMD5)

- (NSString *)MD5EncodedString
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [[NSString stringWithFormat:
             @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

- (NSString *)URLEncodingUTF8String
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                 (CFStringRef)self,
                                                                                 NULL,
                                                                                 CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                 kCFStringEncodingUTF8));
}


/**
 返回某两个字符之间的文字的 range

 @param str1  字符1
 @param str2 字符2
 @return 字符1和字符2之间的字符 range
 */
- (NSRange)stringSubWithString:(NSString *)str1 andString:(NSString *)str2{
    NSRange startRange = [self rangeOfString:str1];
    NSRange endRange = [self rangeOfString:str2];
    return NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.length - startRange.location);
}


/**
 计算文字的 size

 @param width 显示文字区域的宽度
 @param font 字体的大小
 @return 返回文字的 size
 */
- (CGRect)sizeWithLabelWidth:(CGFloat)width font:(UIFont *)font{
    NSDictionary *dict = @{NSFontAttributeName : font};
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width,MAXFLOAT)options:(NSStringDrawingUsesLineFragmentOrigin)attributes:dict context:nil];
    return rect;
}

@end
