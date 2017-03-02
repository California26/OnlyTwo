//
//  GRTransferAccountDetail.h
//  GoldRush
//
//  Created by Jack on 2017/1/12.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRTransferAccountDetail : NSObject

///流水 ID
@property (nonatomic, strong) NSNumber *runID;
///订单号
@property (nonatomic, copy) NSString *order_no;
///收入金额，如果为建仓，这里为 null;否则为具体的金额数字
@property (nonatomic, copy) NSString *income;
///流水产生后用户帐户余额
@property (nonatomic, copy) NSString *balanceAfter;
///流水产生时间
@property (nonatomic, strong) NSNumber *createTime;
///流水类型:1建仓2平仓3充值 4 现5手动充值6佣金转账户 7 交割滞纳金9 退票 10 扣款
@property (nonatomic, copy) NSString *type;
///流水解释，可以直接展示给用户看
@property (nonatomic, copy) NSString *remark;
///支付资金
@property (nonatomic, copy) NSString *pay;

@end
