//
//  GRJDBankModel.m
//  GoldRush
//
//  Created by Jack on 2017/2/20.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRJDBankModel.h"

@implementation GRJDBankModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"bankID":@"id"};
}

@end
