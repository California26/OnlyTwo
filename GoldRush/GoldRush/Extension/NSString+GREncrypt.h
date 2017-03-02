//
//  NSString+GREncrypt.h
//  GoldRush
//
//  Created by Jack on 2017/1/12.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (GREncrypt)

+ (NSString *)hmacsha1:(NSString *)text key:(NSString *)secret;

@end
