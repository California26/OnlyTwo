//
//  GRPropertyDealDetailCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/10.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRPropertyDealDetailCell.h"
#import "GRPropertyDealDetail.h"            ///数据模型
#import "GRJJPropertyDealDetail.h"

@interface GRPropertyDealDetailCell ()

@property (nonatomic, weak) UILabel *timeLabel;             ///交易时间
@property (nonatomic, weak) UILabel *dateLabel;             ///交易日期
@property (nonatomic, weak) UILabel *productLabel;          ///产品名字
@property (nonatomic, weak) UILabel *isRiseLabel;           ///是涨/跌
@property (nonatomic, weak) UILabel *profitLabel;           ///盈利多少
@property (nonatomic, weak) UILabel *buildPriceLabel;       ///建仓价
@property (nonatomic, weak) UILabel *closePriceLabel;       ///平仓价
@property (nonatomic, weak) UILabel *buildCostLabel;        ///建仓成本
@property (nonatomic, weak) UILabel *chargeLabel;           ///手续费
@property (nonatomic, weak) UILabel *buyTypeLabel;          ///购买方式
@property (nonatomic, weak) UILabel *closeTypeLabel;        ///平仓类型
@property (nonatomic, weak) UILabel *buildTimeLabel;        ///建仓时间
///
@property (nonatomic, weak) UILabel *buildDateLabel;
@property (nonatomic, weak) UILabel *closeTimeLabel;        ///平仓时间
///
@property (nonatomic, weak) UILabel *closeDateLabel;

@property (nonatomic, weak) UIView *bottomView;             ///底部详情的 view
@property (nonatomic, weak) UIButton *arrowButton;          ///箭头按钮


@end

