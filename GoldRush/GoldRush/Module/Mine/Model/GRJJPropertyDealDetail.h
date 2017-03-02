//
//  GRJJPropertyDealDetail.h
//  GoldRush
//
//  Created by Jack on 2017/2/9.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRJJPropertyDealDetail : NSObject

///是否展开
@property (nonatomic, assign,getter=isUnfold) BOOL unfold;


///单子实际盈亏，此值是 profitOrLoss 减去建仓费用之后的数字
@property (nonatomic, assign) CGFloat actualProfitLoss;

///手数
@property (nonatomic, copy) NSString *amount;

///建仓时产品价格
@property (nonatomic, copy) NSString *buildPositionPrice;

///建仓时间
@property (nonatomic, assign) NSInteger buildTime;

///平仓收入
@property (nonatomic, copy) NSString *liquidateIncome;

///平仓时产品价格
@property (nonatomic, copy) NSString *liquidatePositionPrice;

///平仓时间，请自行根据需要格式化
@property (nonatomic, assign) NSInteger liquidateTime;

///平仓类型:1 爆仓;2 客户手动平仓;3 止赢平仓; 4 止损平仓;5 结算平仓
@property (nonatomic, assign) NSInteger liquidateType;

///单子 ID
@property (nonatomic, copy) NSString *orderId;

///订单号
@property (nonatomic, assign) NSInteger orderNo;

///持仓过夜费用
@property (nonatomic, assign) CGFloat overNightFeeAmount;

///产品规格名称
@property (nonatomic, copy) NSString *productName;

///单子盈亏
@property (nonatomic, copy) NSString *profitOrLoss;

///盈亏百分比
@property (nonatomic, copy) NSString *profitOrLossPercent;

///建仓保证金，即单子的费用
@property (nonatomic, assign) NSInteger tradeDeposit;

///手续费
@property (nonatomic, copy) NSString *tradeFee;

///涨/跌
@property (nonatomic, assign) NSInteger tradeType;

///是否使用赢家券做的单:1 是;0 否
@property (nonatomic, assign) NSInteger useTicket;

@end
