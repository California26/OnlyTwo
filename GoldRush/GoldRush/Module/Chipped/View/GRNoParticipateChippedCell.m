//
//  GRNoParticipateChippedCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/9.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRNoParticipateChippedCell.h"

@implementation GRNoParticipateChippedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = GRColor(240, 240, 240);
        //背景 view
        UIView *background = [[UIView alloc] init];
        [self.contentView addSubview:background];
        background.backgroundColor = [UIColor whiteColor];
        
        //设置显示的文字
        UILabel *top = [[UILabel alloc] init];
        [background addSubview:top];
        top.text = @"您当前未参与合买";
        top.textColor = [UIColor colorWithHexString:@"#666666"];
        top.font = [UIFont systemFontOfSize:15];
        top.textAlignment = NSTextAlignmentCenter;
        
        UILabel *bottom = [[UILabel alloc] init];
        [background addSubview:bottom];
        bottom.text = @"选中持仓达人即可参与购买";
        bottom.textColor = [UIColor colorWithHexString:@"#666666"];
        bottom.font = [UIFont systemFontOfSize:15];
        bottom.textAlignment = NSTextAlignmentCenter;
        
        //布局
        [background mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.right.equalTo(self.contentView).offset(-13);
            make.height.equalTo(@50);
        }];
        
        [top mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(background);
            make.bottom.equalTo(bottom.mas_top);
            make.height.equalTo(bottom.mas_height);
        }];
        
        [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(background);
            make.top.equalTo(top.mas_bottom);
            make.height.equalTo(top.mas_height);
        }];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRNoParticipateChippedCell";
    GRNoParticipateChippedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRNoParticipateChippedCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
