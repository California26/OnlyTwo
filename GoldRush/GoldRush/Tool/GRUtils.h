//
//  GRUtils.h
//  GoldRush
//
//  Created by Jack on 2016/12/21.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRUtils : NSObject

/**
    验证手机号是否可用
 */
+ (BOOL)validateMobilePhone:(NSString *)mobile;



/**
 签名加密
 */
- (NSDictionary *)signJoining:(NSDictionary *)array;

+ (NSString *)getCurrentDate;
+ (NSString *)getYesterdayDate;
+ (NSTimeInterval)getCurrentTimeInterval;

+ (NSDate *)getTimeIntervalWithString:(NSString *)stringDate;



@end
