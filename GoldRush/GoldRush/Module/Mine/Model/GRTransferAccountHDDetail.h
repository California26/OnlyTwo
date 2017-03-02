//
//  GRTransferAccountHDDetail.h
//  GoldRush
//
//  Created by Jack on 2017/2/22.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRTransferAccountHDDetail : NSObject

///创建时间
@property (nonatomic, copy) NSString *addTime;
///余额
@property (nonatomic, copy) NSString *balance;
///金额
@property (nonatomic, copy) NSString *money;
///流水 ID
@property (nonatomic, copy) NSString *moneyLogId;
///订单 ID
@property (nonatomic, copy) NSString *orderId;
///订单号
@property (nonatomic, copy) NSString *orderNum;
///订单标示
@property (nonatomic, copy) NSString *orderType;
///
@property (nonatomic, copy) NSString *pageNo;

@property (nonatomic, copy) NSString *pageSize;
///支付类型
@property (nonatomic, copy) NSString *payType;
///出入金标示1出金2入金
@property (nonatomic, copy) NSString *reType;
///备注
@property (nonatomic, copy) NSString *remark;
///微信 ID
@property (nonatomic, copy) NSString *wid;

@end
