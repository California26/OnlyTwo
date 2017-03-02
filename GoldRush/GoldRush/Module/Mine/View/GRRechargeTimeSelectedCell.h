//
//  GRRechargeTimeSelectedCell.h
//  GoldRush
//
//  Created by Jack on 2017/1/11.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRRechargeTimeSelectedCell;
@protocol GRRechargeTimeSelectedCellDeleagate <NSObject>

@optional
- (void)gr_rechargeTimeSelectedCellClick:(GRRechargeTimeSelectedCell *)cell;

@end

@interface GRRechargeTimeSelectedCell : UITableViewCell

@property (nonatomic, weak) id<GRRechargeTimeSelectedCellDeleagate> delegate;

///时间范围
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
