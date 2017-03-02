//
//  GRTradeRiskCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRTradeRiskCell.h"

@implementation GRTradeRiskCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *tip1 = [[UILabel alloc] init];
        [self.contentView addSubview:tip1];
        tip1.textColor = [UIColor colorWithHexString:@"#666666"];
        tip1.font = [UIFont systemFontOfSize:11];
        tip1.textAlignment = NSTextAlignmentCenter;
        tip1.text = @"交易计划历史收益不代表未来承诺收益";
        
        UILabel *tip2 = [[UILabel alloc] init];
        [self.contentView addSubview:tip2];
        tip2.textColor = [UIColor colorWithHexString:@"#666666"];
        tip2.font = [UIFont systemFontOfSize:11];
        tip2.textAlignment = NSTextAlignmentCenter;
        tip2.text = @"市场有风险,投资需谨慎";
        
        [tip1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.contentView);
            make.bottom.equalTo(tip2.mas_top);
            make.height.equalTo(tip2.mas_height);
        }];
        [tip2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self.contentView);
            make.top.equalTo(tip1.mas_bottom);
            make.height.equalTo(tip1.mas_height);
        }];
        
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRTradeRiskCell";
    GRTradeRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRTradeRiskCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
