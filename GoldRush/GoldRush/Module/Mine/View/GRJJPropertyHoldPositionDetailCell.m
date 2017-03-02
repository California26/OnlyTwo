//
//  GRJJPropertyHoldPositionDetailCell.m
//  GoldRush
//
//  Created by Jack on 2017/2/8.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRJJPropertyHoldPositionDetailCell.h"


#define Width ((K_Screen_Width - 26 - 30) * 0.25)

#import "GRJJPropertyHoldPositionDetailCell.h"
#import "UIButton+GRButtonLayout.h"             ///UIButton 布局
#import "GRJJHoldPositionModel.h"                ///数据模型

@interface GRJJPropertyHoldPositionDetailCell ()

@property (nonatomic, weak) UILabel *riseLabel;                 ///是涨是跌

@property (nonatomic, weak) UILabel *productLabel;              ///产品名字
@property (nonatomic, weak) UILabel *buildLabel;                ///建仓价

@property (nonatomic, weak) UIButton *stopProfitBtn;            ///止盈止损按钮
@property (nonatomic, weak) UIButton *holdPositionBtn;          ///持仓按钮
@property (nonatomic, weak) UIButton *closeButton;               ///平仓

@property (nonatomic, weak) UILabel *rateLabel;                 ///盈利率
@property (nonatomic, weak) UILabel *newestLabel;               ///最新价

@end

@implementation GRJJPropertyHoldPositionDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //涨
        UILabel *rise = [[UILabel alloc] init];
        [self.contentView addSubview:rise];
        self.riseLabel = rise;
        rise.textColor = [UIColor whiteColor];
        rise.font = [UIFont systemFontOfSize:15];
        rise.layer.cornerRadius = 10;
        rise.layer.masksToBounds = YES;
        rise.textAlignment = NSTextAlignmentCenter;
        
        //产品名字
        UILabel *product = [[UILabel alloc] init];
        self.productLabel = product;
        [self.contentView addSubview:product];
        
        //建仓价
        UILabel *build = [[UILabel alloc] init];
        [self.contentView addSubview:build];
        build.textColor = [UIColor colorWithHexString:@"#666666"];
        build.font = [UIFont systemFontOfSize:12];
        self.buildLabel = build;
        
        //设置止盈止损按钮
        UIButton *stop = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:stop];
        self.stopProfitBtn = stop;
        if (iPhone5) {
            stop.titleLabel.font = [UIFont systemFontOfSize:9];
            stop.imageRect = CGRectMake(9, 0, Width * 0.7, Width * 0.7);
            stop.titleRect = CGRectMake(0, Width * 0.7, Width, 24);
        }else if (iPhone6){
            stop.titleLabel.font = [UIFont systemFontOfSize:11];
            stop.imageRect = CGRectMake(11, 0, Width * 0.7, Width * 0.7);
            stop.titleRect = CGRectMake(0, Width * 0.7, Width, 24);
        } else{
            stop.titleLabel.font = [UIFont systemFontOfSize:12];
            stop.imageRect = CGRectMake(12, 0, Width * 0.7, Width * 0.7);
            stop.titleRect = CGRectMake(0, Width * 0.7, Width, 24);
        }
        stop.titleLabel.textAlignment = NSTextAlignmentCenter;
        stop.imageView.contentMode = UIViewContentModeCenter;
        stop.adjustsImageWhenHighlighted = NO;
        [stop setTitle:@"已设置止盈止损" forState:UIControlStateNormal];
        [stop setTitle:@"未设置止盈止损" forState:UIControlStateSelected];
        [stop setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [stop setImage:[UIImage imageNamed:@"Mine_Have_Setting"] forState:UIControlStateNormal];
        [stop setImage:[UIImage imageNamed:@"Mine_Setting"] forState:UIControlStateSelected];
        [stop addTarget:self action:@selector(stopClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //设置持仓过夜按钮
        UIButton *holdPosition = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:holdPosition];
        self.holdPositionBtn = holdPosition;
        if (iPhone5) {
            holdPosition.titleLabel.font = [UIFont systemFontOfSize:9];
            holdPosition.imageRect = CGRectMake(9, 0, Width * 0.7, Width * 0.7);
            holdPosition.titleRect = CGRectMake(0, Width * 0.7, Width, 24);
        }else if (iPhone6){
            holdPosition.titleLabel.font = [UIFont systemFontOfSize:11];
            holdPosition.imageRect = CGRectMake(11, 0, Width * 0.7, Width * 0.7);
            holdPosition.titleRect = CGRectMake(0, Width * 0.7, Width, 24);
        } else{
            holdPosition.titleLabel.font = [UIFont systemFontOfSize:12];
            holdPosition.imageRect = CGRectMake(12, 0, Width * 0.7, Width * 0.7);
            holdPosition.titleRect = CGRectMake(0, Width * 0.7, Width, 24);
        }
        holdPosition.titleLabel.textAlignment = NSTextAlignmentCenter;
        holdPosition.imageView.contentMode = UIViewContentModeCenter;
        [holdPosition setTitle:@"已持仓过夜" forState:UIControlStateNormal];
        [holdPosition setTitle:@"未持仓过夜" forState:UIControlStateSelected];
        [holdPosition setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [holdPosition setImage:[UIImage imageNamed:@"Mine_Have_Hold_Position"] forState:UIControlStateNormal];
        [holdPosition setImage:[UIImage imageNamed:@"Mine_Hold_Position"] forState:UIControlStateSelected];
        holdPosition.adjustsImageWhenHighlighted = NO;
//        [holdPosition addTarget:self action:@selector(holdPositionClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //盈利率
        UILabel *rate = [[UILabel alloc] init];
        [self.contentView addSubview:rate];
        self.rateLabel = rate;
        rate.textColor = [UIColor colorWithHexString:@"#f1496c"];
        if (iPhone5) {
            rate.font = [UIFont systemFontOfSize:17];
        }else{
            rate.font = [UIFont systemFontOfSize:20];
        }
        rate.textAlignment = NSTextAlignmentCenter;
        
        //盈利金额
        UILabel *profit = [[UILabel alloc] init];
        [self.contentView addSubview:profit];
        profit.text = @"盈亏金额";
        profit.textColor = [UIColor colorWithHexString:@"#666666"];
        if (iPhone5) {
            profit.font = [UIFont systemFontOfSize:9];
        }else{
            profit.font = [UIFont systemFontOfSize:12];
        }
        profit.textAlignment = NSTextAlignmentCenter;
        
        //平仓按钮
        UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:close];
        [close setTitle:@"平仓" forState:UIControlStateNormal];
        close.backgroundColor = [UIColor colorWithHexString:@"#f39800"];
        close.titleLabel.font = [UIFont systemFontOfSize:12];
        close.layer.masksToBounds = YES;
        close.layer.cornerRadius = 8;
        [close addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        self.closeButton = close;
        
        //最新价
        UILabel *newPrice = [[UILabel alloc] init];
        [self.contentView addSubview:newPrice];
        newPrice.textColor = [UIColor colorWithHexString:@"#666666"];
        if (iPhone5) {
            newPrice.font = [UIFont systemFontOfSize:8];
        }else{
            newPrice.font = [UIFont systemFontOfSize:11.5];
        }
        self.newestLabel = newPrice;
        newPrice.textAlignment = NSTextAlignmentCenter;
        
        //布局
        [rise mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.top.equalTo(self.contentView).offset(10);
            make.width.equalTo(@45);
            make.height.equalTo(@30);
        }];
        
        [product mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rise.mas_right).offset(10);
            make.centerY.equalTo(rise.mas_centerY);
        }];
        
        [build mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(rise.mas_centerY);
            make.left.equalTo(product.mas_right).offset(20);
        }];
        
        [stop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.top.equalTo(rise.mas_bottom).offset(13);
            make.width.height.equalTo(@(Width));
        }];
        
        [holdPosition mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(stop.mas_right).offset(13);
            make.top.equalTo(rise.mas_bottom).offset(13);
            make.width.height.equalTo(@(Width));
        }];
        
        [profit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView).offset(-10);
            make.left.equalTo(holdPosition.mas_right).offset(10);
            make.width.equalTo(@(Width));
        }];
        
        [rate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(profit.mas_centerX);
            make.bottom.equalTo(profit.mas_top).offset(-13);
            make.width.equalTo(@(Width));
        }];
        
        [newPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-13);
            make.bottom.equalTo(self.contentView).offset(-10);
            make.width.equalTo(@(Width));
        }];
        
        [close mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(newPrice.mas_centerX);
            make.bottom.equalTo(newPrice.mas_top).offset(-13);
            make.width.equalTo(@60);
        }];
        
    }
    return self;
}

