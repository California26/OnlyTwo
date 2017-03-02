//
//  GR_KLine.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GR_KLine.h"
#import "UIColor+GRChart.h"
#import "GRChartGlobalVariable.h"
#import "KLineConstant.h"

@interface GR_KLine ()

/**
 context
 */
@property (nonatomic,assign) CGContextRef context;

/**
 最后一个绘制日期点
 */
@property (nonatomic,assign) CGPoint lastDrawDatePoint;


@end

@implementation GR_KLine

- (instancetype)initWithContext:(CGContextRef)context
{
    self = [super init];
    if (self) {
        _context = context;
        _lastDrawDatePoint = CGPointZero;
    }
    return self;
}

- (void)draw
{
    if (!self.kLineModel || !self.context || !self.kLinePositionModel) {
        
    }else{
    
    CGContextRef context = self.context;
    //设置画笔颜色
    UIColor *strokeColor = self.kLinePositionModel.OpenPoint.y < self.kLinePositionModel.ClosePoint.y ? [UIColor increaseColor] : [UIColor decreaseColor];
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    
    //画中间较宽的开收盘线段-实体线
    CGContextSetLineWidth(context, [GRChartGlobalVariable kLineWidth]);
    const CGPoint solidPoints[] = {self.kLinePositionModel.OpenPoint,self.kLinePositionModel.ClosePoint};
    //画线
    CGContextStrokeLineSegments(context, solidPoints, 2);
    
    //画上下阴影
    CGContextSetLineWidth(context, Y_StockChartShadowLineWidth);
    const CGPoint shadowPoints[] = {self.kLinePositionModel.HighPoint,self.kLinePositionModel.LowPoint};
    //画线
    CGContextStrokeLineSegments(context, shadowPoints, 2);

    }
}


@end
