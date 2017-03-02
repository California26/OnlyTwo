//
//  GRChart_KLinePositionModel.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/13.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRChart_KLinePositionModel.h"

@implementation GRChart_KLinePositionModel
+(instancetype)modelWithOpen:(CGPoint)openPoint close:(CGPoint)closePoint high:(CGPoint)highPoint low:(CGPoint)lowPoint 
{
    GRChart_KLinePositionModel *model = [GRChart_KLinePositionModel new];
    model.OpenPoint = openPoint;
    model.ClosePoint = closePoint;
    model.HighPoint = highPoint;
    model.LowPoint = lowPoint;
//    model.datePoint = datePoint;
    return model;
}

+ (instancetype) modelWithCurrent:(CGPoint)currentPoint
{
    GRChart_KLinePositionModel *model = [GRChart_KLinePositionModel new];
    model.currentPoint = currentPoint;
    return model;
}

@end
