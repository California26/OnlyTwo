//
//  GRPropertyCell.h
//  GoldRush
//
//  Created by Jack on 2017/1/18.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRPropertyCell : UITableViewCell

///总资产
@property (nonatomic, copy) void(^totalPropertyBlock)();
///赢家券
@property (nonatomic, copy) void(^discountBlock)();
///金额
@property (nonatomic, copy) NSString *money;
///抵金券
@property (nonatomic, copy) NSString *thicket;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
