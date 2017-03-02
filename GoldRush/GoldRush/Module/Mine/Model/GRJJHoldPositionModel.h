//
//  GRJJHoldPositionModel.h
//  GoldRush
//
//  Created by Jack on 2017/2/8.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRJJHoldPositionModel : NSObject
///手数
@property (nonatomic, assign) NSInteger amount;
///产品合约代码
@property (nonatomic, copy) NSString *productNo;
///止赢百分比
@property (nonatomic, copy) NSString *targetProfit;

@property (nonatomic, assign) NSInteger orgId;

@property (nonatomic, assign) NSInteger stopLossPrice;
///单子 ID
@property (nonatomic, copy) NSString *orderID;

@property (nonatomic, copy) NSString *lastFeeUpdate;

@property (nonatomic, copy) NSString *punit;

@property (nonatomic, assign) NSInteger liquidateIncome;
///建仓价格
@property (nonatomic, strong) NSNumber *buildPositionPrice;
//平仓类型。如果没有平仓，此值为 null
@property (nonatomic, assign) NSInteger liquidateType;
///爆仓价格
@property (nonatomic, assign) NSInteger brokenPrice;
///建仓支出金额
@property (nonatomic, assign) NSInteger tradeDeposit;

@property (nonatomic, assign) NSInteger overnightType;

@property (nonatomic, copy) NSString *overnightDeadline;

@property (nonatomic, strong) NSNumber *currentprice;
///平仓价格，如果单子没有平仓，此值为 null
@property (nonatomic, assign) NSInteger liquidatePositionPrice;

@property (nonatomic, assign) NSInteger ticketAmount;

@property (nonatomic, assign) NSInteger ticketCount;
///当前单子的盈亏金额，如果正负浮点型，保留两位小数
@property (nonatomic, strong) NSNumber *profitOrLoss;

@property (nonatomic, assign) NSInteger overnightTTL;

@property (nonatomic, assign) NSInteger overnightFee;
///建仓手续费
@property (nonatomic, assign) NSInteger tradeFee;
///单子是否使用赢家券 1 使用， 其他值，未使用
@property (nonatomic, assign) NSInteger useTicket;

@property (nonatomic, assign) NSInteger actualProfitLoss;

@property (nonatomic, assign) NSInteger memberId;

@property (nonatomic, assign) NSInteger status;
///建仓时间， 请自行转换时间格式
@property (nonatomic, assign) NSInteger buildPositionTime;

@property (nonatomic, copy) NSString *overnightTypeName;

@property (nonatomic, assign) NSInteger punitprice;
///单子方向:1 多单，即买涨;2 空单，即买跌
@property (nonatomic, assign) NSInteger tradeType;

@property (nonatomic, assign) NSInteger targetProfitPrice;
///订单号
@property (nonatomic, copy) NSString *orderNo;
///止损百分比
@property (nonatomic, copy) NSString *stopLoss;

@property (nonatomic, assign) NSInteger profitOrLossPercent;

@property (nonatomic, copy) NSString *liquidatePositionTime;

@property (nonatomic, assign) NSInteger floatUnit;

@property (nonatomic, assign) NSInteger overnightFeeAmount;
///产品规格名称
@property (nonatomic, copy) NSString *productName;

@property (nonatomic, assign) NSInteger currentProfitPercent;

@property (nonatomic, assign) NSInteger pamount;

@property (nonatomic, assign) NSInteger brokerId;

@property (nonatomic, assign) NSInteger floatProfit;
///产品规格 ID
@property (nonatomic, assign) NSInteger productId;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, copy) NSString *specifications;

@end
