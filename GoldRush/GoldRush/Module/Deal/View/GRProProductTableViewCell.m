//
//  GRProProductTableViewCell.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/18.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRProProductTableViewCell.h"

@interface GRProProductTableViewCell ()

@property (nonatomic,strong) UILabel  *productNamelabel;
@property (nonatomic,strong) UILabel  *positionRule;
@property (nonatomic,strong) UIButton *buttonDetail;

@end

@implementation GRProProductTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = defaultBackGroundColor;
        [self.contentView addSubview:self.productNamelabel];
        [self.contentView addSubview:self.positionRule];
        [self.contentView addSubview:self.buttonDetail];
    }
    return self;
}

- (UILabel *)productName
{
    if (!_productNamelabel) {
        _productNamelabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 150, 20)];
        _productNamelabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _productNamelabel.font = [UIFont systemFontOfSize:13];
        
    }
    return _productNamelabel;
}

- (UILabel *)positionRule
{
    if (!_positionRule) {
        _positionRule = [[UILabel alloc] initWithFrame:CGRectMake(K_Screen_Width-50-100, 0, 100, 20)];
        _positionRule.textColor = _productNamelabel.textColor;
        _positionRule.textColor = _productNamelabel.textColor;
        _positionRule.font = _productNamelabel.font;
        _positionRule.text = @"持仓规则";
    }
    return _positionRule;
}


- (UIButton *)buttonDetail
{
    if (!_buttonDetail) {
        _buttonDetail = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonDetail setImage:[UIImage imageNamed:@"detail"] forState:UIControlStateNormal];
        _buttonDetail.frame = CGRectMake(K_Screen_Width - 35,0, 20, 20);
        [_buttonDetail addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonDetail;
}

- (void)buttonAction:(UIButton *)sender
{
//    NSString *string1 = @"交易手续费为0.8元/手，6元/手，24元/手，平仓不收取手续费，持仓上限10手，持仓单不过夜，如持仓订单在结算时间前未平仓，将会被系统强制转让。";
//    CGRect  rect1 =  [string1 sizeWithLabelWidth:K_Screen_Width/3 font:[UIFont systemFontOfSize:13]];
    
//    NSString *string2 = @"10元/手 持仓上限20手 200元/手  持仓上限60手  2000元/手持仓上限40手  2000元/手交割带纳金15元/天  10元/手  200元/手 不支持持仓过夜，故不产生交割带纳金费用。若持仓单在每日结算点前未平仓，系统会以当天收盘价对订单进行结算。200元/手可持仓过夜，持仓单于每天结算点根据手数收取交割带纳金，此外，若2000元/手的商品持仓单于当周最后一个交易日结算点前未平仓，系统会以当天收盘价对订单进行结算.";
//    CGRect rect2 =  [string2 sizeWithLabelWidth:K_Screen_Width/3 font:[UIFont systemFontOfSize:13]];
    
}
- (void)setProductName:(NSString *)productName
{
    _productNamelabel.text = [NSString stringWithFormat:@"%@  最新持仓数",productName];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"PRODUCT";
    GRProProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRProProductTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
