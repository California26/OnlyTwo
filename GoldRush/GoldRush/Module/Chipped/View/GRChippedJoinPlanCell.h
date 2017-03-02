//
//  GRChippedJoinPlanCell.h
//  GoldRush
//
//  Created by Jack on 2016/12/31.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRJoinPlan;
@interface GRChippedJoinPlanCell : UITableViewCell
///模型数据
@property(nonatomic, strong) GRJoinPlan *joinPlanModel;
///加入计划点击事件
@property (nonatomic, copy) void(^joinPlanBlock)();


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
