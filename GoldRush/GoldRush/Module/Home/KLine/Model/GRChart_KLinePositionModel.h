//
//  GRChart_KLinePositionModel.h
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/13.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRChart_KLinePositionModel : NSObject

/**
 *  开盘点
 */
@property (nonatomic, assign) CGPoint OpenPoint;

/**
 *  收盘点
 */
@property (nonatomic, assign) CGPoint ClosePoint;

/**
 *  最高点
 */
@property (nonatomic, assign) CGPoint HighPoint;

/**
 *  最低点
 */
@property (nonatomic, assign) CGPoint LowPoint;

/**
 日期
 */
@property (nonatomic, assign) CGPoint datePoint;

/**
 时刻值
 */
@property (nonatomic,assign) CGPoint currentPoint;


/**
 *  工厂方法
 */
+ (instancetype) modelWithOpen:(CGPoint)openPoint close:(CGPoint)closePoint high:(CGPoint)highPoint low:(CGPoint)lowPoint ;
+ (instancetype) modelWithCurrent:(CGPoint)currentPoint;
@end
