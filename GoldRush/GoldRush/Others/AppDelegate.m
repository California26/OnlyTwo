//
//  AppDelegate.m
//  GoldRush
//
//  Created by Jack on 2016/12/15.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "AppDelegate.h"

#import "GRTabBarController.h"
#import "GRNoNetWorkViewController.h"
#import <IQKeyboardManager.h>
#import "GRGuideViewController.h"

/** shareSDK */
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信
#import "WXApi.h"

#import <AFNetworking.h>

@interface AppDelegate ()<GRNoNetWorkViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //全局设置
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    // APNs注册，获取deviceToken并上报
    [self registerAPNS:application];
    // 初始化SDK
    [self initCloudPush];
    // 监听推送通道打开动作
    [self listenerOnChannelOpened];
    // 监听推送消息到达
    [self registerMessageReceive];
    // 点击通知将App从关闭状态启动时，将通知打开回执上报
    // [CloudPushSDK handleLaunching:launchOptions];(Deprecated from v1.8.1)
    [CloudPushSDK sendNotificationAck:launchOptions];
    
    ///初始化 shareSDK
    [self initShareSDK];
    
    ///设置键盘
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    NSString *isFirst = [GRUserDefault getValueForKey:@"isFirst"];
    if (isFirst.boolValue) {
        self.window.rootViewController = [[GRTabBarController alloc] init];
        //检测网路状态
//        [self performSelector:@selector(detectionNetWork:) withObject:nil afterDelay:0.35f];
    }else{
        self.window.rootViewController = [[GRGuideViewController alloc] init];
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)detectionNetWork:(NSNotification *)notification{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                GRLog(@"未识别的网络 %ld",AFNetworkReachabilityStatusUnknown);
                self.window.rootViewController = [[GRTabBarController alloc] init];
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {   GRLog(@"不可达的网络(未连接) %ld",AFNetworkReachabilityStatusNotReachable);
                [SVProgressHUD showInfoWithStatus:@"当前网络不可用"];
                GRNoNetWorkViewController *noVC = [[GRNoNetWorkViewController alloc] init];
                noVC.delegate = self;
                self.window.rootViewController = noVC;
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                GRLog(@"2G,3G,4G...的网络 %ld",AFNetworkReachabilityStatusReachableViaWWAN);
                self.window.rootViewController = [[GRTabBarController alloc] init];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                GRLog(@"wifi的网络 %ld",AFNetworkReachabilityStatusReachableViaWiFi);
                self.window.rootViewController = [[GRTabBarController alloc] init];
                break;
            default:
                break;
        }
    }];
}

///分享 SDK
- (void)initShareSDK{
    //1b463e43b939c
    [ShareSDK registerApp:@"1b463e43b939c" activePlatforms:@[@(SSDKPlatformTypeQQ),
                                                             @(SSDKPlatformTypeWechat)] onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType){
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
//             case SSDKPlatformTypeSinaWeibo:
//                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
//                 break;
//             case SSDKPlatformTypeRenren:
//                 [ShareSDKConnector connectRenren:[RennClient class]];
//                 break;
             default:
                 break;
         }
     }
        onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo){
         switch (platformType){
//             case SSDKPlatformTypeSinaWeibo:
//                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
//                 [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
//                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
//                                         redirectUri:@"http://www.sharesdk.cn"
//                                            authType:SSDKAuthTypeBoth];
//                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wxffa4d8af156c2932"
                                       appSecret:@"2601fcca50d00d2ca0d73678b5c62581"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1105925141"
                                      appKey:@"KEYXJVeVtoVUbCQ2AtU"
                                    authType:SSDKAuthTypeBoth];
                 break;
//             case SSDKPlatformTypeRenren:
//                 [appInfo        SSDKSetupRenRenByAppId:@"226427"
//                                                 appKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
//                                              secretKey:@"f29df781abdd4f49beca5a2194676ca4"
//                                               authType:SSDKAuthTypeBoth];
//                 break;
//             case SSDKPlatformTypeGooglePlus:
//                 
//                 [appInfo SSDKSetupGooglePlusByClientID:@"232554794995.apps.googleusercontent.com"
//                                           clientSecret:@"PEdFgtrMw97aCvf0joQj7EMk"
//                                            redirectUri:@"http://localhost"];
//                 break;
             default:
                 break;
         }
     }];
}

