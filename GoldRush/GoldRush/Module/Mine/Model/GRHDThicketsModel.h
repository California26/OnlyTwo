//
//  GRHDThicketsModel.h
//  GoldRush
//
//  Created by Jack on 2017/2/9.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRHDThicketsModel : NSObject

///渠道
@property (nonatomic, assign) NSInteger channel;

///渠道名称
@property (nonatomic, copy) NSString *channelName;

///赢家券ID
@property (nonatomic, assign) NSInteger couponId;

///赢家券名称
@property (nonatomic, copy) NSString *couponName;

///描述
@property (nonatomic, copy) NSString *thicketDesc;

///有效结束时间
@property (nonatomic, copy) NSString *endDate;

///有效结束时间
@property (nonatomic, copy) NSString *endTime;

///是否有效
@property (nonatomic, assign) NSInteger flag;

///用户赢家券ID
@property (nonatomic, assign) NSInteger userID;

///是否送赢家券
@property (nonatomic, assign) NSInteger isPay;

///是否使用
@property (nonatomic, assign) NSInteger isUse;

///手机号
@property (nonatomic, assign) NSUInteger mobile;

///操作类型
@property (nonatomic, copy) NSString *operateType;

///订单编号
@property (nonatomic, copy) NSString *orderNum;

///赠送金额
@property (nonatomic, assign) NSInteger rechargeMoney;

///有效开始时间
@property (nonatomic, copy) NSString *startDate;

///有效开始时间
@property (nonatomic, copy) NSString *startTime;

///管理员账号ID
@property (nonatomic, copy) NSString *sysUserId;

///使用时间
@property (nonatomic, copy) NSString *useTime;

///微信ID
@property (nonatomic, copy) NSString *wid;

///数量
@property (nonatomic, assign) NSInteger num;

@end
