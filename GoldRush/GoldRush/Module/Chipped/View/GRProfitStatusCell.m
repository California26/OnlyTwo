//
//  GRProfitStatusCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/10.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRProfitStatusCell.h"

@implementation GRProfitStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRProfitStatusCell";
    GRProfitStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRProfitStatusCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
