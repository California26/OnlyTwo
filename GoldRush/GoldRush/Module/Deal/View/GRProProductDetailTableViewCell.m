//
//  GRProProductDetailTableViewCell.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/18.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRProProductDetailTableViewCell.h"

@interface GRProProductDetailTableViewCell ()

@property (nonatomic,strong) UILabel *labelProductName;
@property (nonatomic,strong) UILabel *labelPrice;
@property (nonatomic,strong) UILabel *labelOpenPrice;
@property (nonatomic,strong) UILabel *labelClosePrice;
@property (nonatomic,strong) UILabel *labelWinLose;
@property (nonatomic,strong) UILabel *labelWinLosePrice;
@property (nonatomic,strong) UIButton *buttonStopWinLose;
@property (nonatomic,strong) UIButton *buttonStop;

@end

@implementation GRProProductDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatSubViews];
    }
    return self;
}


- (void)creatSubViews
{
    _labelWinLose = [[UILabel alloc] initWithFrame:CGRectMake(K_Screen_Width/2-20, 5, 40, 15)];
    _labelWinLose.text = @"盈亏";
    _labelWinLose.font = [UIFont systemFontOfSize:13];
    _labelWinLose.textColor = [UIColor colorWithHexString:@"#666666"];
    _labelWinLose.textAlignment = NSTextAlignmentCenter;
    
    _labelWinLosePrice = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_labelWinLose.frame)-5, CGRectGetMaxY(_labelWinLose.frame)+3, CGRectGetWidth(_labelWinLose.frame)+10, CGRectGetHeight(_labelWinLose.frame))];
    _labelWinLosePrice.layer.cornerRadius = 3.0f;
    _labelWinLosePrice.layer.masksToBounds = YES;
    _labelWinLosePrice.font = [UIFont systemFontOfSize:12];
    _labelWinLosePrice.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    _labelWinLosePrice.text = @"0.00";
    _labelWinLosePrice.textAlignment = NSTextAlignmentCenter;
    _labelWinLosePrice.textColor = [UIColor whiteColor];

    _labelProductName = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, (K_Screen_Width/2-10-5-CGRectGetWidth(_labelWinLose.frame)/2)/2, 15)];
    _labelProductName.text = @"吉微油";
    _labelProductName.font = [UIFont systemFontOfSize:13];
    _labelProductName.textColor = [UIColor colorWithHexString:@"#666666"];
    _labelProductName.textAlignment = NSTextAlignmentCenter;
    
    _labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_labelProductName.frame), CGRectGetMaxY(_labelProductName.frame)+3, CGRectGetWidth(_labelProductName.frame), CGRectGetHeight(_labelProductName.frame))];
    _labelPrice.textColor =_labelProductName.textColor;
    _labelPrice.textAlignment = _labelProductName.textAlignment;
    _labelPrice.font = [UIFont systemFontOfSize:10];
    _labelPrice.text = @"买涨";
    
    _labelOpenPrice = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_labelProductName.frame)+5, CGRectGetMinY(_labelProductName.frame), CGRectGetWidth(_labelProductName.frame), CGRectGetHeight(_labelProductName.frame))];
    _labelOpenPrice.textColor =_labelProductName.textColor;
    _labelOpenPrice.textAlignment = _labelProductName.textAlignment;
    _labelOpenPrice.font = _labelProductName.font;
    _labelOpenPrice.text = @"建仓价";
    
    
    _labelClosePrice = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_labelProductName.frame)+5, CGRectGetMinY(_labelPrice.frame), CGRectGetWidth(_labelProductName.frame), CGRectGetHeight(_labelProductName.frame))];
    _labelClosePrice.textColor =_labelProductName.textColor;
    _labelClosePrice.textAlignment = _labelProductName.textAlignment;
    _labelClosePrice.font = _labelProductName.font;
    _labelClosePrice.text = @"0.00";
    
    _buttonStopWinLose =[UIButton buttonWithType:UIButtonTypeCustom];
    _buttonStopWinLose.frame = CGRectMake(CGRectGetMaxX(_labelWinLose.frame)+10, 10, CGRectGetWidth(_labelProductName.frame)-5, 25);
    [_buttonStopWinLose setTitle:@"止盈止损" forState:UIControlStateNormal];
    _buttonStopWinLose.titleLabel.font = [UIFont systemFontOfSize:13];
    _buttonStopWinLose.backgroundColor = [UIColor colorWithHexString:@"#4a90e2"];
    [_buttonStopWinLose setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_buttonStopWinLose addTarget:self action:@selector(buttonStopWinLoseAction:) forControlEvents:UIControlEventTouchUpInside];
    _buttonStopWinLose.layer.cornerRadius = 5.0f;
    _buttonStopWinLose.layer.masksToBounds = YES;
    
    
    
    _buttonStop =[UIButton buttonWithType:UIButtonTypeCustom];
    _buttonStop.frame = CGRectMake(CGRectGetMaxX(_buttonStopWinLose.frame)+10, 10, CGRectGetWidth(_buttonStopWinLose.frame), 25);
    [_buttonStop setTitle:@"平仓" forState:UIControlStateNormal];
    _buttonStop.titleLabel.font = [UIFont systemFontOfSize:13];
    _buttonStop.backgroundColor = [UIColor colorWithHexString:@"#f39800"];
    [_buttonStop setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_buttonStop addTarget:self action:@selector(buttonStop:) forControlEvents:UIControlEventTouchUpInside];
    _buttonStop.layer.cornerRadius = 5.0f;
    _buttonStop.layer.masksToBounds = YES;
    
    
    [self.contentView addSubview:self.labelProductName];
    [self.contentView addSubview:self.labelPrice];
    [self.contentView addSubview:self.labelOpenPrice];
    [self.contentView addSubview:self.labelClosePrice];
    [self.contentView addSubview:self.labelWinLose];
    [self.contentView addSubview:self.labelWinLosePrice];
    [self.contentView addSubview:self.buttonStopWinLose];
    [self.contentView addSubview:self.buttonStop];
    
    
}

