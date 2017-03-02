//
//  GRUtils.m
//  GoldRush
//
//  Created by Jack on 2016/12/21.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRUtils.h"
#import "NSString+GREncrypt.h"
#import "GRBase64.h"

@implementation GRUtils
/**
 验证手机号是否可用
 */
+ (BOOL)validateMobilePhone:(NSString *)mobile{
    //手机号以13， 15，18,17开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

- (NSString *)createRandString{
    char data[32];
    for (int x = 0;x < 32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
}

- (NSDictionary *)signJoining:(NSDictionary *)dict {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval second = [date timeIntervalSince1970];
    
    NSString *timestamp = [NSString stringWithFormat:@"%.0f", second];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *string = [NSString stringWithFormat:@"%@=%@",[key URLEncodingUTF8String],[obj URLEncodingUTF8String]];
        [tempArray addObject:string];
    }];
    NSString *stringRand = [self createRandString];
    //随机字符串
    [tempArray addObject:[NSString stringWithFormat:@"%@=%@",[@"signatureNonce" URLEncodingUTF8String],[stringRand URLEncodingUTF8String]]];
    //时间戳
    [tempArray addObject:[NSString stringWithFormat:@"%@=%@",[@"timestamp" URLEncodingUTF8String],[timestamp URLEncodingUTF8String]]];
    //访问 ID
    [tempArray addObject:[NSString stringWithFormat:@"%@=%@",[@"accessId" URLEncodingUTF8String],[@"test_id" URLEncodingUTF8String]]];
    
    NSArray *myary = [tempArray sortedArrayUsingComparator:^(NSString * obj1, NSString * obj2){
        return (NSComparisonResult)[obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    NSString *lastStr = [myary componentsJoinedByString:@"&"];
    
    NSString *sortString = [lastStr URLEncodingUTF8String];
    
    NSString *sha1String = [NSString hmacsha1:sortString key:@"dcb975b7dccdc3d7f66e4c107dbfac8b"];
    
    NSMutableDictionary *tempDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    [tempDict setValue:stringRand forKey:@"signatureNonce"];
    [tempDict setValue:timestamp  forKey:@"timestamp"];
    [tempDict setValue:@"test_id" forKey:@"accessId"];
    [tempDict setValue:sha1String forKey:@"signature"];
    return tempDict;
}


+ (NSString *)getCurrentDate
{
//    NSDate *oldDate = [NSDate date];//获取时间对象
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];//获取系统的时区
//    NSTimeInterval time = [zone secondsFromGMTForDate:oldDate];//以秒为单位返回当前时间与系统格林尼治时间的差
//    NSDate *dateNow = [oldDate dateByAddingTimeInterval:time];//然后把差的时间加上。就是当前系统准确的时间
//    NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
//    [forMatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [forMatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [forMatter stringFromDate:date];
    return dateStr;
}


+ (NSString *)getYesterdayDate
{
    NSTimeInterval secondsPerDay = 24*60*60;
    NSDate *today = [NSDate date];
    NSDate *yesterday = [today dateByAddingTimeInterval:-secondsPerDay];
    NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
    [forMatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [forMatter stringFromDate:yesterday];
    return dateStr;
}

+ (NSTimeInterval )getCurrentTimeInterval
{
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval second = [date timeIntervalSince1970];
    return second;
}

+ (NSDate *)getTimeIntervalWithString:(NSString *)stringDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *date = [formatter dateFromString:stringDate];
    return date;
}
@end
