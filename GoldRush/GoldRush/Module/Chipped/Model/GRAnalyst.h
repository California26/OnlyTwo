//
//  GRAnalyst.h
//  GoldRush
//
//  Created by Jack on 2016/12/28.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRAnalyst : NSObject

///分析师名字
@property (nonatomic, copy) NSString *name;
///正确率
@property (nonatomic, copy) NSString *accuracy;
///头像
@property (nonatomic, copy) NSString *header;


@end
