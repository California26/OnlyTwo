//
//  GRNetWorking.m
//  GoldRush
//
//  Created by Jack on 2016/12/18.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRNetWorking.h"
#import "GRUtils.h"
#import "GRAFNSessionManager.h"

@interface GRNetWorking ()


@end

@implementation GRNetWorking


#pragma mark -- GET请求 --
+ (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                callBack:(void(^)(NSDictionary *dict))callBack {
    
    GRAFNSessionManager *manager = [GRAFNSessionManager sharedInstance];
    
    //可以接受的类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //请求队列的最大并发数
    manager.operationQueue.maxConcurrentOperationCount = 5;
    //请求超时的时间
    manager.requestSerializer.timeoutInterval = 5;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/x-javascript",@"text/html",@"application/json",nil];
    //开启 SSL Pinning 功能，并把你们服务器对应的 .cer 证书或者公钥放到你的工程
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];

    
    [manager GET:DomainName parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callBack(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
        if (response.statusCode == 500) {
            NSDictionary *dict = @{@"code":@(HttpError),
                                   @"description":@"服务器内部错误"};
            callBack(dict);
        }else{
            NSDictionary *dict = @{@"code":@(HttpError),@"description":@"无法连接到服务器"};
            callBack(dict);
        }
    }];
}

#pragma mark -- POST请求 --
+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                 callBack:(void(^)(NSDictionary *dict))callBack{
//    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"api.taojin.6789.net" ofType:@"cer"];
//    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"api-test.taojin.6789.net" ofType:@"cer"];
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"api-dev.taojin.6789.net" ofType:@"cer"];

    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    NSSet *certSet = [[NSSet alloc] initWithObjects:certData, nil];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    [securityPolicy setAllowInvalidCertificates:YES];
    [securityPolicy setPinnedCertificates:certSet];
    
    GRAFNSessionManager *manager = [GRAFNSessionManager sharedInstance];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/x-javascript",@"text/html",@"application/json",@"image/jpeg",@"text/javascript",@"text/json",nil];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager setSecurityPolicy:securityPolicy];
    
    NSString *url;
    if (URLString.length == 0) {
        url = DomainName;
    }else{
        url = [NSString stringWithFormat:@"%@%@",DomainName,URLString];
    }
    
    NSDictionary *paraDict = (NSDictionary *)parameters;
    GRUtils *util = [[GRUtils alloc] init];
    NSDictionary *tempDict = [util signJoining:paraDict];
    
    //设置 cookie
    if ([GRUserDefault getCookie]) {
        NSData *cookiesdata = [GRUserDefault getCookie];
        if([cookiesdata length]) {
            NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
            NSHTTPCookie *cookie;
            for (cookie in cookies) {
                [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
            }  
        }
    }
    
    [manager POST:url parameters:tempDict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        callBack(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
        if (response.statusCode == 500) {
            NSDictionary *dict = @{@"code":@(HttpError),
                                   @"description":@"服务器内部错误"};
            callBack(dict);
        }else{
            NSDictionary *dict = @{@"code":@(HttpError),@"description":@"无法连接到服务器"};
            callBack(dict);
        }
    }];
}

#pragma mark - 取消网络请求
+ (void)cancelRequestNetWork{
    GRAFNSessionManager *manager = [GRAFNSessionManager sharedInstance];
    [manager.operationQueue cancelAllOperations];
}

#pragma mark -- POST/GET网络请求 --
+ (void)requestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                        type:(HttpRequestType)type
                     success:(void (^)(id))success
                     failure:(void (^)(NSError *))failure {
    
    GRAFNSessionManager *manager = [GRAFNSessionManager sharedInstance];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    switch (type) {
        case HttpRequestTypeGet:
        {
            [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        case HttpRequestTypePost:
        {
            [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
    }
}

#pragma mark - 检测网路状态
+ (NSInteger)networkReachability {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //开始监听
    [manager startMonitoring];
    //设置监听
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                GRLog(@"未识别的网络 %ld",AFNetworkReachabilityStatusUnknown);
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                GRLog(@"不可达的网络(未连接) %ld",AFNetworkReachabilityStatusNotReachable);
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                GRLog(@"2G,3G,4G...的网络 %ld",AFNetworkReachabilityStatusReachableViaWWAN);
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                GRLog(@"wifi的网络 %ld",AFNetworkReachabilityStatusReachableViaWiFi);
                break;
            default:
                break;
        }
    }];
    return manager.networkReachabilityStatus;
}

#pragma mark - getter and setter


@end
