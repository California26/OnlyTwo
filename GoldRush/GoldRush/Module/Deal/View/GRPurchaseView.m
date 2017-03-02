//
//  GRPurchaseView.m
//  GoldRush
//
//  Created by Jack on 2017/1/5.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRPurchaseView.h"

@interface GRPurchaseView ()

///实付款
@property (nonatomic, weak) UILabel *priceLabel;
///手续费
@property (nonatomic, weak) UILabel *chargeLabel;
@property (nonatomic, strong) UIButton *buy;

@end

@implementation GRPurchaseView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //设置子控件
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.backgroundColor = [UIColor whiteColor];
    //实付款
    UILabel *pay = [[UILabel alloc] init];
    [self addSubview:pay];
    pay.text = @"实付款";
    pay.textColor = [UIColor colorWithHexString:@"#666666"];
    pay.font = [UIFont systemFontOfSize:15];
    [pay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    //价钱
    UILabel *price = [[UILabel alloc] init];
    [self addSubview:price];
    self.priceLabel = price;
    price.textColor = [UIColor colorWithHexString:@"#d43c33"];
    price.font = [UIFont systemFontOfSize:15];
    [price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pay.mas_right).offset(3);
        make.centerY.equalTo(pay.mas_centerY);
    }];
    
    //手续费
    UILabel *charge = [[UILabel alloc] init];
    [self addSubview:charge];
    self.chargeLabel = charge;
    charge.textColor = [UIColor colorWithHexString:@"#999999"];
    charge.font = [UIFont systemFontOfSize:12];
    
    //下单按钮
    _buy = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.buy];
    _buy.backgroundColor = [UIColor colorWithHexString:@"#f1496c"];
    [_buy setTitle:@"买涨下单" forState:UIControlStateNormal];
    _buy.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [_buy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.top.and.bottom.equalTo(self);
        make.width.equalTo(@100);
    }];
    [_buy addTarget:self action:@selector(buyClick) forControlEvents:UIControlEventTouchUpInside];
    
    [charge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_buy.mas_left).offset(-10);
        make.centerY.equalTo(pay.mas_centerY);
    }];
}

- (void)buyClick{
    if ([self.delegate respondsToSelector:@selector(resultButtonAction)]) {
        [self.delegate resultButtonAction];
    }
}

#pragma mark - setter and getter 
- (void)setCharge:(NSString *)charge{
    _charge = charge;
    if (charge) {
        self.chargeLabel.text = [NSString stringWithFormat:@"手续费:%.2f元",charge.floatValue];
    }
}

- (void)setPrice:(NSString *)price{
    _price = price;
    
    if (price) {
        self.priceLabel.text = [NSString stringWithFormat:@"%.2f元",price.floatValue];
    }
}

- (void)setStringResultTitle:(NSString *)stringResultTitle{
    if ([stringResultTitle isEqualToString:@"买涨下单"]) {
        [_buy setTitle:stringResultTitle forState:UIControlStateNormal];
        _buy.backgroundColor = [UIColor colorWithHexString:@"#f1496c"];
    }else{
        [_buy setTitle:stringResultTitle forState:UIControlStateNormal];
        _buy.backgroundColor = [UIColor colorWithHexString:@"#09cb67"];
    }
}

@end
