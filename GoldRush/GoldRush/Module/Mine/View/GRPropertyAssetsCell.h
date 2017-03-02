//
//  GRPropertyAssetsCell.h
//  GoldRush
//
//  Created by Jack on 2017/1/10.
//  Copyright © 2017年 Jack. All rights reserved.
//  账户净资产

#import <UIKit/UIKit.h>

@class GRNetAssetsModel;
@interface GRPropertyAssetsCell : UITableViewCell

///充值
@property (nonatomic, copy) void(^rechargeBlcok)();

///提现
@property (nonatomic, copy) void(^withdrawBlock)();

///抵金券
@property (nonatomic, copy) void(^ticketBlock)();

///资产明细模型
@property (nonatomic, strong) GRNetAssetsModel *netAssets;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
