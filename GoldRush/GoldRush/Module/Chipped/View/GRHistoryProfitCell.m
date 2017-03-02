//
//  GRHistoryProfitCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/10.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRHistoryProfitCell.h"

@interface GRHistoryProfitCell ()

@property (nonatomic, weak) UILabel *profitLabel;       ///单笔最高盈利
@property (nonatomic, weak) UILabel *accuracyLabel;     ///总准确率

@end

@implementation GRHistoryProfitCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //单笔最高盈利
        UILabel *max = [[UILabel alloc] init];
        [self.contentView addSubview:max];
        max.text = @"单笔最高盈利";
        max.textColor = [UIColor colorWithHexString:@"#333333"];
        max.font = [UIFont systemFontOfSize:15];
        
        //盈利
        UILabel *profit = [[UILabel alloc] init];
        [self.contentView addSubview:profit];
        self.profitLabel = profit;
        NSString *text = @"3000元";
        NSString *behind = [text substringFromIndex:text.length - 1];
        NSString *ahead = [text substringToIndex:text.length - 1];
        NSDictionary *dict1 = @{NSFontAttributeName : [UIFont systemFontOfSize:20] , NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#d43c33"]};
        NSDictionary *dict2 = @{NSFontAttributeName : [UIFont systemFontOfSize:15] , NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#333333"]};
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:ahead attributes:dict1];
        NSMutableAttributedString *str2= [[NSMutableAttributedString alloc] initWithString:behind attributes:dict2];
        [str1 appendAttributedString:str2];
        profit.attributedText = str1;
        
        //总准确率
        UILabel *accuracy = [[UILabel alloc] init];
        [self.contentView addSubview:accuracy];
        accuracy.textColor = [UIColor colorWithHexString:@"#333333"];
        accuracy.font = [UIFont systemFontOfSize:15];
        accuracy.text = @"总准确率";
        
        //准确率
        UILabel *rate = [[UILabel alloc] init];
        [self.contentView addSubview:rate];
        rate.textColor = [UIColor colorWithHexString:@"#d43c33"];
        rate.font = [UIFont systemFontOfSize:20];
        self.accuracyLabel = rate;
        rate.text = @"49.00%";
        
        //线
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:line];
        
        //左边的图片
        UIImageView *left = [[UIImageView alloc] init];
        [self.contentView addSubview:left];
        left.contentMode = UIViewContentModeCenter;
        left.image = [UIImage imageNamed:@"chipped_High_win"];
        
        //右边的图片
        UIImageView *right = [[UIImageView alloc] init];
        [self.contentView addSubview:right];
        right.contentMode = UIViewContentModeCenter;
        right.image = [UIImage imageNamed:@"chipped_Right"];
        
        //布局
        [left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(33);
            make.top.equalTo(self.contentView);
            make.width.height.equalTo(@59);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.contentView).offset(10);
            make.height.equalTo(@40);
            make.width.equalTo(@1);
        }];
        
        [max mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(line.mas_left).offset(-20);
            make.bottom.equalTo(self).offset(-10);
        }];
        
        [profit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(max.mas_centerX);
            make.bottom.equalTo(max.mas_top);
        }];
        
        [right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line.mas_right).offset(20);
            make.top.equalTo(self.contentView);
            make.width.height.equalTo(@59);
        }];
        
        [accuracy mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(right.mas_right);
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
        
        [rate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(accuracy.mas_centerX);
            make.bottom.equalTo(accuracy.mas_top);
        }];
        
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRHistoryProfitCell";
    GRHistoryProfitCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRHistoryProfitCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
