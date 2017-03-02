//
//  GRCalculateProfitLoss.h
//  GoldRush
//
//  Created by Jack on 2017/3/1.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRCalculateProfitLoss : NSObject


/**
 计算恒大实时盈亏数额

 @param holdArray 持仓数组
 @param dict 最新报价
 @return 修改后的实时盈亏数额
 */
+ (NSMutableArray *)calculateHDProfitLossWithArray:(NSMutableArray *)holdArray withNotificationDict:(NSDictionary *)dict;


/**
 计算吉交所实时盈亏

 @param holdArray 持仓数组
 @param dict 最新报价
 @return 修改后的实时盈亏数组
 */
+ (NSMutableArray *)calculateJJProfitLossWithArray:(NSMutableArray *)holdArray withNotificationDict:(NSDictionary *)dict;

@end
