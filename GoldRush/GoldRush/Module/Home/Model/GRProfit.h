//
//  GRProfit.h
//  GoldRush
//
//  Created by Jack on 2016/12/23.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRProfit : NSObject

///头像路径
@property (nonatomic, copy) NSString *url;
///昵称
@property (nonatomic, copy) NSString *nickName;
///盈利金额
@property (nonatomic, copy) NSString *profit;
///排名
@property (nonatomic, copy) NSString *rank;


@end

