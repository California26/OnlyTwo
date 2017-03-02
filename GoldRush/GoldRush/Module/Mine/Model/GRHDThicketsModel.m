//
//  GRHDThicketsModel.m
//  GoldRush
//
//  Created by Jack on 2017/2/9.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRHDThicketsModel.h"

@implementation GRHDThicketsModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"thicketDesc":@"description",
             @"userID":@"id"};
}

@end
