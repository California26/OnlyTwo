//
//  GRAnalystDetailCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRAnalystDetailCell.h"

@interface GRAnalystDetailCell ()

///头像
@property (nonatomic, weak) UIImageView *headerImage;
///用户名
@property (nonatomic, weak) UILabel *nameLabel;

///上周收益
@property (nonatomic, weak) UILabel *profitLabel;
///上周好评数
@property (nonatomic, weak) UILabel *likeCountLabel;
///剩余名额
@property (nonatomic, weak) UILabel *numberLabel;

@end

@implementation GRAnalystDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //添加子控件
        //头像
        UIImageView *header = [[UIImageView alloc] init];
        header.backgroundColor = [UIColor blueColor];
        self.headerImage = header;
        header.image = [UIImage imageNamed:@"Chipped_Analyst_Header_default.jpg"];
        header.layer.cornerRadius = 30;
        header.layer.masksToBounds = YES;
        [self.contentView addSubview:header];
        
        //名字
        UILabel *name = [[UILabel alloc] init];
        self.nameLabel = name;
        name.text = @"郑成功";
        name.textColor = [UIColor colorWithHexString:@"#666666"];
        name.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:name];
        
        //上周收益
        UILabel *lastWeekProfit = [[UILabel alloc] init];
        lastWeekProfit.text = @"上周收益";
        lastWeekProfit.textColor = [UIColor colorWithHexString:@"#333333"];
        lastWeekProfit.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:lastWeekProfit];
        
        UILabel *profit = [[UILabel alloc] init];
        self.profitLabel = profit;
        profit.text = @"66.62%";
        profit.textColor = [UIColor colorWithHexString:@"#f1496c"];
//        profit.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:profit];
        
        //上周好评数
        UILabel *lastWeekLike = [[UILabel alloc] init];
        lastWeekLike.text = @"上周好评数";
        lastWeekLike.textColor = [UIColor colorWithHexString:@"#333333"];
        lastWeekLike.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:lastWeekLike];
        
        UILabel *like = [[UILabel alloc] init];
        self.likeCountLabel = like;
        like.text = @"427个";
        like.textColor = [UIColor colorWithHexString:@"#f1496c"];
//        like.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:like];
        
        //剩余名额
        UILabel *number = [[UILabel alloc] init];
        number.text = @"剩余名额";
        number.textColor = [UIColor colorWithHexString:@"#333333"];
        number.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:number];
        
        UILabel *count = [[UILabel alloc] init];
        self.numberLabel = count;
        count.text = @"87个";
        count.textColor = [UIColor colorWithHexString:@"#f1496c"];
//        count.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:count];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.and.left.and.bottom.equalTo(self.contentView);
            make.height.equalTo(@1);
        }];
        
        //布局
        [header mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(13);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.and.height.equalTo(@60);
        }];
        
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(header.mas_right).offset(23);
            make.top.equalTo(self.contentView.mas_top).offset(13);
        }];
        
        [lastWeekProfit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(header.mas_right).offset(13);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        }];
        
        [profit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(header.mas_right).offset(13);
            make.bottom.equalTo(lastWeekProfit.mas_top).offset(-6);
        }];
        
        [number mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
        }];
        
        [count mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(number);
            make.bottom.equalTo(number.mas_top).offset(-5);
        }];
        
        [lastWeekLike mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
            make.left.equalTo(lastWeekProfit.mas_right).offset(60);
        }];
        
        [like mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lastWeekLike.mas_top).offset(-6);
            make.leftMargin.equalTo(lastWeekLike);
        }];
    }
    return self;
}

#pragma mark - evetn response



#pragma mark - setter and getter


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRAnalystDetailCell";
    GRAnalystDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRAnalystDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end
