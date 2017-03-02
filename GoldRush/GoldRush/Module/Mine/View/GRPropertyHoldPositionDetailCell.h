//
//  GRPropertyHoldPositionDetailCell.h
//  GoldRush
//
//  Created by Jack on 2017/1/10.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRPropertyDealDetail;

@interface GRPropertyHoldPositionDetailCell : UITableViewCell

///平仓
@property (nonatomic, copy) void(^closePosition)();
///止盈止损
@property (nonatomic, copy) void(^stopProfitLoss)(UIButton *btn);

///持仓模型
@property (nonatomic, strong) GRPropertyDealDetail *holdPositionModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
