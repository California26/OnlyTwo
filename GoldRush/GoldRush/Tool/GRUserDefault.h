//
//  GRUserDefault.h
//  GoldRush
//
//  Created by Jack on 2017/1/17.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRUserDefault : NSObject

+ (void)setKey:(NSString *)key Value:(id)value;

+ (NSString *)getValueForKey:(NSString *)key;

//获取用户手机号
+ (NSString *)getUserPhone;

//得到 cookie
+ (NSData *)getCookie;

//恒大登陆状态
+ (BOOL)getIsLoginHD;
//恒大是否注册
+ (BOOL)getIsRegistHD;
//吉交所登陆状态
+ (BOOL)getIsLoginJJ;
//吉交所是否注册
+ (BOOL)getIsRegistJJ;

//移除恒大/吉交所的登陆状态
+ (void)removeHDLogin;
+ (void)removeJJLogin;

//移除用户手机
+ (void)removeAllKey;

@end
