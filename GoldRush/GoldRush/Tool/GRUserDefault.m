//
//  GRUserDefault.m
//  GoldRush
//
//  Created by Jack on 2017/1/17.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRUserDefault.h"

@implementation GRUserDefault

+ (void)setKey:(NSString *)key Value:(id)value{
    NSUserDefaults *defaultData = [NSUserDefaults standardUserDefaults];
    [defaultData setObject:value forKey:key];
    [defaultData synchronize];
}

+ (instancetype)getValueForKey:(NSString *)key{
    NSUserDefaults *defaultData = [NSUserDefaults standardUserDefaults];
    return [defaultData objectForKey:key];
}

+ (NSString *)getUserPhone{
    return (NSString *)[self getValueForKey:@"UserPhone"];
}

+ (NSData *)getCookie{
    return (NSData *)[self getValueForKey:@"NSHTTPCookie"];
}

/** 
    恒大是否登陆和注册
 */
+ (BOOL)getIsLoginHD{
    return [[self getValueForKey:@"isLoginHD"] boolValue];
}

+ (BOOL)getIsRegistHD{
    return [[self getValueForKey:@"isRegistHD"] boolValue];
}

/**
    吉交所是否登陆和注册
 */
+ (BOOL)getIsLoginJJ{
    return [[self getValueForKey:@"isLoginJJ"] boolValue];
}

+ (BOOL)getIsRegistJJ{
    return [[self getValueForKey:@"isRegistJJ"] boolValue];
}

//移除恒大/吉交所的登陆状态
+ (void)removeHDLogin{
    NSUserDefaults *defaultData = [NSUserDefaults standardUserDefaults];
    [defaultData setObject:@(NO) forKey:@"isLoginHD"];
}

+ (void)removeJJLogin{
    NSUserDefaults *defaultData = [NSUserDefaults standardUserDefaults];
    [defaultData setObject:@(NO) forKey:@"isLoginJJ"];
}


+ (void)removeAllKey{
    NSUserDefaults *defaultData = [NSUserDefaults standardUserDefaults];
    [defaultData removeObjectForKey:@"UserPhone"];
    [defaultData setObject:@(NO) forKey:@"isLoginHD"];
    [defaultData setObject:@(NO) forKey:@"isRegistHD"];
    
    [defaultData setObject:@(NO) forKey:@"isLoginJJ"];
    [defaultData setObject:@(NO) forKey:@"isRegistJJ"];
    
    [defaultData removeObjectForKey:@"NSHTTPCookie"];
    [defaultData synchronize];
}



@end
