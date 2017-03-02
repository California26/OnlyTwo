//
//  GRRechargePayTypeCell.m
//  GoldRush
//
//  Created by Jack on 2017/2/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRRechargePayTypeCell.h"

@interface GRRechargePayTypeCell ()<UITextFieldDelegate>

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *payTypeLabel;
@property (nonatomic, weak) UILabel *payDescLabel;

@property (nonatomic, strong) UITextField *bankNumField;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation GRRechargePayTypeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    UIImageView *picView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 19, 36, 36)];
    picView.image = [UIImage imageNamed:@"Mine_Card"];
    picView.layer.cornerRadius = picView.frame.size.width/2;
    picView.layer.masksToBounds = YES;
    [self.contentView addSubview:picView];
    self.iconView = picView;
    
    UILabel *payLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(picView.frame)+5, CGRectGetMinY(picView.frame), 180, 18)];
    payLabel.text = @"银行卡支付";
    payLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    payLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:payLabel];
    self.payTypeLabel = payLabel;
    
    UILabel *payDesc = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(payLabel.frame), CGRectGetMaxY(payLabel.frame), CGRectGetWidth(payLabel.frame), CGRectGetHeight(payLabel.frame))];
    payDesc.textColor = [UIColor colorWithHexString:@"#666666"];
    payDesc.text = @"安全急速支付，无需开通网银";
    payDesc.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:payDesc];
    self.payDescLabel = payDesc;
    
    //选中按钮
    UIButton *selected = [UIButton buttonWithType:UIButtonTypeCustom];
    selected.frame = CGRectMake(K_Screen_Width - 30, CGRectGetMinY(picView.frame) + 8, 20, 20);
    [selected setImage:[UIImage imageNamed:@"Mine_Selected_Default"] forState:UIControlStateNormal];
    [selected setImage:[UIImage imageNamed:@"Mine_Selected_Selected"] forState:UIControlStateSelected];
    [selected addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:selected];
}

#pragma mark - private method
///支付方式后面的选择按钮
- (void)selectClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(gr_rechargePayTypeCell:selectWhichPayType:)]) {
        [self.delegate gr_rechargePayTypeCell:self selectWhichPayType:btn];
    }
    
}

- (void)setPayTypeDict:(NSDictionary *)payTypeDict{
    _payTypeDict = payTypeDict;
    
    self.iconView.image = [UIImage imageNamed:payTypeDict[@"imageName"]];
    self.payTypeLabel.text = payTypeDict[@"payType"];
    self.payDescLabel.text = payTypeDict[@"payDesc"];
}

- (void)setShowField:(BOOL)showField{
    if (showField) {
        ///输入框
        [self.contentView addSubview:self.bankNumField];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.bankNumField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconView.mas_bottom).offset(5);
            make.left.equalTo(self.titleLabel.mas_right).offset(5);
            make.right.equalTo(self.contentView).offset(-15);
            make.height.equalTo(@44);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.bankNumField.mas_centerY);
            make.left.equalTo(self.contentView).offset(15);
        }];
    }else{
        [self.titleLabel removeFromSuperview];
        [self.bankNumField removeFromSuperview];
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gr_textFieldDidEndEditing:)]) {
        [self.delegate gr_textFieldDidEndEditing:textField];
    }
}

#pragma mark - setter and getter

- (UITextField *)bankNumField{
    if (!_bankNumField) {
        _bankNumField = [[UITextField alloc] init];
        _bankNumField.placeholder = @"请输入提现金额";
        _bankNumField.borderStyle = UITextBorderStyleRoundedRect;
        _bankNumField.delegate = self;
        _bankNumField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _bankNumField;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"其他金额";
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    return _titleLabel;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRRechargePayTypeCell";
    GRRechargePayTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRRechargePayTypeCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
