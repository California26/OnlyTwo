//
//  GRHistoryListCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRHistoryListCell.h"

@interface GRHistoryListCell ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *priceLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *exitPriceLabel;
@property (nonatomic, weak) UILabel *lossLabel;
@property (nonatomic, weak) UILabel *profitLabel;
@property (nonatomic, weak) UILabel *rateLabel;

@end

@implementation GRHistoryListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //标题
        UILabel *title = [[UILabel alloc] init];
        self.titleLabel = title;
        [self.contentView addSubview:title];
        title.textColor = [UIColor colorWithHexString:@"#333333"];
        title.font = [UIFont systemFontOfSize:12];
        title.text = @"哈贵银";
        
        //收益率
        UILabel *rate = [[UILabel alloc] init];
        self.rateLabel = rate;
        [self.contentView addSubview:rate];
        rate.textColor = [UIColor colorWithHexString:@"#d43c33"];
        rate.font = [UIFont systemFontOfSize:15];
        rate.text = @"收益率:107.31%";
        
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
        
        //平仓价
        UILabel *exitPrice = [[UILabel alloc] init];
        self.exitPriceLabel = exitPrice;
        [self.contentView addSubview:exitPrice];
        exitPrice.textColor = [UIColor colorWithHexString:@"#333333"];
        exitPrice.font = [UIFont systemFontOfSize:10];
        exitPrice.text = @"花费:3300.0";
        
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
        
        //下面的线
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:line];
        
        //布局
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.top.equalTo(self.contentView).offset(8);
        }];
        
        [rate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(25);
            make.top.equalTo(self.contentView).offset(34);
        }];
        
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-25);
            make.top.equalTo(self.contentView).offset(6);
        }];
        
        [price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(time);
            make.top.equalTo(time.mas_bottom).offset(10);
        }];
        
        [exitPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(time);
            make.top.equalTo(price.mas_bottom).offset(10);
        }];
        
        [profit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(time);
            make.top.equalTo(exitPrice.mas_bottom).offset(10);
        }];
        
        [loss mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(profit.mas_centerY);
            make.left.equalTo(self.contentView).offset(25);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.height.equalTo(@1);
            make.bottom.equalTo(self.contentView);
        }];
        
    }
    return self;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRUnderWayCell";
    GRHistoryListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRHistoryListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
