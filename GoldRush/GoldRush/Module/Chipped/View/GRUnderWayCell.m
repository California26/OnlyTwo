//
//  GRUnderWayCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRUnderWayCell.h"

@interface GRUnderWayCell ()

@property (nonatomic, weak) UILabel *priceLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *costLabel;
@property (nonatomic, weak) UILabel *lossLabel;
@property (nonatomic, weak) UILabel *profitLabel;

@end

@implementation GRUnderWayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //建仓价
        UILabel *price = [[UILabel alloc] init];
        self.priceLabel = price;
        [self.contentView addSubview:price];
        price.textColor = [UIColor colorWithHexString:@"#333333"];
        price.font = [UIFont systemFontOfSize:10];
        price.text = @"建仓价:3802.0";
        
        //建仓时间
        UILabel *time = [[UILabel alloc] init];
        self.timeLabel = time;
        [self.contentView addSubview:time];
        time.textColor = [UIColor colorWithHexString:@"#333333"];
        time.font = [UIFont systemFontOfSize:10];
        time.text = @"建仓时间:2016.12 19:57";
        
        //花费
        UILabel *cost = [[UILabel alloc] init];
        self.costLabel = cost;
        [self.contentView addSubview:cost];
        cost.textColor = [UIColor colorWithHexString:@"#333333"];
        cost.font = [UIFont systemFontOfSize:10];
        cost.text = @"花费:3300.0";
        
        //止损
        UILabel *loss = [[UILabel alloc] init];
        self.lossLabel = loss;
        [self.contentView addSubview:loss];
        loss.textColor = [UIColor colorWithHexString:@"#333333"];
        loss.font = [UIFont systemFontOfSize:10];
        loss.text = @"止损:3702.0";
        
        //止盈
        UILabel *profit = [[UILabel alloc] init];
        self.profitLabel = profit;
        [self.contentView addSubview:profit];
        profit.textColor = [UIColor colorWithHexString:@"#333333"];
        profit.font = [UIFont systemFontOfSize:10];
        profit.text = @"止盈:3300.0";
        
        //布局
        [price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(25);
            make.top.equalTo(self.contentView).offset(5);
        }];
        
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-25);
            make.top.equalTo(self.contentView).offset(5);
        }];
        
        [cost mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(25);
            make.top.equalTo(price.mas_bottom).offset(10);
        }];
        
        [loss mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(25);
            make.top.equalTo(cost.mas_bottom).offset(10);
        }];
        
        [profit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(loss.mas_centerY);
            make.leftMargin.equalTo(time);
        }];

    }
    return self;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRUnderWayCell";
    GRUnderWayCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRUnderWayCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
