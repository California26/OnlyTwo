//
//  GRDefine.h
//  GoldRush
//
//  Created by Jack on 2017/1/18.
//  Copyright © 2017年 Jack. All rights reserved.
//

#ifndef GRDefine_h
#define GRDefine_h

#ifdef DEBUG
#define GRLog(...) NSLog(__VA_ARGS__)
#else
#define GRLog(...)
#endif

///屏幕
#define K_Screen_Height [UIScreen mainScreen].bounds.size.height
#define K_Screen_Width [UIScreen mainScreen].bounds.size.width

#define iPhone6P (K_Screen_Height == 736)
#define iPhone6 (K_Screen_Height == 667)
#define iPhone5 (K_Screen_Height == 568)
#define iPhone4 (K_Screen_Height == 480)

#define GRColor(r, g, b) \
[UIColor colorWithRed:(r) / 255.0f \
green:(g) / 255.0f \
blue:(b) / 255.0f \
alpha:1]

#define RandColor GRColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

//单例
#define SingletonH + (instancetype)sharedInstance;

#define SingletonM \
static id _instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
    return _instance; \
} \
+ (instancetype)sharedInstance \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [[self alloc] init]; \
    }); \
    return _instance; \
} \
- (id)copyWithZone:(NSZone *)zone \
{ \
    return _instance; \
}

//网络请求  100 成功  403 失败
typedef NS_OPTIONS(NSUInteger, HttpCode) {
    HttpNoLogin = 403,            //表示当前操作需要登录但未登录(或登录失效)
    HttpSuccess = 200,           //成功
    HttpUnauthenticated = 401,   //表示请求接口签名验证未通过
    HttpPhoneExist = 300 ,       //手机号已经存在
    HttpError = 500               //服务器错误
};

//分时 15分 60分 日线
typedef NS_OPTIONS(NSUInteger, TimeQuantum) {
    TimeM = 60,
    Time15 = 61,
    Time60 = 62,
    TimeDay = 63,
};

typedef NS_ENUM(NSUInteger, ProductType) {
    ProductXAG = 101,
    ProductJWYin = 102,
    ProductJWT = 103,
    ProductJWYou = 104
};

#endif /* GRDefine_h */
