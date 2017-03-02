//
//  GRJoinPlan.h
//  GoldRush
//
//  Created by Jack on 2017/1/2.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRJoinPlan : NSObject

///头像
@property (nonatomic, copy) NSString *header;
///分析师名字
@property (nonatomic, copy) NSString *name;
///资金门槛
@property (nonatomic, copy) NSString *warn;
///上周收益
@property (nonatomic, copy) NSString *profit;
///上周好评数
@property (nonatomic, copy) NSString *like;
///剩余名额
@property (nonatomic, copy) NSString *number;

@end
