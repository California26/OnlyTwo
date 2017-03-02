//
//  GRProProductNoTableViewCell.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/18.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRProProductNoTableViewCell.h"

@implementation GRProProductNoTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatSubViews];
    }
    return self;
}
- (void)creatSubViews
{
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(K_Screen_Width/2-35/2, 8, 35, 35)];
    icon.image = [UIImage imageNamed:@"Mine_Have_Hold_Position"];
    [self.contentView addSubview:icon];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(icon.frame)+5, K_Screen_Width, 18)];
    label.textColor = [UIColor colorWithHexString:@"#666666"];
    label.font = [UIFont systemFontOfSize:12];
    label.text = @"你当前暂无持仓";
    label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label];
}


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"PRODUCTNo";
    GRProProductNoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRProProductNoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
