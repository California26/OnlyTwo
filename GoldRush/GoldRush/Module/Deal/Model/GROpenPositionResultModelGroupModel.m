//
//  GROpenPositionResultModelGroupModel.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/19.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GROpenPositionResultModelGroupModel.h"

@implementation GROpenPositionResultModelGroupModel


+ (instancetype) objectWithArray:(NSArray *)arr
{
    NSAssert([arr isKindOfClass:[NSArray class]], @"arr不是数组");
    
    GROpenPositionResultModelGroupModel *groupModel = [GROpenPositionResultModelGroupModel new];
    NSMutableArray *mutableArr = @[].mutableCopy;
    
    for (NSDictionary *dic in arr) {
        GROpenPositionResultModel *resultModel = [GROpenPositionResultModel initWithDic:dic];
        [mutableArr addObject:resultModel];
    }
    groupModel.models = mutableArr;
    
    return groupModel;
}

@end


@implementation GROpenPositionResultModel

+ (instancetype)initWithDic:(NSDictionary *)dic
{
    GROpenPositionResultModel *model = [GROpenPositionResultModel new];
    model.orderId = [NSString stringWithFormat:@"%@",dic[@"orderId"]];
    model.orderNum = dic[@"orderNum"];
    model.buyMoney = [NSString stringWithFormat:@"%@",dic[@"buyMoney"]];
    model.topPrice = [NSString stringWithFormat:@"%@",dic[@"topPrice"]];
    model.bottomPrice = [NSString stringWithFormat:@"%@",dic[@"bottomPrice"]];
    model.plAmount = [NSString stringWithFormat:@"%@",dic[@"plAmount"]];
    model.buyDirection =  dic[@"buyDirection"];
    model.buyPrice = [NSString stringWithFormat:@"%@",dic[@"buyPrice"]];
    return model;
}

@end
