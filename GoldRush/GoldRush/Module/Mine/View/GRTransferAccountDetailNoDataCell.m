//
//  GRGRTransferAccountDetailNoDataCell.m
//  GoldRush
//
//  Created by Jack on 2017/2/4.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRTransferAccountDetailNoDataCell.h"

@implementation GRTransferAccountDetailNoDataCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(K_Screen_Width/2-35, 40, 70, 70)];
        icon.backgroundColor = [UIColor colorWithHexString:@"#d2d2d2"];
        icon.layer.cornerRadius = icon.frame.size.width/2;
        icon.layer.masksToBounds = YES;
        
        UILabel *labelText = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(icon.frame)+30, K_Screen_Width, 20)];
        labelText.font = [UIFont systemFontOfSize:15];
        labelText.text = @"暂无转账记录";
        labelText.textAlignment = NSTextAlignmentCenter;
        labelText.textColor = [UIColor colorWithHexString:@"#666666"];
        [self.contentView addSubview:icon];
        [self.contentView addSubview:labelText];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRTransferAccountDetailNoDataCell";
    GRTransferAccountDetailNoDataCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRTransferAccountDetailNoDataCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