@implementation GRPropertyDealDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //时间
        UILabel *time = [[UILabel alloc] init];
        [self.contentView addSubview:time];
        time.textColor = [UIColor colorWithHexString:@"#333333"];
        time.font = [UIFont systemFontOfSize:14];
        self.timeLabel = time;
        
        UILabel *date = [[UILabel alloc] init];
        [self.contentView addSubview:date];
        date.textColor = [UIColor colorWithHexString:@"#333333"];
        date.font = [UIFont systemFontOfSize:14];
        self.dateLabel = date;
        
        // 产品
        UILabel *product = [[UILabel alloc] init];
        [self.contentView addSubview:product];
        product.textColor = [UIColor colorWithHexString:@"#333333"];
        product.font = [UIFont systemFontOfSize:15];
        self.productLabel = product;
        
        //涨/跌
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:13];
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 5;
        label.textAlignment = NSTextAlignmentCenter;
        self.isRiseLabel = label;
        
        //箭头
        UIButton *arrow = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:arrow];
        [arrow setImage:[UIImage imageNamed:@"Mine_Detail_Arrow"] forState:UIControlStateNormal];
        [arrow setImage:[UIImage imageNamed:@"Mine_Detail_Arrow_Up"] forState:UIControlStateSelected];
        [arrow addTarget:self action:@selector(arrowClick:) forControlEvents:UIControlEventTouchUpInside];
        self.arrowButton = arrow;
        
        //涨幅数
        UILabel *riseNum = [[UILabel alloc] init];
        [self.contentView addSubview:riseNum];
        riseNum.font = [UIFont systemFontOfSize:15];
        self.profitLabel = riseNum;
        
        //展开页
        UIView *bottomView = [[UIView alloc] init];
        [self.contentView addSubview:bottomView];
        bottomView.backgroundColor = GRColor(240, 240, 240);
        self.bottomView = bottomView;
        bottomView.hidden = YES;
        
        //建仓价
        UILabel *build = [[UILabel alloc] init];
        [bottomView addSubview:build];
        build.textColor = [UIColor colorWithHexString:@"#666666"];
        build.font = [UIFont systemFontOfSize:12];
        self.buildPriceLabel = build;
        
        //平仓价
        UILabel *close = [[UILabel alloc] init];
        [bottomView addSubview:close];
        close.textColor = [UIColor colorWithHexString:@"#666666"];
        close.font = [UIFont systemFontOfSize:12];
        self.closePriceLabel = close;
        
        //建仓成本
        UILabel *cost = [[UILabel alloc] init];
        [bottomView addSubview:cost];
        cost.textColor = [UIColor colorWithHexString:@"#666666"];
        cost.font = [UIFont systemFontOfSize:12];
        self.buildCostLabel = cost;
        
        //手续费
        UILabel *charge = [[UILabel alloc] init];
        [bottomView addSubview:charge];
        charge.textColor = [UIColor colorWithHexString:@"#666666"];
        charge.font = [UIFont systemFontOfSize:12];
        self.chargeLabel = charge;
        
        //购买方式
        UILabel *type = [[UILabel alloc] init];
        [bottomView addSubview:type];
        type.textColor = [UIColor colorWithHexString:@"#666666"];
        type.font = [UIFont systemFontOfSize:12];
        self.buyTypeLabel = type;
        
        //平仓类型
        UILabel *closeType = [[UILabel alloc] init];
        [bottomView addSubview:closeType];
        closeType.textColor = [UIColor colorWithHexString:@"#666666"];
        closeType.font = [UIFont systemFontOfSize:12];
        self.closeTypeLabel = closeType;
        
        //建仓时间
        UILabel *buildTime = [[UILabel alloc] init];
        [bottomView addSubview:buildTime];
        buildTime.textColor = [UIColor colorWithHexString:@"#666666"];
        buildTime.font = [UIFont systemFontOfSize:12];
        buildTime.text = @"建仓时间";
        
        UILabel *buildDate = [[UILabel alloc] init];
        [bottomView addSubview:buildDate];
        buildDate.textColor = [UIColor colorWithHexString:@"#666666"];
        self.buildTimeLabel = buildDate;
        buildDate.font = [UIFont systemFontOfSize:12];
        
        UILabel *buildHour = [[UILabel alloc] init];
        [bottomView addSubview:buildHour];
        buildHour.textColor = [UIColor colorWithHexString:@"#666666"];
        self.buildDateLabel = buildHour;
        buildHour.font = [UIFont systemFontOfSize:12];
        
        //平仓时间
        UILabel *closeTime = [[UILabel alloc] init];
        [bottomView addSubview:closeTime];
        closeTime.textColor = [UIColor colorWithHexString:@"#666666"];
        closeTime.font = [UIFont systemFontOfSize:12];
        closeTime.text = @"平仓时间";
        
        UILabel *closeDate = [[UILabel alloc] init];
        [bottomView addSubview:closeDate];
        self.closeTimeLabel = closeDate;
        closeDate.textColor = [UIColor colorWithHexString:@"#666666"];
        closeDate.font = [UIFont systemFontOfSize:12];
        
        UILabel *closeHour = [[UILabel alloc] init];
        [bottomView addSubview:closeHour];
        closeHour.textColor = [UIColor colorWithHexString:@"#666666"];
        closeHour.font = [UIFont systemFontOfSize:12];
        self.closeDateLabel = closeHour;
        
        //布局
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(44);
        }];
        
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(bottomView.mas_top).offset(-5);
            make.left.equalTo(self.contentView).offset(20);
        }];
        
        [date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(time.mas_centerX);
            make.bottom.equalTo(time.mas_top);
        }];
        
        [product mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(bottomView.mas_top).offset(-10);
            make.centerX.equalTo(self.contentView.mas_centerX);
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(bottomView.mas_top).offset(-10);
            make.left.equalTo(product.mas_right).offset(7);
            make.width.equalTo(@17);
        }];
        
        [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(bottomView.mas_top).offset(-10);
            make.right.equalTo(self.contentView).offset(-13);
            make.width.height.equalTo(@20);
        }];
        
        [riseNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(bottomView.mas_top).offset(-10);
            make.right.equalTo(arrow.mas_left).offset(-10);
        }];
        
        [build mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomView.mas_left).offset(13);
            make.top.equalTo(bottomView.mas_top).offset(10);
        }];
        
        [cost mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(build);
            make.top.equalTo(build.mas_bottom).offset(10);
        }];
        
        [type mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(build);
            make.top.equalTo(cost.mas_bottom).offset(10);
        }];
        
        
        ///建仓时间
        [buildTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(build);
            make.top.equalTo(type.mas_bottom).offset(10);
        }];
        
        [buildDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(buildTime.mas_right).offset(5);
            make.top.equalTo(type.mas_bottom);
        }];
        
        [buildHour mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(buildDate.mas_centerX);
            make.top.equalTo(buildDate.mas_bottom);
        }];
        
        [close mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bottomView.mas_centerX).offset(40);
            make.top.equalTo(bottomView.mas_top).offset(10);
        }];
        
        [charge mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(close);
            make.top.equalTo(close.mas_bottom).offset(10);
        }];
        
        [closeType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(close);
            make.top.equalTo(charge.mas_bottom).offset(10);
        }];
        
        
        ///平仓时间
        [closeTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(close);
            make.top.equalTo(closeType.mas_bottom).offset(10);
        }];
        
        [closeDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(closeTime.mas_right).offset(5);
            make.top.equalTo(closeType.mas_bottom);
        }];
        
        [closeHour mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(closeDate.mas_centerX);
            make.top.equalTo(closeDate.mas_bottom);
        }];
    }
    return self;
}

