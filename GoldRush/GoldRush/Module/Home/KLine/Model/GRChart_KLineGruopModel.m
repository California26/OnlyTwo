//
//  GRChart_KLineGruopModel.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/13.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRChart_KLineGruopModel.h"

#import "GRChart_KLineModel.h"
@implementation GRChart_KLineGruopModel

+ (instancetype)objectWithArray:(NSArray *)arr
{
    NSAssert([arr isKindOfClass:[NSArray class]], @"arr 不是一个数组");
    GRChart_KLineGruopModel *gruopModel = [GRChart_KLineGruopModel new];
    NSMutableArray *mutableArr = [NSMutableArray array];
    __block GRChart_KLineModel *preModel = [[GRChart_KLineModel alloc] init];
    
    //设置数据
    for (NSArray *valueArr in arr) {
        GRChart_KLineModel *model = [GRChart_KLineModel new];
        model.previousKLineModel = preModel;
        [model initWithArray:valueArr];
        model.parentGruopModel = gruopModel;
        [mutableArr addObject:model];
        preModel = model;
        
    }
    gruopModel.models = mutableArr;
    //初始化第一个Model
//    GRChart_KLineModel *firstModel = mutableArr[0];
//    [firstModel initFirstModel];
//    [mutableArr enumerateObjectsUsingBlock:^(GRChart_KLineModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
//        [model initData];
//    }];
    return gruopModel;
}

@end
