//
//  GRTakePartInChippedCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/7.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRTakePartInChippedCell.h"

@implementation GRTakePartInChippedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //参与按钮
        UIButton *participate = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:participate];
        [participate setTitle:@"参与合买" forState:UIControlStateNormal];
        [participate addTarget:self action:@selector(participateClick:) forControlEvents:UIControlEventTouchUpInside];
        [participate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        participate.titleLabel.font = [UIFont systemFontOfSize:15];
        participate.backgroundColor = mainColor;
        participate.layer.cornerRadius = 5;
        participate.layer.masksToBounds = YES;
        
        [participate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.height.equalTo(@30);
            make.width.equalTo(@120);
        }];
    }
    return self;
}

- (void)participateClick:(UIButton *)btn{
    if (self.participateBlock) {
        self.participateBlock();
    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRTakePartInChippedCell";
    GRTakePartInChippedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRTakePartInChippedCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
