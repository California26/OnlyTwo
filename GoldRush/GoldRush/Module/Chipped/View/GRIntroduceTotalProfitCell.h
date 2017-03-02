//
//  GRIntroduceTotalProfitCell.h
//  GoldRush
//
//  Created by Jack on 2017/1/10.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRIntroduceTotalProfitCell : UITableViewCell

///总共盈利
@property (nonatomic, copy) NSString *totalProfit;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
