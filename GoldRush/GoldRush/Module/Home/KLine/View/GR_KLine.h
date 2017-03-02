//
//  GR_KLine.h
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GRChart_KLinePositionModel.h"
#import "GRChart_KLineModel.h"

@interface GR_KLine : NSObject

/**
 K线的位置的model
 */
@property (nonatomic,strong) GRChart_KLinePositionModel *kLinePositionModel;

/**
 k线的Model
 */
@property (nonatomic,strong) GRChart_KLineModel *kLineModel;

/**
 最大的Y
 */
@property (nonatomic,assign) CGFloat  maxY;

/**
 最小的Y
 */
@property (nonatomic,assign) CGFloat minY;

/**
 根据context初始化
 */
- (instancetype)initWithContext:(CGContextRef)context;

/**
 绘制K线
 */
- (void)draw;

@end
