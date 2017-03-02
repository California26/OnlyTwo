//
//  GRPropertyAssetsCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/10.
//  Copyright © 2017年 Jack. All rights reserved.
//  账户净资产

#import "GRPropertyAssetsCell.h"
#import "GRNetAssetsModel.h"            ///资产明细模型

@interface GRPropertyAssetsCell ()

@property (nonatomic, weak) UILabel *netAssetLabel;         ///净资产
@property (nonatomic, weak) UILabel *profitLabel;           ///持仓盈亏
@property (nonatomic, weak) UILabel *costLabel;             ///建仓成本
@property (nonatomic, weak) UILabel *availableLabel;        ///可用资金

@end

@implementation GRPropertyAssetsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //账户净资产
        UILabel *netAssest = [[UILabel alloc] init];
        [self.contentView addSubview:netAssest];
        netAssest.textColor = [UIColor colorWithHexString:@"#d43c33"];
        netAssest.font = [UIFont systemFontOfSize:20];
        self.netAssetLabel = netAssest;
        netAssest.text = @"0.00";
        
        UILabel *property = [[UILabel alloc] init];
        [self.contentView addSubview:property];
        property.textColor = [UIColor colorWithHexString:@"#333333"];
        property.font = [UIFont systemFontOfSize:17];
        property.text = @"账户净资产";
        
        //等号
        UILabel *equal = [[UILabel alloc] init];
        [self.contentView addSubview:equal];
        equal.textColor = [UIColor colorWithHexString:@"#333333"];
        equal.text = @"=";
        equal.font = [UIFont systemFontOfSize:25];
        
        //持仓盈亏
        UILabel *profit = [[UILabel alloc] init];
        [self.contentView addSubview:profit];
        profit.textColor = [UIColor colorWithHexString:@"#333333"];
        profit.font = [UIFont systemFontOfSize:14];
        profit.text = @"持仓盈亏";
        
        UILabel *profitLoss = [[UILabel alloc] init];
        [self.contentView addSubview:profitLoss];
        profitLoss.textColor = [UIColor colorWithHexString:@"#333333"];
        profitLoss.font = [UIFont systemFontOfSize:14];
        self.profitLabel = profitLoss;
        profitLoss.text = @"0.00";
        
        //加号
        UILabel *plus = [[UILabel alloc] init];
        [self.contentView addSubview:plus];
        plus.font = [UIFont systemFontOfSize:20];
        plus.textColor = [UIColor colorWithHexString:@"#333333"];
        plus.text = @"＋";
        
        //建仓成本
        UILabel *build = [[UILabel alloc] init];
        [self.contentView addSubview:build];
        build.textColor = [UIColor colorWithHexString:@"#333333"];
        build.font = [UIFont systemFontOfSize:14];
        build.text = @"建仓成本";
        
        UILabel *cost = [[UILabel alloc] init];
        [self.contentView addSubview:cost];
        cost.textColor = [UIColor colorWithHexString:@"#333333"];
        cost.font = [UIFont systemFontOfSize:14];
        self.costLabel = cost;
        cost.text = @"0.00";
        
        //加号
        UILabel *plus1 = [[UILabel alloc] init];
        [self.contentView addSubview:plus1];
        plus1.font = [UIFont systemFontOfSize:20];
        plus1.textColor = [UIColor colorWithHexString:@"#333333"];
        plus1.text = @"＋";
        
        //可用资金
        UILabel *available = [[UILabel alloc] init];
        [self.contentView addSubview:available];
        available.textColor = [UIColor colorWithHexString:@"#333333"];
        available.font = [UIFont systemFontOfSize:14];
        available.text = @"可用资金";
        
        UILabel *cash = [[UILabel alloc] init];
        [self.contentView addSubview:cash];
        cash.textColor = [UIColor colorWithHexString:@"#333333"];
        cash.font = [UIFont systemFontOfSize:14];
        self.availableLabel = cash;
        cash.text = @"0.00";
        
        //抵用券
        UIButton *ticket = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:ticket];
        [ticket setTitle:@"抵金券" forState:UIControlStateNormal];
        [ticket setImage:[UIImage imageNamed:@"Mine_Ticket"] forState:UIControlStateNormal];
        [ticket setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        ticket.titleLabel.font = [UIFont systemFontOfSize:17];
        [ticket addTarget:self action:@selector(ticketClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //充值
        UIButton *recharge = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:recharge];
        [recharge setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [recharge setTitle:@"充值" forState:UIControlStateNormal];
        recharge.backgroundColor = [UIColor colorWithHexString:@"#d43c33"];
        recharge.layer.cornerRadius = 8;
        recharge.layer.masksToBounds = YES;
        recharge.titleLabel.font = [UIFont systemFontOfSize:16];
        [recharge addTarget:self action:@selector(rechargeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //提现
        UIButton *withdraw = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:withdraw];
        [withdraw setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [withdraw setTitle:@"提现" forState:UIControlStateNormal];
        withdraw.backgroundColor = [UIColor colorWithHexString:@"#3d7aeb"];
        withdraw.layer.cornerRadius = 8;
        withdraw.layer.masksToBounds = YES;
        withdraw.titleLabel.font = [UIFont systemFontOfSize:16];
        [withdraw addTarget:self action:@selector(withdrawClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //布局
        [netAssest mas_makeConstraints:^(MASConstraintMaker *make) {
            if (iPhone5) {
                make.left.equalTo(self.contentView).offset(15);
            }else{
                make.left.equalTo(self.contentView).offset(35);
            }
            make.top.equalTo(self.contentView).offset(10);
        }];
        [property mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.top.equalTo(netAssest.mas_bottom).offset(10);
        }];
        
        [equal mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.top.equalTo(property.mas_bottom).offset(10);
        }];
        
        [recharge mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(42);
            make.bottom.equalTo(self.contentView).offset(-20);
            make.right.equalTo(withdraw.mas_left).offset(-10);
            make.height.equalTo(@45);
            make.width.equalTo(withdraw.mas_width);
        }];
        
        [withdraw mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(recharge.mas_right).offset(10);
            make.bottom.equalTo(self.contentView).offset(-20);
            make.right.equalTo(self.contentView).offset(-42);
            make.height.equalTo(@45);
            make.width.equalTo(recharge.mas_width);
        }];
        
        [profit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(equal.mas_right).offset(10);
            make.bottom.equalTo(recharge.mas_top).offset(-20);
        }];
        
        [profitLoss mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(property.mas_bottom).offset(10);
            make.centerX.equalTo(profit.mas_centerX);
        }];
        
        [plus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(equal.mas_centerY);
            make.left.equalTo(profit.mas_right).offset(10);
        }];
        
        [build mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(plus.mas_right).offset(10);
            make.bottom.equalTo(recharge.mas_top).offset(-20);
        }];
        [cost mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(property.mas_bottom).offset(10);
            make.centerX.equalTo(build.mas_centerX);
        }];
        
        [plus1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(equal.mas_centerY);
            make.left.equalTo(build.mas_right).offset(10);
        }];
        
        [available mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(plus1.mas_right).offset(10);
            make.bottom.equalTo(recharge.mas_top).offset(-20);
        }];
        [cash mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(property.mas_bottom).offset(10);
            make.centerX.equalTo(available.mas_centerX);
        }];
        
        [ticket mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-13);
            make.top.equalTo(self.contentView).offset(10);
            make.width.equalTo(@90);
            make.height.equalTo(@30);
        }];
    }
    return self;
}

#pragma mark - event response
- (void)rechargeClick:(UIButton *)btn{
    if (self.rechargeBlcok) {
        self.rechargeBlcok();
    }
}

- (void)withdrawClick:(UIButton *)btn{
    if (self.withdrawBlock) {
        self.withdrawBlock();
    }
}

- (void)ticketClick:(UIButton *)btn{
    if (self.ticketBlock) {
        self.ticketBlock();
    }
}

#pragma mark - setter and getter 
- (void)setNetAssets:(GRNetAssetsModel *)netAssets{
    _netAssets = netAssets;
    
    self.netAssetLabel.text = netAssets.netAsset;
    self.profitLabel.text = [NSString stringWithFormat:@"%.2f",netAssets.profitLoss.floatValue];
    self.costLabel.text = netAssets.buildCost;
    self.availableLabel.text = [NSString stringWithFormat:@"%.2f",netAssets.available.floatValue];;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRPropertyAssetsCell";
    GRPropertyAssetsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRPropertyAssetsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
