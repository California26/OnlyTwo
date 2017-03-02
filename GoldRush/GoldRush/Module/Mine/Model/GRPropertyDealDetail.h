//
//  GRPropertyDealDetail.h
//  GoldRush
//
//  Created by Jack on 2017/1/11.
//  Copyright © 2017年 Jack. All rights reserved.
//  恒大 model

#import <Foundation/Foundation.h>

@interface GRPropertyDealDetail : NSObject

///交易时间
@property (nonatomic, copy) NSString *addTime;
///产品名称
@property (nonatomic, copy) NSString *proDesc;
///盈利/亏损数额
@property (nonatomic, copy) NSString *plAmount;
///建仓价
@property (nonatomic, copy) NSString *buyPrice;
///平仓价
@property (nonatomic, copy) NSString *sellPrice;
///建仓成本
@property (nonatomic, copy) NSString *buyMoney;
///手续费
@property (nonatomic, copy) NSString *fee;
///购买方式
@property (nonatomic, copy) NSString *payType;
///平仓类型
@property (nonatomic, copy) NSString *orderType;
///平仓时间
@property (nonatomic, copy) NSString *sellTime;
///涨/跌
@property (nonatomic, copy) NSString *buyDirection;
///是否展开
@property (nonatomic, assign,getter=isUnfold) BOOL unfold;

///余额
@property (nonatomic, copy) NSString *balance;
///买入数量
@property (nonatomic, copy) NSString *count;
///是否使用赢家劵（0:不使用；1：使用）
@property (nonatomic, copy) NSString *couponFlag;
///金额
@property (nonatomic, copy) NSString *money;
///订单 ID
@property (nonatomic, copy) NSString *orderId;
///产品 ID
@property (nonatomic, copy) NSString *productId;
///
@property (nonatomic, copy) NSString *reType;
///备注
@property (nonatomic, copy) NSString *remark;
///规格
@property (nonatomic, copy) NSString *spec;
///交易产品重量
@property (nonatomic, copy) NSString *weight;
///订单号
@property (nonatomic, copy) NSString *buyNum;
///止损报价
@property (nonatomic, copy) NSString *bottomPrice;
///止盈报价
@property (nonatomic, copy) NSString *topPrice;

///微信 ID
@property (nonatomic, copy) NSString *wid;
///盈亏比例
@property (nonatomic, copy) NSString *plRatio;
///订单号
@property (nonatomic, copy) NSString *orderNum;
///爆仓价
@property (nonatomic, copy) NSString *deficitPrice;
///止损比例
@property (nonatomic, copy) NSString *bottomLimit;
///止盈比例
@property (nonatomic, copy) NSString *topLimit;

///产品名字
@property (nonatomic, copy) NSString *contract;
@end
