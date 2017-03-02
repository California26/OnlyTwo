//
//  GRProProductTotalTableViewCell.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/18.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRProProductTotalTableViewCell.h"
#import "GRPropertyDealDetail.h"
#import "GRJJHoldPositionModel.h"
@interface GRProProductTotalTableViewCell ()

@property (nonatomic,strong) UILabel *labelPositionAll;
@property (nonatomic,strong) UILabel *labelpositionAllNumber;
@property (nonatomic,strong) UILabel *labelUp;
@property (nonatomic,strong) UILabel *labelDown;
@property (nonatomic,strong) UILabel *labelOpenAll;
@property (nonatomic,strong) UILabel *labelOpenAllNumber;
@property (nonatomic,strong) UILabel *labelWinAll;
@property (nonatomic,strong) UILabel *labelWinAllNumber;


@end

@implementation GRProProductTotalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews
{
    _labelPositionAll = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, K_Screen_Width/4, 15)];
    _labelPositionAll.textColor = [UIColor colorWithHexString:@"#666666"];
    _labelPositionAll.text = @"总持仓数";
    _labelPositionAll.font = [UIFont systemFontOfSize:12];
    _labelPositionAll.textAlignment = NSTextAlignmentCenter;
    
    _labelpositionAllNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_labelPositionAll.frame)+5, CGRectGetWidth(_labelPositionAll.frame), CGRectGetHeight(_labelPositionAll.frame))];
    _labelpositionAllNumber.textColor =  _labelPositionAll.textColor;
    _labelpositionAllNumber.text = @"0笔";
    _labelpositionAllNumber.font =  _labelPositionAll.font ;
    _labelpositionAllNumber.textAlignment =  _labelPositionAll.textAlignment;
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_labelPositionAll.frame), 5, 1.0, 34)];
    line1.backgroundColor = defaultBackGroundColor;
    
    
    _labelUp = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_labelPositionAll.frame)+1, CGRectGetMinY(_labelPositionAll.frame), CGRectGetWidth(_labelPositionAll.frame), CGRectGetHeight(_labelPositionAll.frame))];
    _labelUp.textColor =  [UIColor colorWithHexString:@"#f1496c"];
    _labelUp.text = @"买涨0笔";
    _labelUp.font =  _labelPositionAll.font ;
    _labelUp.textAlignment =  _labelPositionAll.textAlignment;
    
    _labelDown = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_labelPositionAll.frame)+1, CGRectGetMaxY(_labelPositionAll.frame)+5, CGRectGetWidth(_labelPositionAll.frame), CGRectGetHeight(_labelPositionAll.frame))];
    _labelDown.textColor =  [UIColor colorWithHexString:@"#09cb67"];
    _labelDown.text = @"买跌0笔";
    _labelDown.font =  _labelPositionAll.font ;
    _labelDown.textAlignment =  _labelPositionAll.textAlignment;
    
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_labelDown.frame), 5, 1.0, 34)];
    line2.backgroundColor = defaultBackGroundColor;
    
    _labelOpenAll = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line2.frame), CGRectGetMinY(_labelPositionAll.frame), CGRectGetWidth(_labelPositionAll.frame), CGRectGetHeight(_labelPositionAll.frame))];
    _labelOpenAll.textColor =  _labelPositionAll.textColor;
    _labelOpenAll.text = @"总建仓成本";
    _labelOpenAll.font =  _labelPositionAll.font ;
    _labelOpenAll.textAlignment =  _labelPositionAll.textAlignment;
    
    _labelOpenAllNumber = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line2.frame), CGRectGetMaxY(_labelPositionAll.frame)+5, CGRectGetWidth(_labelPositionAll.frame), CGRectGetHeight(_labelPositionAll.frame))];
    _labelOpenAllNumber.textColor =  _labelPositionAll.textColor;
    _labelOpenAllNumber.text = @"0元";
    _labelOpenAllNumber.font =  _labelPositionAll.font ;
    _labelOpenAllNumber.textAlignment =  _labelPositionAll.textAlignment;
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_labelOpenAll.frame), 5, 1.0, 34)];
    line3.backgroundColor = defaultBackGroundColor;
    
    _labelWinAll = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line3.frame), CGRectGetMinY(_labelPositionAll.frame), CGRectGetWidth(_labelPositionAll.frame), CGRectGetHeight(_labelPositionAll.frame))];
    _labelWinAll.textColor =  _labelPositionAll.textColor;
    _labelWinAll.text = @"总盈亏";
    _labelWinAll.font =  _labelPositionAll.font ;
    _labelWinAll.textAlignment =  _labelPositionAll.textAlignment;
    
    _labelWinAllNumber = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line3.frame), CGRectGetMaxY(_labelPositionAll.frame)+5, CGRectGetWidth(_labelPositionAll.frame), CGRectGetHeight(_labelPositionAll.frame))];
    _labelWinAllNumber.textColor =  [UIColor colorWithHexString:@"d43c33"];
    _labelWinAllNumber.text = @"0元";
    _labelWinAllNumber.font =  _labelPositionAll.font ;
    _labelWinAllNumber.textAlignment =  _labelPositionAll.textAlignment;
    
    [self.contentView addSubview:self.labelPositionAll];
    [self.contentView addSubview:self.labelpositionAllNumber];
    [self.contentView addSubview:line1];
    [self.contentView addSubview:self.labelUp];
    [self.contentView addSubview:self.labelDown];
    [self.contentView addSubview:line2];
    [self.contentView addSubview:self.labelOpenAll];
    [self.contentView addSubview:self.labelOpenAllNumber];
    [self.contentView addSubview:line3];
    [self.contentView addSubview:self.labelWinAll];
    [self.contentView addSubview:self.labelWinAllNumber];    
}


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"PRODUCTAll";
    GRProProductTotalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRProProductTotalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setAryData:(NSArray *)aryData
{
    if (aryData.count == 0 && aryData) {
        _labelpositionAllNumber.text = @"0笔";
        _labelUp.text = @"买涨0笔";
        _labelDown.text = @"买跌0笔";
        _labelOpenAllNumber.text = @"0元";
        _labelWinAllNumber.text = @"0元";
        return;
    }
    _aryData = aryData;

    _labelpositionAllNumber.text = [NSString stringWithFormat:@"%ld笔",(unsigned long)_aryData.count];
    int number = 0;
    float allMoney = 0;
    float winMoney = 0;
    if ([aryData.firstObject isKindOfClass:[GRJJHoldPositionModel class]]) {
        for (GRJJHoldPositionModel *model in aryData) {
            if (model.tradeType == 1) {
                number ++;
            }
            allMoney = model.tradeDeposit+ allMoney;
            winMoney = model.profitOrLoss.floatValue + winMoney;
        }
    }else{
        for (GRPropertyDealDetail *model in _aryData) {
            if ([model.buyDirection isEqualToString:@"2"]) {
                number ++;
            }
            allMoney = model.buyMoney.floatValue + allMoney;
            winMoney = model.plAmount.floatValue + winMoney;
        }
    }
    
    _labelUp.text = [NSString stringWithFormat:@"买涨%d笔",number];
    _labelDown.text = [NSString stringWithFormat:@"买跌%lu笔",(_aryData.count - number)];
    _labelOpenAllNumber.text = [NSString stringWithFormat:@"%.1f元",allMoney];
    _labelWinAllNumber.text = [NSString stringWithFormat:@"%.2f元",winMoney];
    
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
