//
//  GRPropertyHoldPositionDetailNoDataCell.m
//  GoldRush
//
//  Created by Jack on 2017/2/4.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRPropertyHoldPositionDetailNoDataCell.h"
#import "GRTabBarController.h"

@implementation GRPropertyHoldPositionDetailNoDataCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        UIButton *holdPositionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        holdPositionBtn.frame = CGRectMake(0, 0, K_Screen_Width, 88);
        [self.contentView addSubview:holdPositionBtn];
        [holdPositionBtn addTarget:self action:@selector(orderClick:) forControlEvents:UIControlEventTouchUpInside];
        [holdPositionBtn setTitle:@"目前尚未持仓,立即下单>" forState:UIControlStateNormal];
        [holdPositionBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        
    }
    return self;
}

#pragma mark - event response
- (void)orderClick:(UIButton *)btn{    
    if (self.delegate && [self.delegate respondsToSelector:@selector(propertyHoldPositionDetailNoDataCell:didClickDealBtn:)]) {
        [self.delegate propertyHoldPositionDetailNoDataCell:self didClickDealBtn:btn];
    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRPropertyHoldPositionDetailNoDataCell";
    GRPropertyHoldPositionDetailNoDataCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRPropertyHoldPositionDetailNoDataCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
