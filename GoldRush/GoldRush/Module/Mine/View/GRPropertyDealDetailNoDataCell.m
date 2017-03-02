//
//  GRPropertyDealDetailNoDataCell.m
//  GoldRush
//
//  Created by Jack on 2017/2/4.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRPropertyDealDetailNoDataCell.h"

@implementation GRPropertyDealDetailNoDataCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 60)];
        [self.contentView addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"暂无交易流水!!!";
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRPropertyDealDetailNoDataCell";
    GRPropertyDealDetailNoDataCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRPropertyDealDetailNoDataCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
