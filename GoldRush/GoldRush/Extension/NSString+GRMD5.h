//
//  NSString+GRMD5.h
//  GoldRush
//
//  Created by Jack on 2016/12/20.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (GRMD5)

// ***********  MD5 Encoding ********************
- (NSString *)MD5EncodedString;
- (NSString *)URLEncodingUTF8String;


- (NSRange)stringSubWithString:(NSString *)str1 andString:(NSString *)str2;

/**
 计算文字的 size
 
 @param width 显示文字区域的宽度
 @param font 字体的大小
 @return 返回文字的 size
 */
- (CGRect)sizeWithLabelWidth:(CGFloat)width font:(UIFont *)font;

@end
