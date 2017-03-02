//
//  GRHDProductModel.h
//  GoldRush
//
//  Created by Jack on 2017/1/18.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRHDProductModel : NSObject

///商品符号
@property (nonatomic, copy) NSString *contract;
///产品对应抵金券 ID
@property (nonatomic, assign) NSInteger couponId;
///对应赢家券名称
@property (nonatomic, copy) NSString *couponName;
///创建时间
@property (nonatomic, copy) NSString *createdTime;
///
@property (nonatomic, assign) NSInteger decimal;
///
@property (nonatomic, assign) NSInteger deliveryFlag;
///
@property (nonatomic, assign) NSInteger expired;
///手续费
@property (nonatomic, assign) CGFloat fee;
///是否启用
@property (nonatomic, assign) NSInteger flag;
///产品名称
@property (nonatomic, copy) NSString *name;
///
@property (nonatomic, assign) NSInteger orderTime;
///订单类型
@property (nonatomic, copy) NSString *orderType;
///机构ID
@property (nonatomic, assign) NSInteger orgId;
///盈亏比值
@property (nonatomic, assign) CGFloat plRatio;
///价格
@property (nonatomic, assign) CGFloat price;
///产品ID
@property (nonatomic, assign) NSInteger productId;
///父产品ID
@property (nonatomic, assign) NSInteger productPid;
///类型
@property (nonatomic, copy) NSString *productType;
///产品规格
@property (nonatomic, copy) NSString *spec;
///元/千克
@property (nonatomic, copy) NSString *unit;
///修改时间
@property (nonatomic, copy) NSString *updatedTime;
///重量
@property (nonatomic, assign) CGFloat weight;

@end