- (void)initCloudPush{
//    [CloudPushSDK turnOnDebug];//打开推送日志，测试时可选择打开，app上线后建议关闭
//    NSArray *ary = [NSArray arrayWithObjects:@"23638388",@"48ee912efefde18d7283b4569dd300aa", nil];//test
    NSArray *ary = [NSArray arrayWithObjects:@"23639038",@"6fcdc0bae88502c0f3c0fa7a83292faf", nil];//dev
//    NSArray *ary = [NSArray arrayWithObjects:@"23610187",@"0ffa1f01cd4445fd45ed2573a133e16b", nil];
    //初始化sdk
    [CloudPushSDK asyncInit:ary.firstObject appSecret:ary.lastObject callback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            GRLog(@"Push SDK init success, deviceId: %@.", [CloudPushSDK getDeviceId]);
        } else {
            GRLog(@"Push SDK init failed, error: %@", res.error);
        }
    }];
}
/**
 *    注册苹果推送，获取deviceToken用于推送
*/
- (void)registerAPNS:(UIApplication *)application {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        // iOS 8 Notifications
        [application registerUserNotificationSettings:
         [UIUserNotificationSettings settingsForTypes:
          (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                           categories:nil]];
        [application registerForRemoteNotifications];
    }
    else {
        // iOS < 8 Notifications
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    }
}
/*
 *  苹果推送注册成功回调，将苹果返回的deviceToken上传到CloudPush服务器
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [CloudPushSDK registerDevice:deviceToken withCallback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            GRLog(@"Register deviceToken success.");
        } else {
            GRLog(@"Register deviceToken failed, error: %@", res.error);
        }
    }];
}
/*
 *  苹果推送注册失败回调
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    GRLog(@"didFailToRegisterForRemoteNotificationsWithError %@", error);
}

/**
 *    注册推送消息到来监听
 */
- (void)registerMessageReceive {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onMessageReceived:)
                                                 name:@"CCPDidReceiveMessageNotification"
                                               object:nil];
}
/**
 *    处理到来推送消息
 */
- (void)onMessageReceived:(NSNotification *)notification {
    CCPSysMessage *message = [notification object];
    NSString *title = [[NSString alloc] initWithData:message.title encoding:NSUTF8StringEncoding];

    if ([title isEqualToString:@"new_price"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:GRPositionNew_PriceSNotification object:nil userInfo:[NSJSONSerialization JSONObjectWithData:message.body options:NSJSONReadingAllowFragments error:nil]];
    }else if ([title isEqualToString:@"kline_data"]){
        [[NSNotificationCenter defaultCenter] postNotificationName:GRPositionNew_DataNotification object:nil userInfo:[NSJSONSerialization JSONObjectWithData:message.body options:NSJSONReadingAllowFragments error:nil]];
    }
//    GRLog(@"Receive message title: %@, content: %@.", title, body);
}

/**
 *	注册推送通道打开监听
 */
- (void)listenerOnChannelOpened {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onChannelOpened:)
                                                 name:@"CCPDidChannelConnectedSuccess"
                                               object:nil];
}

/**
 *	推送通道打开回调
*/
- (void)onChannelOpened:(NSNotification *)notification {
//    [MsgToolBox showAlert:@"温馨提示" content:@"消息通道建立成功"];
    GRLog(@"%@",@"消息通道建立成功");
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    GRLog(@"Receive one notification.");
    // 取得APNS通知内容
//    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    // 内容
//    NSString *content = [aps valueForKey:@"alert"];
    // badge数量
//    NSInteger badge = [[aps valueForKey:@"badge"] integerValue];
    // 播放声音
//    NSString *sound = [aps valueForKey:@"sound"];
    // 取得Extras字段内容
//    NSString *Extras = [userInfo valueForKey:@"Extras"]; //服务端中Extras字段，key是自己定义的
//    GRLog(@"content = [%@], badge = [%ld], sound = [%@], Extras = [%@]", content, (long)badge, sound, Extras);
    // iOS badge 清0
    application.applicationIconBadgeNumber = 0;
    // 通知打开回执上报
    // [CloudPushSDK handleReceiveRemoteNotification:userInfo];(Deprecated from v1.8.1)
    [CloudPushSDK sendNotificationAck:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - GRNoNetWorkViewControllerDelegate
- (void)gr_noNetworkDidClickBtn:(UIButton *)btn{
    [self performSelector:@selector(detectionNetWork:) withObject:nil afterDelay:0.35f];
}

#pragma mark 禁止横屏
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AFNetworkingReachabilityNotificationStatusItem object:nil];
}

@end
