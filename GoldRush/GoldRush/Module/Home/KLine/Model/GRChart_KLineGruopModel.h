//
//  GRChart_KLineGruopModel.h
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/13.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <math.h>
@class GRChart_KLineModel;

@interface GRChart_KLineGruopModel : NSObject

@property (nonatomic, copy) NSArray <GRChart_KLineModel *> *models;

//c初始化Model
+ (instancetype)objectWithArray:(NSArray *)arr;

@end
