//
//  GROpenPositionResultModelGroupModel.h
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/19.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GROpenPositionResultModel : NSObject

/**
 订单ID
 */
@property (nonatomic, copy) NSString *orderId;

/**
 订单号
 */
@property (nonatomic, copy) NSString *orderNum;

/**
 建仓价格
 */
@property (nonatomic, copy) NSString *buyPrice;

/**
 止损报价
 */
@property (nonatomic, copy) NSString *bottomPrice;

/**
 止盈报价
 */
@property (nonatomic, copy) NSString *topPrice;
/**
 交易资金
 */
@property (nonatomic, copy) NSString *buyMoney;

/**
 盈亏金额
 */
@property (nonatomic, copy) NSString *plAmount;

/**
 方向涨跌
 */
@property (nonatomic, copy) NSNumber *buyDirection;


+ (instancetype)initWithDic:(NSDictionary *)dic;

@end


@interface GROpenPositionResultModelGroupModel : NSObject


@property (nonatomic, copy) NSArray<GROpenPositionResultModel *> *models;

//初始化Model
+ (instancetype) objectWithArray:(NSArray *)arr;

@end
