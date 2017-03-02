//
//  GRPlanIntroduceCell.h
//  GoldRush
//
//  Created by Jack on 2017/1/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRJoinPlan;
@interface GRPlanIntroduceCell : UITableViewCell

///模型数据
@property(nonatomic, strong) GRJoinPlan *model;

///rowheight
@property (nonatomic, assign) CGFloat rowHeight;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
