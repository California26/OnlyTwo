//
//  GRCalculateProfitLoss.m
//  GoldRush
//
//  Created by Jack on 2017/3/1.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRCalculateProfitLoss.h"
#import "GRPropertyDealDetail.h"
#import "GRJJHoldPositionModel.h"

@implementation GRCalculateProfitLoss

+ (NSMutableArray *)calculateHDProfitLossWithArray:(NSMutableArray *)holdArray withNotificationDict:(NSDictionary *)dict{
    NSString *newPrice;
    CGFloat profit = 0.0f;
    for (int i = 0;i < holdArray.count ; i++) {
        GRPropertyDealDetail *model = holdArray[i];
        if ([model.proDesc isEqualToString:@"银锭"]) {
            newPrice = dict[@"baibei"][HD_Contact][@"current"];
            if (newPrice) {
                if ([model.couponFlag isEqualToString:@"0"]) {    //未使用券
                    if ([model.buyDirection isEqualToString:@"2"]) {     ///买涨
                        profit += (newPrice.floatValue - model.buyPrice.floatValue) * model.count.floatValue * 4;
                    }else{
                        profit -= (newPrice.floatValue - model.buyPrice.floatValue) * model.count.floatValue * 4;
                    }
                }else{      //使用券
                    if ([model.buyDirection isEqualToString:@"2"]) {     ///买涨
                        if (newPrice.floatValue - model.buyPrice.floatValue >= 0) {
                            profit += (newPrice.floatValue - model.buyPrice.floatValue) * model.count.floatValue * 4;
                        }else{
                            profit = 0.0f;
                        }
                    }else{
                        if (newPrice.floatValue - model.buyPrice.floatValue < 0) {
                            profit -= (newPrice.floatValue - model.buyPrice.floatValue) * model.count.floatValue * 4;
                        }else{
                            profit = 0.0f;
                        }
                    }
                }
            }
        }else if ([model.proDesc isEqualToString:@"银条"]) {
            newPrice = dict[@"baibei"][HD_Contact][@"current"];
            if (newPrice) {
                if ([model.couponFlag isEqualToString:@"0"]) {
                    if ([model.buyDirection isEqualToString:@"2"]) {
                        profit += (newPrice.floatValue - model.buyPrice.floatValue) * model.count.floatValue * 0.1;
                    }else{
                        profit -= (newPrice.floatValue - model.buyPrice.floatValue) * model.count.floatValue * 0.1;
                    }
                }else{      //使用券
                    if ([model.buyDirection isEqualToString:@"2"]) {     ///买涨
                        if (newPrice.floatValue - model.buyPrice.floatValue >= 0) {
                            profit += (newPrice.floatValue - model.buyPrice.floatValue) * model.count.floatValue * 0.1;
                        }else{
                            profit = 0.0f;
                        }
                    }else{
                        if (newPrice.floatValue - model.buyPrice.floatValue < 0) {
                            profit -= (newPrice.floatValue - model.buyPrice.floatValue) * model.count.floatValue * 0.1;
                        }else{
                            profit = 0.0f;
                        }
                    }
                }
            }
        }else if ([model.proDesc isEqualToString:@"银砖"]) {
            newPrice = dict[@"baibei"][HD_Contact][@"current"];
            if (newPrice) {
                if ([model.couponFlag isEqualToString:@"0"]) {
                    if ([model.buyDirection isEqualToString:@"2"]) {
                        profit += (newPrice.floatValue - model.buyPrice.floatValue) * model.count.floatValue * 1;
                    }else{
                        profit -= (newPrice.floatValue - model.buyPrice.floatValue) * model.count.floatValue * 1;
                    }
                }else{      //使用券
                    if ([model.buyDirection isEqualToString:@"2"]) {     ///买涨
                        if (newPrice.floatValue - model.buyPrice.floatValue >= 0) {
                            profit += (newPrice.floatValue - model.buyPrice.floatValue) * model.count.floatValue * 1;
                        }else{
                            profit = 0.0f;
                        }
                    }else{
                        if (newPrice.floatValue - model.buyPrice.floatValue < 0) {
                            profit -= (newPrice.floatValue - model.buyPrice.floatValue) * model.count.floatValue * 1;
                        }else{
                            profit = 0.0f;
                        }
                    }
                }
            }
        }
        model.plAmount = [NSString stringWithFormat:@"%.2f",profit];
        model.sellPrice = [NSString stringWithFormat:@"%.2f",newPrice.floatValue];
        [holdArray replaceObjectAtIndex:i withObject:model];
    }
    return holdArray;
}

