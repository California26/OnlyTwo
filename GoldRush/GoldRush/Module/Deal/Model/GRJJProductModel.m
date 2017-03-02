//
//  GRJJProductModel.m
//  GoldRush
//
//  Created by Jack on 2017/2/7.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRJJProductModel.h"

@implementation GRJJProductModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"productID":@"id"};
}

@end
