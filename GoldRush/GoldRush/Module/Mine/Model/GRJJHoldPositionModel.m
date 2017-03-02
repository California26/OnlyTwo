//
//  GRJJHoldPositionModel.m
//  GoldRush
//
//  Created by Jack on 2017/2/8.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRJJHoldPositionModel.h"

@implementation GRJJHoldPositionModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"orderID":@"id"};
}

@end
