//
//  GRProHeaderView.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/3.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRProHeaderView.h"
#define HeightMag 1

@interface GRProHeaderView ()
@property (nonatomic,strong) UILabel *labelMoney;
@property (nonatomic,strong) UILabel *label1;
@property (nonatomic,strong) UIButton *buttonRecharge;
@property (nonatomic,strong) UILabel *labelCount;
@property (nonatomic,strong) UILabel *label2;
@property (nonatomic, weak)  UIButton *remindButton;

@end


@implementation GRProHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = mainColor;
        [self addSubview:self.labelMoney];
        [self addSubview:self.label1];
        [self addSubview:self.buttonRecharge];
        [self addSubview:self.labelCount];
        [self addSubview:self.label2];
        [self addSubview:self.remindButton];
    }
    return self;
}

- (UIButton *)remindButton{
    if (!_remindButton) {
        UIButton *remind = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:remind];
        self.remindButton = remind;
        remind.frame = CGRectMake(K_Screen_Width - 13 - 30, 10, 30, 30);
        [remind setImage:[UIImage imageNamed:@"Deal_Warn"] forState:UIControlStateNormal];
        [remind addTarget:self action:@selector(remindClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _remindButton;
}

- (UILabel *)labelMoney{
    if (!_labelMoney) {
        _labelMoney = [[UILabel alloc] initWithFrame:CGRectMake(15, HeightMag+2, 100, 20)];
        _labelMoney.font = [UIFont systemFontOfSize:15];
        _labelMoney.textColor = [UIColor whiteColor];
    }
    return _labelMoney;
}

- (UILabel *)label1{
    if (!_label1) {
        _label1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.labelMoney.frame), CGRectGetMaxY(_labelMoney.frame), CGRectGetWidth(_labelMoney.frame), CGRectGetHeight(_labelMoney.frame))];
        _label1.textColor = [UIColor whiteColor];
        _label1.text = @"个人资产(元)";
        _label1.font = _labelMoney.font;
    }
    return _label1;
}


- (UIButton *)buttonRecharge{
    if (!_buttonRecharge) {
        _buttonRecharge = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonRecharge setTitle:@"充值" forState:UIControlStateNormal];
        [_buttonRecharge setTitleColor:mainColor forState:UIControlStateNormal];
        _buttonRecharge.titleLabel.font = [UIFont systemFontOfSize:15];
        _buttonRecharge.backgroundColor = [UIColor whiteColor];
        _buttonRecharge.layer.cornerRadius = 5.0f;
        _buttonRecharge.layer.masksToBounds = YES;
        [_buttonRecharge addTarget:self action:@selector(buttonRechargeAction:) forControlEvents:UIControlEventTouchUpInside];
        _buttonRecharge.frame = CGRectMake(CGRectGetMaxX(_labelMoney.frame), HeightMag+10, 40, 20);
    }
    return _buttonRecharge;
}

- (UILabel *)labelCount{
    if (!_labelCount) {
        _labelCount = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_buttonRecharge.frame)+10, CGRectGetMinY(_labelMoney.frame), CGRectGetWidth(_labelMoney.frame), CGRectGetHeight(_labelMoney.frame))];
        _labelCount.textColor = _labelMoney.textColor;
        _labelCount.font = _labelCount.font;
    }
    return _labelCount;
}

- (UILabel *)label2{
    if (!_label2) {
        _label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_labelCount.frame), CGRectGetMaxY(_labelCount.frame), CGRectGetWidth(_labelCount.frame), CGRectGetHeight(_labelCount.frame))];
        _label2.textColor = [UIColor whiteColor];
        _label2.text = @"赢家券（张）";
        _label2.font = _label1.font;
    }
    return _label2;
}


- (void)setMoney:(double)money{
    self.labelMoney.text = [NSString stringWithFormat:@"%.2f",money];
}

- (void)setCount:(NSInteger)count{
    self.labelCount.text = [NSString stringWithFormat:@"%ld",(long)count];
}

- (void)buttonRechargeAction:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(rechargeAction)]) {
        [self.delegate rechargeAction];
    }
}

- (void)remindClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(warnAction)]) {
        [self.delegate warnAction];
    }
}


//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [[UIColor whiteColor] setStroke];
//    CGContextMoveToPoint(context, K_Screen_Width/2+17, 25);
//    CGContextAddLineToPoint(context, K_Screen_Width/2+17, 60);
//    CGContextSetLineCap(context, kCGLineCapRound);
//    CGContextSetLineWidth(context, 1);
//    CGContextStrokePath(context);
//}

@end
