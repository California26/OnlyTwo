//
//  GRJDRechargeCell.m
//  GoldRush
//
//  Created by Jack on 2017/2/17.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRJDRechargeCell.h"

@implementation GRJDRechargeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.imageView.image = [UIImage imageNamed:@"Mine_Card"];
        self.textLabel.text = @"建行";
        self.detailTextLabel.text = @"储蓄卡 *********23424---34234";
        
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRJDRechargeCell";
    GRJDRechargeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRJDRechargeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