#pragma mark - event response
- (void)arrowClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    
    self.dealDetailModel.unfold = btn.selected;
    self.JJDetailModel.unfold = btn.selected;
    
    if ([self.delegate respondsToSelector:@selector(propertyDealDetailCell:didClickUnfoldBtn:)]) {
        [self.delegate propertyDealDetailCell:self didClickUnfoldBtn:btn.isSelected];
    }
    
    if (self.arrowBlock) {
        self.arrowBlock(btn.selected);
    }
}


#pragma mark - setter and getter
- (void)setDealDetailModel:(GRPropertyDealDetail *)dealDetailModel{
    _dealDetailModel = dealDetailModel;
    
    self.timeLabel.text = [dealDetailModel.addTime substringFromIndex:10];
    self.dateLabel.text = [dealDetailModel.addTime substringToIndex:10];
    
    self.productLabel.text = dealDetailModel.proDesc;
    if ([dealDetailModel.buyDirection isEqualToString:@"2"]) {
        self.profitLabel.textColor = [UIColor colorWithHexString:@"#f1496c"];
        self.isRiseLabel.backgroundColor = [UIColor colorWithHexString:@"#f1496c"];
        self.isRiseLabel.text = @"涨";
    }else{
        self.profitLabel.textColor = [UIColor colorWithHexString:@"#09cb67"];
        self.isRiseLabel.backgroundColor = [UIColor colorWithHexString:@"#09cb67"];
        self.isRiseLabel.text = @"跌";
    }
    if (dealDetailModel.plAmount.floatValue >= 0) {
        self.profitLabel.textColor = [UIColor colorWithHexString:@"#f1496c"];
    }else{
        self.profitLabel.textColor = [UIColor colorWithHexString:@"#09cb67"];
    }
    
    if (dealDetailModel.plAmount) {
        self.profitLabel.text = [NSString stringWithFormat:@"%@",dealDetailModel.plAmount];
    }else{
        self.profitLabel.text = @"0";
    }
    
    self.buildPriceLabel.text = [NSString stringWithFormat:@"建仓价   %@",dealDetailModel.buyPrice];
    if (dealDetailModel.sellPrice) {
        self.closePriceLabel.text = [NSString stringWithFormat:@"平仓价   %@",dealDetailModel.sellPrice];
    }else{
        self.closePriceLabel.text = [NSString stringWithFormat:@"平仓价   %@",@"暂无平仓"];
    }
    self.buildCostLabel.text = [NSString stringWithFormat:@"建仓成本  %@",dealDetailModel.buyMoney];
    self.chargeLabel.text = [NSString stringWithFormat:@"手续费   %@",dealDetailModel.fee];
    if ([dealDetailModel.payType isEqualToString:@"201"]) {
        self.buyTypeLabel.text = [NSString stringWithFormat:@"购买方式   现金支付"];
    }else if ([dealDetailModel.payType isEqualToString:@"101"]) {
        self.buyTypeLabel.text = [NSString stringWithFormat:@"购买方式   现金支付"];
    }{
        self.buyTypeLabel.text = [NSString stringWithFormat:@"购买方式   抵金券购买"];
    }
    
    if ([dealDetailModel.orderType isEqualToString:@"1"]) {
        self.closeTypeLabel.text = [NSString stringWithFormat:@"平仓类型  %@",@"暂无平仓"];
    }else if ([dealDetailModel.orderType isEqualToString:@"7"]){
        self.closeTypeLabel.text = [NSString stringWithFormat:@"平仓类型  %@",@"自动平仓"];
    }else if ([dealDetailModel.orderType isEqualToString:@"3"]){
        self.closeTypeLabel.text = [NSString stringWithFormat:@"平仓类型  %@",@"手动平仓"];
    }else if ([dealDetailModel.orderType isEqualToString:@"4"]){
        self.closeTypeLabel.text = [NSString stringWithFormat:@"平仓类型  %@",@"止盈平仓"];
    }else if ([dealDetailModel.orderType isEqualToString:@"5"]){
        self.closeTypeLabel.text = [NSString stringWithFormat:@"平仓类型  %@",@"止损平仓"];
    }else if ([dealDetailModel.orderType isEqualToString:@"6"]){
        self.closeTypeLabel.text = [NSString stringWithFormat:@"平仓类型  %@",@"爆仓平仓"];
    }else{
        self.closeTypeLabel.text = [NSString stringWithFormat:@"平仓类型  %@",@"暂无平仓"];
    }
    
    self.buildTimeLabel.text = [dealDetailModel.addTime substringToIndex:10];
    self.buildDateLabel.text = [dealDetailModel.addTime substringFromIndex:10];
    
    if (dealDetailModel.sellTime) {
        [self.closeTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.closeTypeLabel.mas_bottom);
        }];
        self.closeTimeLabel.text = [dealDetailModel.sellTime substringToIndex:10];
        self.closeDateLabel.text = [dealDetailModel.sellTime substringFromIndex:10];
    }else{
        [self.closeTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.closeTypeLabel.mas_bottom).offset(10);
        }];
        self.closeTimeLabel.text = [NSString stringWithFormat:@"%@",@"暂无平仓"];
        self.closeDateLabel.text = @"";
    }
    
    if (dealDetailModel.unfold) {
        self.bottomView.hidden = NO;
        self.arrowButton.selected = YES;
    }else{
        self.bottomView.hidden = YES;
        self.arrowButton.selected = NO;
    }
}

