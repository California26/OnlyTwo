//
//  GRNetWorking.h
//  GoldRush
//
//  Created by Jack on 2016/12/18.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger,HttpRequestType) {
    /**
     *  get请求
     */
    HttpRequestTypeGet = 0,
    /**
     *  post请求
     */
    HttpRequestTypePost
};

@interface GRNetWorking : NSObject

/**
 *  发送get请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *
 */
+ (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 callBack:(void(^)(NSDictionary *dict))callBack
             ;

/**
 *  发送post请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 */
+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  callBack:(void(^)(NSDictionary *dict))callBack
                     ;

/**
 发送网络请求
 
 @param URLString 请求的网址字符串
 @param parameters 请求的参数
 @param type 请求的类型
 @param success 请求成功
 @param failure 请求失败
 */
+ (void)requestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                        type:(HttpRequestType)type
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure;

/**
 网络状态的检测

 @return -1 表示 `Unknown`，0 表示 `NotReachable，1 表示 `WWAN`，2 表示 `WiFi`
 */
+ (NSInteger)networkReachability;


/**
 取消网络请求
 */
+ (void)cancelRequestNetWork;

@end
