//
//  GRJJPropertyHoldPositionDetailCell.h
//  GoldRush
//
//  Created by Jack on 2017/2/8.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRJJHoldPositionModel;

@interface GRJJPropertyHoldPositionDetailCell : UITableViewCell

///平仓
@property (nonatomic, copy) void(^closePosition)();
///止盈止损
@property (nonatomic, copy) void(^stopProfitLoss)(UIButton *btn);
///是否持仓过夜
@property (nonatomic, copy) void(^holdPosition)();

///持仓模型
@property (nonatomic, strong) GRJJHoldPositionModel *holdPositionModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end