- (void)setJJDetailModel:(GRJJPropertyDealDetail *)JJDetailModel{
    _JJDetailModel = JJDetailModel;
    
    NSString *time = [self timeWithTimeIntervalString:[NSString stringWithFormat:@"%zd",JJDetailModel.buildTime]];
    self.dateLabel.text = [time substringToIndex:10];
    self.timeLabel.text = [time substringFromIndex:10];
    
    self.productLabel.text = [JJDetailModel.productName substringToIndex:3];
    if (JJDetailModel.tradeType == 2) {
        self.profitLabel.textColor = [UIColor colorWithHexString:@"#f1496c"];
        self.isRiseLabel.backgroundColor = [UIColor colorWithHexString:@"#f1496c"];
        self.isRiseLabel.text = @"涨";
    }else{
        self.profitLabel.textColor = [UIColor colorWithHexString:@"#09cb67"];
        self.isRiseLabel.backgroundColor = [UIColor colorWithHexString:@"#09cb67"];
        self.isRiseLabel.text = @"跌";
    }
    if (JJDetailModel.profitOrLoss.floatValue >= 0) {
        self.profitLabel.textColor = [UIColor colorWithHexString:@"#f1496c"];
    }else{
        self.profitLabel.textColor = [UIColor colorWithHexString:@"#09cb67"];
    }
    
    if (JJDetailModel.profitOrLoss) {
        self.profitLabel.text = [NSString stringWithFormat:@"%.2f",JJDetailModel.profitOrLoss.floatValue];
    }else{
        self.profitLabel.text = @"0";
    }
    
    self.buildPriceLabel.text = [NSString stringWithFormat:@"建仓价   %@",JJDetailModel.buildPositionPrice];
    if (JJDetailModel.liquidateIncome) {
        self.closePriceLabel.text = [NSString stringWithFormat:@"平仓价   %.2f",JJDetailModel.liquidatePositionPrice.floatValue];
    }else{
        self.closePriceLabel.text = [NSString stringWithFormat:@"平仓价   %@",@"暂无平仓"];
    }
    self.buildCostLabel.text = [NSString stringWithFormat:@"建仓成本  %zd",(long)JJDetailModel.tradeDeposit];
    self.chargeLabel.text = [NSString stringWithFormat:@"手续费   %@",JJDetailModel.tradeFee];
    
    if (JJDetailModel.useTicket == 0) {
        self.buyTypeLabel.text = [NSString stringWithFormat:@"购买方式   现金支付"];
    }else {
        self.buyTypeLabel.text = [NSString stringWithFormat:@"购买方式   抵金券购买"];
    }
    
    if (JJDetailModel.liquidateType == 1) {
        self.closeTypeLabel.text = [NSString stringWithFormat:@"平仓类型  %@",@"爆仓"];
    }else if (JJDetailModel.liquidateType == 2){
        self.closeTypeLabel.text = [NSString stringWithFormat:@"平仓类型  %@",@"手动平仓"];
    }else if (JJDetailModel.liquidateType == 3){
        self.closeTypeLabel.text = [NSString stringWithFormat:@"平仓类型  %@",@"止盈平仓"];
    }else if (JJDetailModel.liquidateType == 4){
        self.closeTypeLabel.text = [NSString stringWithFormat:@"平仓类型  %@",@"止损平仓"];
    }else if (JJDetailModel.liquidateType == 5){
        self.closeTypeLabel.text = [NSString stringWithFormat:@"平仓类型  %@",@"结算平仓"];
    }
    
    
    NSString *buildTimeStr = [NSString stringWithFormat:@"%@",[self timeWithTimeIntervalString:[NSString stringWithFormat:@"%zd",JJDetailModel.buildTime]]];
    self.buildTimeLabel.text = [buildTimeStr substringToIndex:10];
    self.buildDateLabel.text = [buildTimeStr substringFromIndex:10];
    
    if (JJDetailModel.liquidateTime) {
        NSString *closeTimeStr = [NSString stringWithFormat:@"%@",[self timeWithTimeIntervalString:[NSString stringWithFormat:@"%zd",JJDetailModel.liquidateTime]]];
        self.closeTimeLabel.text = [closeTimeStr substringToIndex:10];
        self.closeDateLabel.text = [closeTimeStr substringFromIndex:10];
    }else{
        self.closeTimeLabel.text = [NSString stringWithFormat:@"平仓时间  %@",@"暂无平仓"];
    }
    
    if (JJDetailModel.unfold) {
        self.bottomView.hidden = NO;
        self.arrowButton.selected = YES;
    }else{
        self.bottomView.hidden = YES;
        self.arrowButton.selected = NO;
    }
}

- (NSString *)timeWithTimeIntervalString:(NSString *)timeString{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

#pragma mark - private method
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRPropertyDealDetailCell";
    GRPropertyDealDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRPropertyDealDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
