//
//  GRChippedJoinPlanCell.m
//  GoldRush
//
//  Created by Jack on 2016/12/31.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRChippedJoinPlanCell.h"
#import "GRJoinPlan.h"

@interface GRChippedJoinPlanCell ()

///头像
@property (nonatomic, weak) UIImageView *headerImage;
///用户名
@property (nonatomic, weak) UILabel *nameLabel;
///资金门槛
@property (nonatomic, weak) UILabel *warnLabel;
///上周收益
@property (nonatomic, weak) UILabel *profitLabel;
///上周好评数
@property (nonatomic, weak) UILabel *likeCountLabel;
///剩余名额
@property (nonatomic, weak) UILabel *numberLabel;

@end

@implementation GRChippedJoinPlanCell


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
        name.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:name];
        
        //提醒
        UILabel *warn = [[UILabel alloc] init];
        self.warnLabel = warn;
        warn.layer.cornerRadius = 8;
        warn.layer.masksToBounds = YES;
        warn.backgroundColor = [UIColor colorWithHexString:@"#f19149"];
        [self.contentView addSubview:warn];
        warn.text = @"资金门槛5千";
        warn.textColor = [UIColor whiteColor];
        warn.font = [UIFont systemFontOfSize:11];
        warn.textAlignment = NSTextAlignmentCenter;
        
        //加入计划
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"加入计划" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor colorWithHexString:@"#f1496c"];
        btn.layer.cornerRadius = 8;
        btn.layer.masksToBounds = YES;
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        [btn addTarget:self action:@selector(joinPlanClick:) forControlEvents:UIControlEventTouchUpInside];
        
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
        [self.contentView addSubview:count];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = GRColor(240, 240, 240);
        [self.contentView addSubview:line];
        
        //布局
        [header mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(13);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.and.height.equalTo(@60);
        }];
        
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(header.mas_right).offset(23);
            make.top.equalTo(self.contentView.mas_top).offset(14);
        }];
        
        [warn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(name.mas_right).offset(20);
            make.top.equalTo(self.contentView.mas_top).offset(13);
            make.width.equalTo(@70);
            make.height.equalTo(@18);
        }];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-13);
            make.top.equalTo(self.contentView.mas_top).offset(13);
            make.width.equalTo(@60);
            make.height.equalTo(@18);
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
            if (iPhone5) {
                make.left.equalTo(lastWeekProfit.mas_right).offset(40);
            }else{
                make.left.equalTo(lastWeekProfit.mas_right).offset(60);
            }
        }];
        
        [like mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lastWeekLike.mas_top).offset(-6);
            make.leftMargin.equalTo(lastWeekLike);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.and.left.equalTo(self.contentView);
            make.height.equalTo(@10);
            make.top.equalTo(lastWeekLike.mas_bottom).offset(3);
        }];
    }
    return self;
}

#pragma mark - evetn response
- (void)joinPlanClick:(UIButton *)btn{
    if (self.joinPlanBlock) {
        self.joinPlanBlock();
    }
}

#pragma mark - setter and getter
- (void)setJoinPlanModel:(GRJoinPlan *)joinPlanModel{
    _joinPlanModel = joinPlanModel;
    
    self.headerImage.image = [UIImage imageNamed:joinPlanModel.header];
    self.nameLabel.text = joinPlanModel.name;
    self.warnLabel.text = joinPlanModel.warn;
    self.profitLabel.text = joinPlanModel.profit;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%@个",joinPlanModel.like];
    self.numberLabel.text = [NSString stringWithFormat:@"%@个",joinPlanModel.number];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"joinPlanCell";
    GRChippedJoinPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRChippedJoinPlanCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
