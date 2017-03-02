//
//  GRThicketNoDataCell.m
//  GoldRush
//
//  Created by Jack on 2017/2/10.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRThicketNoDataCell.h"

@interface GRThicketNoDataCell ()

@end

@implementation GRThicketNoDataCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *view = [[UIView alloc] init];
        [self.contentView addSubview:view];
        view.backgroundColor = defaultBackGroundColor;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.contentView);
            make.height.mas_equalTo(10);
        }];
        
        UIImageView *noThickets = [[UIImageView alloc] init];
        noThickets.image = [UIImage imageNamed:@"Mine_No_Thicket"];
        [self.contentView addSubview:noThickets];
        [noThickets mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(view.mas_bottom).offset(20);
        }];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRThicketNoDataCell";
    GRThicketNoDataCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRThicketNoDataCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