- (void)setTag:(NSInteger)tag
{
    _buttonStopWinLose.tag = tag;
    _buttonStop.tag = tag;
}

- (void)setPositionModel:(GRPropertyDealDetail *)positionModel
{
    _labelProductName.text = HD_ProductName;
//    _labelOpenPrice.text = [NSString stringWithFormat:@"建仓价%@",positionModel.buyPrice];
    _labelClosePrice.text = [NSString stringWithFormat:@"%@",positionModel.buyPrice];
    if ([positionModel.buyDirection isEqualToString:@"1"]) {
        _labelPrice.text = [NSString stringWithFormat:@"买跌%@元",positionModel.buyMoney];
    }else{
        _labelPrice.text = [NSString stringWithFormat:@"买涨%@元",positionModel.buyMoney];
    }
    if ([positionModel.plAmount containsString:@"-"]) {
        _labelWinLosePrice.backgroundColor = [UIColor colorWithHexString:@"#09cb67"];
    }else{
        _labelWinLosePrice.backgroundColor = [UIColor colorWithHexString:@"#f1496c"];
    }
    _labelWinLosePrice.text = [NSString stringWithFormat:@"%@",positionModel.plAmount];

}

- (void)setPositionModelJJ:(GRJJHoldPositionModel *)positionModelJJ
{
    _positionModelJJ = positionModelJJ;
    if ([_positionModelJJ.productNo isEqualToString:JJ_ContactCU]) {
        _labelProductName.text = @"吉微铜";
    }else if ([_positionModelJJ.productNo isEqualToString:JJ_ContactXAG])
    {
        _labelProductName.text = @"吉微银";
    }else{
        _labelProductName.text = @"吉微油";
    }
    
//    _labelOpenPrice.text = [NSString stringWithFormat:@"建仓价%.2f",positionModelJJ.buildPositionPrice.floatValue];
    _labelClosePrice.text = [NSString stringWithFormat:@"%.2f",positionModelJJ.buildPositionPrice.floatValue];
    if (positionModelJJ.tradeType == 1) {       //涨
        _labelPrice.text = [NSString stringWithFormat:@"买涨%ld元",(long)positionModelJJ.tradeDeposit];
    }else
    {
        _labelPrice.text = [NSString stringWithFormat:@"买跌%ld元",(long)positionModelJJ.tradeDeposit];
    }
    if (positionModelJJ.profitOrLoss.floatValue < 0) {
        _labelWinLosePrice.backgroundColor = [UIColor colorWithHexString:@"#09cb67"];
    }else{
        _labelWinLosePrice.backgroundColor = [UIColor colorWithHexString:@"#f1496c"];
    }
    _labelWinLosePrice.text = [NSString stringWithFormat:@"%.2f",positionModelJJ.profitOrLoss.floatValue];
}

- (void)buttonStop:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(proProductDetailTableViewCellButtonStopAction:)]) {
        [self.delegate proProductDetailTableViewCellButtonStopAction:sender.tag];
    }
}
- (void)buttonStopWinLoseAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(proProductDetailTableViewCellButtonAction:)]) {
        [self.delegate proProductDetailTableViewCellButtonAction:sender.tag];
    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"PRODUCTDetail";
    GRProProductDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRProProductDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
