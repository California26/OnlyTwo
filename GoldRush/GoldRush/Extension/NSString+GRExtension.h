//
//  NSString+GRExtension.h
//  GoldRush
//
//  Created by Jack on 2017/1/12.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (GRExtension)

- (NSRange)stringSubWithString:(NSString *)str1 andString:(NSString *)str2;

/**
 计算文字的 size
 
 @param width 显示文字区域的宽度
 @param font 字体的大小
 @return 返回文字的 size
 */
- (CGRect)sizeWithLabelWidth:(CGFloat)width font:(UIFont *)font;

- (NSString *)MD5EncodedString;

@end
