//
//  GRJJProductModel.h
//  GoldRush
//
//  Created by Jack on 2017/2/7.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRJJProductModel : NSObject

///产品添加时间
@property (nonatomic, copy) NSString *addTime;
///产品规格
@property (nonatomic, copy) NSString *amount;
///当前是否可以交易
@property (nonatomic, copy) NSString *duringTradingTime;
///产品规格浮动盈亏比
@property (nonatomic, copy) NSString *floatProfit;
/// APP 端可以忽略此字段
@property (nonatomic, copy) NSString *floatUnit;
///最大仓位
@property (nonatomic, copy) NSString *maxBuyAmout;
///交割滞纳金费用(过夜费用)
@property (nonatomic, copy) NSString *overnightFee;
///overnightType: 过夜类型值(0 不过夜，-2 本周有效,-1长期有效)
@property (nonatomic, copy) NSString *overnightType;
///过夜类型说明
@property (nonatomic, copy) NSString *overnightTypeName;
///产品名称
@property (nonatomic, copy) NSString *productName;
///产品的合约代码
@property (nonatomic, copy) NSString *productNo;
///产品类型名字
@property (nonatomic, copy) NSString *productTypeName;
///规格 述
@property (nonatomic, copy) NSString *specifications;
///产品规格购买时的手续费比例
@property (nonatomic, copy) NSString *tradeFee;
///产品规格单位
@property (nonatomic, copy) NSString *unit;
///产品规格价格
@property (nonatomic, copy) NSString *unitPrice;
///产品更新时间
@property (nonatomic, copy) NSString *updateTime;
///产品规格的 ID
@property (nonatomic, copy) NSString *productID;

@end
