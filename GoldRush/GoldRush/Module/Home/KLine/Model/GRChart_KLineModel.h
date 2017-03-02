//
//  GRChart_KLineModel.h
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/13.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GRChart_KLineGruopModel;

typedef NS_ENUM(NSInteger, CoinType) {
    CoinTypeZebant = 1, // 银元卷
    CoinTypeRMB,        //人命币
    CoinTypeOther       //未定义类型
};
@interface GRChart_KLineModel : NSObject

/**
 货币类型
 */
@property (nonatomic,assign) CoinType coinType;

/**
 前一个Model
 */
@property (nonatomic,strong) GRChart_KLineModel *previousKLineModel;

/**
 父ModelArray：用来给当前Model索引到parent数组
 */
@property (nonatomic,strong) GRChart_KLineGruopModel *parentGruopModel;

/**
 *  日期
 */
@property (nonatomic,copy) NSString *date;

/**
 开盘价
 */
@property (nonatomic,copy) NSNumber *open;

/**
 收盘价
 */
@property (nonatomic,copy) NSNumber *close;

/**
 最高价
 */
@property (nonatomic,copy) NSNumber *hight;

/**
 最低价
 */
@property (nonatomic,copy) NSNumber *low;

/**
 分时图的数值
 */
@property (nonatomic,copy) NSNumber *minuteNumber;

/**
 是否是每个月的第一个交易日
 */
@property (nonatomic,assign) BOOL isFirstTradeDate;
//初始化Model
- (void)initWithArray:(NSArray *)arr;
//// 初始化第一条数据
//- (void)initFirstModel;
////初始化其他数据
//- (void)initData;

@end