+ (NSMutableArray *)calculateJJProfitLossWithArray:(NSMutableArray *)holdArray withNotificationDict:(NSDictionary *)dict{
    NSString *newPrice;
    CGFloat profit = 0.0f;
    for (int i = 0;i < holdArray.count ; i++) {
        GRJJHoldPositionModel *model = holdArray[i];
        if ([model.productName isEqualToString:@"燃料油"]) {
            newPrice = dict[@"jlmmex"][JJ_ContactOIL][@"current"];
            if (newPrice) {
                if (!model.useTicket) {     //未使用券
                    if (model.tradeType == 1) {     ///买涨
                        if (model.productId == 5) {
                            profit += (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 100 * 0.01;
                        }else if (model.productId == 6){
                            profit += (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 100 * 0.2;
                        }else if (model.productId == 34){
                            profit += (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 100 * 1;
                        }
                    }else{
                        if (model.productId == 5) {
                            profit -= (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 100 * 0.01;
                        }else if (model.productId == 6){
                            profit -= (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 100 * 0.2;
                        }else if (model.productId == 34){
                            profit -= (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 100 * 1;
                        }
                    }
                }else{      //使用券
                    if (model.tradeType == 1) {     ///买涨
                        if (model.productId == 5) {
                            if (newPrice.floatValue - model.buildPositionPrice.floatValue > 0) {
                                profit += (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 100 * 0.01;
                            }else{
                                profit = 0.0f;
                            }
                        }else if (model.productId == 6){
                            if (newPrice.floatValue - model.buildPositionPrice.floatValue > 0) {
                                profit += (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 100 * 0.2;
                            }else{
                                profit = 0.0f;
                            }
                        }else if (model.productId == 34){
                            if (newPrice.floatValue - model.buildPositionPrice.floatValue > 0) {
                                profit += (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 100 * 1;
                            }else{
                                profit = 0.0f;
                            }
                        }
                    }else{
                        if (model.productId == 5) {
                            if (newPrice.floatValue - model.buildPositionPrice.floatValue < 0) {
                                profit -= (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 100 * 0.01;
                            }else{
                                profit = 0.0f;
                            }
                        }else if (model.productId == 6){
                            if (newPrice.floatValue - model.buildPositionPrice.floatValue < 0) {
                                profit -= (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 100 * 0.2;
                            }else{
                                profit = 0.0f;
                            }
                        }else if (model.productId == 34){
                            if (newPrice.floatValue - model.buildPositionPrice.floatValue < 0) {
                                profit -= (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 100 * 1;
                            }else{
                                profit = 0;
                            }
                        }
                    }
                }
            }
        }else if ([model.productName isEqualToString:@"银制品"]) {
            newPrice = dict[@"jlmmex"][JJ_ContactXAG][@"current"];
            if (newPrice) {
                if (!model.useTicket) {
                    if (model.tradeType == 1) {
                        if (model.productId == 1) {
                            profit += (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 0.15;
                        }else if (model.productId == 2){
                            profit += (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 3;
                        }else if (model.productId == 33){
                            profit += (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 15;
                        }
                    }else{
                        if (model.productId == 1) {
                            profit -= (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 0.15;
                        }else if (model.productId == 2){
                            profit -= (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 3;
                        }else if (model.productId == 33){
                            profit -= (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 15;
                        }
                    }
                }else{      //使用券
                    if (model.tradeType == 1) {
                        if (model.productId == 1) {
                            if (newPrice.floatValue - model.buildPositionPrice.floatValue > 0) {
                                profit += (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 0.15;
                            }else{
                                profit = 0.0f;
                            }
                        }else if (model.productId == 2){
                            if (newPrice.floatValue - model.buildPositionPrice.floatValue > 0) {
                                profit += (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 3;
                            }else{
                                profit = 0.0f;
                            }
                        }else if (model.productId == 33){
                            if (newPrice.floatValue - model.buildPositionPrice.floatValue > 0) {
                                profit += (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 15;
                            }else{
                                profit = 0.0f;
                            }
                        }
                    }else{
                        if (model.productId == 1) {
                            if (newPrice.floatValue - model.buildPositionPrice.floatValue < 0) {
                                profit -= (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 0.15;
                            }else{
                                profit = 0.0f;
                            }
                        }else if (model.productId == 2){
                            if (newPrice.floatValue - model.buildPositionPrice.floatValue < 0) {
                                profit -= (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 3;
                            }else{
                                profit = 0.0f;
                            }
                        }else if (model.productId == 33){
                            if (newPrice.floatValue - model.buildPositionPrice.floatValue < 0) {
                                profit -= (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 15;
                            }else{
                                profit = 0.0f;
                            }
                        }
                    }
                }
            }
        }else if ([model.productName isEqualToString:@"电解铜"]) {
            newPrice = dict[@"jlmmex"][JJ_ContactCU][@"current"];
            if (newPrice) {
                if (!model.useTicket) {
                    if (model.tradeType == 1) {
                        if (model.productId == 3) {
                            profit += (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 0.01;
                        }else if (model.productId == 4){
                            profit += (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 0.2;
                        }else if (model.productId == 35){
                            profit += (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 1;
                        }
                    }else{
                        if (model.productId == 3) {
                            profit -= (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 0.01;
                        }else if (model.productId == 4){
                            profit -= (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 0.2;
                        }else if (model.productId == 35){
                            profit -= (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 1;
                        }
                    }
                }else{      ///使用券
                    if (model.tradeType == 1) {
                        if (model.productId == 3) {
                            if (newPrice.floatValue - model.buildPositionPrice.floatValue > 0) {
                                profit += (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 0.01;
                            }else{
                                profit = 0.0f;
                            }
                        }else if (model.productId == 4){
                            if (newPrice.floatValue - model.buildPositionPrice.floatValue > 0) {
                                profit += (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 0.2;
                            }else{
                                profit = 0.0f;
                            }
                        }else if (model.productId == 35){
                            if (newPrice.floatValue - model.buildPositionPrice.floatValue > 0) {
                                profit += (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 1;
                            }else{
                                profit = 0.0f;
                            }
                        }
                    }else{
                        if (model.productId == 3) {
                            if (newPrice.floatValue - model.buildPositionPrice.floatValue < 0) {
                                profit -= (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 0.01;
                            }else{
                                profit = 0.0f;
                            }
                        }else if (model.productId == 4){
                            if (newPrice.floatValue - model.buildPositionPrice.floatValue < 0) {
                                profit -= (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 0.2;
                            }else{
                                profit = 0.0f;
                            }
                        }else if (model.productId == 35){
                            if (newPrice.floatValue - model.buildPositionPrice.floatValue < 0) {
                                profit -= (newPrice.floatValue - model.buildPositionPrice.floatValue) * model.amount * 1;
                            }else{
                                profit = 0.0f;
                            }
                        }
                    }
                }
            }
        }
        model.profitOrLoss = [NSNumber numberWithFloat:profit];
        model.currentprice = [NSNumber numberWithFloat:newPrice.floatValue];
        [holdArray replaceObjectAtIndex:i withObject:model];
    }
    return holdArray;
}

@end