#pragma mark - event response
- (void)stopClick:(UIButton *)btn{
    
    if (self.stopProfitLoss) {
        self.stopProfitLoss(btn);
    }
    
}

- (void)holdPositionClick:(UIButton *)btn{
    if (self.holdPosition) {
        self.holdPosition();
    }
}

- (void)closeClick:(UIButton *)btn{
    if (self.closePosition) {
        self.closePosition();
    }
}

#pragma mark - setter and getter
- (void)setHoldPositionModel:(GRJJHoldPositionModel *)holdPositionModel{
    _holdPositionModel = holdPositionModel;
    
    if (holdPositionModel.tradeType == 2) {        //跌
        self.riseLabel.backgroundColor = [UIColor colorWithHexString:@"#09cb67"];
        self.riseLabel.text = @"跌";
    }else{      //涨
        self.riseLabel.backgroundColor = [UIColor colorWithHexString:@"#f1496c"];
        self.riseLabel.text = @"涨";
    }
    self.productLabel.text = holdPositionModel.productName;
    self.buildLabel.text = [NSString stringWithFormat:@"建仓价%.2f",holdPositionModel.buildPositionPrice.floatValue];
    
    //盈利率
    if (holdPositionModel.profitOrLoss.floatValue >= 0) {
        self.rateLabel.textColor = [UIColor colorWithHexString:@"#f1496c"];
    }else{
        self.rateLabel.textColor = [UIColor colorWithHexString:@"#09cb67"];
    }
    self.rateLabel.text = [NSString stringWithFormat:@"%.2f",holdPositionModel.profitOrLoss.floatValue];
    
    self.newestLabel.text = [NSString stringWithFormat:@"最新价%.2f",holdPositionModel.currentprice.floatValue];
    
    if ([holdPositionModel.stopLoss isEqualToString:@"0"] && [holdPositionModel.targetProfit isEqualToString:@"0"]) {
        self.stopProfitBtn.selected = YES;
    }else{
        self.stopProfitBtn.selected = NO;
    }
    
    if ([holdPositionModel.overnightTypeName isEqualToString:@"不过夜"]) {
        self.holdPositionBtn.selected = YES;
    }else{
        self.holdPositionBtn.selected = NO;
    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRJJPropertyHoldPositionDetailCell";
    GRJJPropertyHoldPositionDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRJJPropertyHoldPositionDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setTag:(NSInteger)tag{
    self.closeButton.tag = tag;
    self.stopProfitBtn.tag = tag;
}


@end
