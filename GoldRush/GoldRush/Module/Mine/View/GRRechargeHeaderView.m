//
//  GRRechargeHeaderView.m
//  GoldRush
//
//  Created by Jack on 2017/2/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRRechargeHeaderView.h"

@interface GRRechargeHeaderView ()



@end

@implementation GRRechargeHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, K_Screen_Width-15*2, 30)];
    label1.text = @"充值时间为07:00(周一08:00)～次日04:00(冬令时)";
    label1.textColor = [UIColor colorWithHexString:@"#666666"];
    label1.font = [UIFont systemFontOfSize:12];
    [self addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label1.frame), CGRectGetWidth(label1.frame)+15*2, 25)];
    label2.textColor = [UIColor colorWithHexString:@"#333333"];
    label2.text = @"   选择充值金额";
    label2.font = [UIFont systemFontOfSize:14];
    label2.backgroundColor = defaultBackGroundColor;
    [self addSubview:label2];
    
    UIView *viewButton = [[UIView alloc] initWithFrame:CGRectMake(0, 25+30, K_Screen_Width, 90)];
    viewButton.tag = 10;
    [self addSubview:viewButton];
    NSArray *aryButton = [NSArray arrayWithObjects:@"10元",@"100元",@"250元",@"500元",@"2500元",@"5000元", nil];
    for (int i = 0; i<aryButton.count;i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:aryButton[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        button.layer.borderColor = [UIColor colorWithHexString:@"#999999"].CGColor;
        button.layer.borderWidth = 0.5;
        button.layer.cornerRadius = 3.0f;
        button.layer.masksToBounds = YES;
        if (i < 3) {
            if (i == 0) {
                [button setTitleColor:mainColor forState:UIControlStateNormal];
                button.layer.borderColor = mainColor.CGColor;
            }
            button.frame = CGRectMake(15+((K_Screen_Width-15*2-34)/3+17)*i, 10, (K_Screen_Width-15*2-34)/3, 30);
        }else{
            button.frame = CGRectMake(15+((K_Screen_Width-15*2-34)/3+17)*(i-3), 10+30+10, (K_Screen_Width-15*2-34)/3, 30);
        }
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i + 100;
        [viewButton addSubview:button];
    }
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label2.frame)+30+60, K_Screen_Width, 10)];
    view1.backgroundColor = defaultBackGroundColor;
    [self addSubview:view1];
}

- (void)buttonAction:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gr_rechargeHeaderView:didSelectMoneyBtn:)]) {
        [self.delegate gr_rechargeHeaderView:self didSelectMoneyBtn:sender];
    }
}

@end
