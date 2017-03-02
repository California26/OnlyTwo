//
//  GRDocumentary.h
//  GoldRush
//
//  Created by Jack on 2017/1/7.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRDocumentary : NSObject

///头像
@property (nonatomic, copy) NSString *header;
///分析师名字
@property (nonatomic, copy) NSString *name;
///参与合买人数
@property (nonatomic, copy) NSString *number;
///盈利
@property (nonatomic, copy) NSString *profit;
///昵称
@property (nonatomic, copy) NSString *nick;
///关注数
@property (nonatomic, copy) NSString *fellow;
///盈利指数
@property (nonatomic, copy) NSString *profitIndex;

@end
