//
//  GRAnalystComment.h
//  GoldRush
//
//  Created by Jack on 2017/1/9.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRAnalystComment : NSObject
///头像
@property (nonatomic, copy) NSString *iconName;
///名字
@property (nonatomic, copy) NSString *name;
///时间
@property (nonatomic, copy) NSString *time;
///内容详情
@property (nonatomic, copy) NSString *desc;
@end
