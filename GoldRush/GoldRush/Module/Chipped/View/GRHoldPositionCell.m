//
//  GRHoldPositionCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/9.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRHoldPositionCell.h"

@interface GRHoldPositionCell ()

@property (nonatomic, weak) UIImageView *iconImageView;         ///头像
@property (nonatomic, weak) UILabel *nameLabel;                 ///姓名
@property (nonatomic, weak) UIButton *fellowBtn;                ///关注按钮

@end

@implementation GRHoldPositionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //头像
        UIImageView *icon = [[UIImageView alloc] init];
        icon.layer.masksToBounds = YES;
        icon.layer.cornerRadius = 20;
        [self.contentView addSubview:icon];
        self.iconImageView = icon;
        icon.backgroundColor = [UIColor orangeColor];
        
        //名字
        UILabel *name = [[UILabel alloc] init];
        [self.contentView addSubview:name];
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        name.font = [UIFont systemFontOfSize:15];
        self.nameLabel = name;
        name.text = @"全民小道";
        
        //按钮取消关注
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        btn.backgroundColor = [UIColor colorWithHexString:@"#f39800"];
        [btn setTitle:@"取消关注" forState:UIControlStateNormal];
        [btn setTitle:@"＋关注" forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.fellowBtn = btn;
        [btn addTarget:self action:@selector(fellowClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //线
        UIView *horizontalTopline = [[UIView alloc] init];
        [self.contentView addSubview:horizontalTopline];
        horizontalTopline.backgroundColor = [UIColor lightGrayColor];
        
        //产品
        UILabel *product = [[UILabel alloc] init];
        [self.contentView addSubview:product];
        product.textColor = [UIColor colorWithHexString:@"#333333"];
        product.font = [UIFont systemFontOfSize:15];
        product.text = @"哈贵银";
        
        //买涨按钮
        UIButton *buyRise = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:buyRise];
        buyRise.layer.cornerRadius = 5;
        buyRise.layer.masksToBounds = YES;
        [buyRise setTitle:@"买涨" forState:UIControlStateNormal];
        buyRise.backgroundColor = [UIColor colorWithHexString:@"#f1496c"];
        buyRise.titleLabel.font = [UIFont systemFontOfSize:15];
        [buyRise setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buyRise addTarget:self action:@selector(buyRiseClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //建仓价格
        UILabel *build = [[UILabel alloc] init];
        [self.contentView addSubview:build];
        build.text = @"建仓价格";
        build.textColor = [UIColor colorWithHexString:@"#666666"];
        build.font = [UIFont systemFontOfSize:14];
        
        UILabel *buildPrice = [[UILabel alloc] init];
        [self.contentView addSubview:buildPrice];
        buildPrice.textColor = [UIColor colorWithHexString:@"#666666"];
        buildPrice.font = [UIFont systemFontOfSize:14];
        buildPrice.text = @"3619.0";
        
        //建仓时间
        UILabel *buildTime = [[UILabel alloc] init];
        [self.contentView addSubview:buildTime];
        buildTime.text = @"建仓时间";
        buildTime.textColor = [UIColor colorWithHexString:@"#666666"];
        buildTime.font = [UIFont systemFontOfSize:14];
        
        UILabel *timeNum = [[UILabel alloc] init];
        [self.contentView addSubview:timeNum];
        timeNum.textColor = [UIColor colorWithHexString:@"#666666"];
        timeNum.font = [UIFont systemFontOfSize:14];
        timeNum.text = @"14:20";
        
        //现金花费
        UILabel *cash = [[UILabel alloc] init];
        [self.contentView addSubview:cash];
        cash.text = @"现金花费";
        cash.textColor = [UIColor colorWithHexString:@"#666666"];
        cash.font = [UIFont systemFontOfSize:14];
        
        UILabel *cost = [[UILabel alloc] init];
        [self.contentView addSubview:cost];
        cost.textColor = [UIColor colorWithHexString:@"#666666"];
        cost.font = [UIFont systemFontOfSize:14];
        cost.text = @"200.0";
        
        //止盈
        UILabel *stop = [[UILabel alloc] init];
        [self.contentView addSubview:stop];
        stop.text = @"止盈";
        stop.textColor = [UIColor colorWithHexString:@"#666666"];
        stop.font = [UIFont systemFontOfSize:14];
        
        UILabel *profit = [[UILabel alloc] init];
        [self.contentView addSubview:profit];
        profit.textColor = [UIColor colorWithHexString:@"#666666"];
        profit.font = [UIFont systemFontOfSize:14];
        profit.text = @"3639.0";
        
        //止损
        UILabel *stopLoss = [[UILabel alloc] init];
        [self.contentView addSubview:stopLoss];
        stopLoss.text = @"止损";
        stopLoss.textColor = [UIColor colorWithHexString:@"#666666"];
        stopLoss.font = [UIFont systemFontOfSize:14];
        
        UILabel *loss = [[UILabel alloc] init];
        [self.contentView addSubview:loss];
        loss.textColor = [UIColor colorWithHexString:@"#666666"];
        loss.font = [UIFont systemFontOfSize:14];
        loss.text = @"3639.0";
        
        //竖线
        UIView *verticalTopLine = [[UIView alloc] init];
        verticalTopLine.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:verticalTopLine];
        
        UIView *verticalBottomLine = [[UIView alloc] init];
        verticalBottomLine.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:verticalBottomLine];
        
        //横线
        UIView *horizontalBottomline = [[UIView alloc] init];
        horizontalBottomline.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:horizontalBottomline];
        
        //参与合买按钮
        UIButton *chippedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:chippedBtn];
        [chippedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [chippedBtn setTitle:@"参与合买" forState:UIControlStateNormal];
        chippedBtn.layer.masksToBounds = YES;
        chippedBtn.layer.cornerRadius = 5;
        [chippedBtn addTarget:self action:@selector(chippedClick:) forControlEvents:UIControlEventTouchUpInside];
        chippedBtn.backgroundColor = [UIColor colorWithHexString:@"#d43c33"];
        
        //下部的灰色 view
        UIView *gray = [[UIView alloc] init];
        gray.backgroundColor = GRColor(240, 240, 240);
        [self.contentView addSubview:gray];
        
        //布局
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(19);
            make.top.equalTo(self.contentView).offset(5);
            make.width.height.equalTo(@40);
        }];
        
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon.mas_right).offset(10);
            make.topMargin.equalTo(icon);
        }];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(icon.mas_centerY);
            make.right.equalTo(self.contentView).offset(-13);
            make.height.equalTo(@20);
        }];
        
        [horizontalTopline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.height.equalTo(@1);
            make.top.equalTo(icon.mas_bottom).offset(5);
        }];
        
        [product mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.top.equalTo(horizontalTopline.mas_bottom).offset(8);
        }];
        
        [buyRise mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.top.equalTo(horizontalTopline.mas_bottom).offset(30);
            make.width.equalTo(@50);
            make.height.equalTo(@30);
        }];
        
        [verticalTopLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(horizontalTopline.mas_bottom).offset(30);
            make.width.equalTo(@1);
            make.height.equalTo(@30);
        }];
        
        [build mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(horizontalTopline.mas_bottom).offset(30);
            make.right.equalTo(verticalTopLine.mas_left).offset(-23);
        }];
        [buildPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(build);
            make.top.equalTo(build.mas_bottom);
        }];
        
        [buildTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(verticalTopLine.mas_right).offset(23);
            make.top.equalTo(horizontalTopline.mas_bottom).offset(30);
        }];
        [timeNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(buildTime);
            make.top.equalTo(buildTime.mas_bottom);
        }];
        
        [cash mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(build);
            make.top.equalTo(buildPrice.mas_bottom).offset(10);
        }];
        [cost mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(cash);
            make.top.equalTo(cash.mas_bottom);
        }];
        
        [stop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(cash);
            make.top.equalTo(cost.mas_bottom).offset(10);
        }];
        [profit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(stop);
            make.top.equalTo(stop.mas_bottom);
        }];
        
        [horizontalBottomline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(profit.mas_bottom).offset(10);
            make.height.equalTo(@1);
        }];
        
        [verticalBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.bottom.equalTo(horizontalBottomline.mas_top).offset(-9);
            make.height.equalTo(@30);
            make.width.equalTo(@1);
        }];
        
        [loss mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(timeNum);
            make.bottom.equalTo(horizontalBottomline.mas_top).offset(-9);
        }];
        [stopLoss mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(timeNum);
            make.bottom.equalTo(loss.mas_top);
        }];
        
        [chippedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(horizontalBottomline.mas_bottom).offset(10);
            make.height.equalTo(@30);
            make.width.equalTo(@100);
        }];
        
        [gray mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(chippedBtn.mas_bottom).offset(10);
            make.height.equalTo(@10);
        }];
    }
    return self;
}

#pragma mark - event response

//关注/取消关注
- (void)fellowClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    
    
}

//参与合买
- (void)chippedClick:(UIButton *)btn{
    
    
}

//买涨
- (void)buyRiseClick:(UIButton *)btn{
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRHoldPositionCell";
    GRHoldPositionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRHoldPositionCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
