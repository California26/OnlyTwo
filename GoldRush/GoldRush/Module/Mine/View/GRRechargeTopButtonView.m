//
//  GRRechargeTopButtonView.m
//  GoldRush
//
//  Created by Jack on 2017/1/20.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRRechargeTopButtonView.h"

@interface GRRechargeTopButtonView ()



@end

@implementation GRRechargeTopButtonView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 115)];
    iconView.image = [UIImage imageNamed:@"Carousel"];
    [self addSubview:iconView];

    //充值
    UIButton *recharge = [UIButton buttonWithType:UIButtonTypeCustom];
    [recharge setTitle:@"充值" forState:UIControlStateNormal];
    [recharge setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [recharge addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    recharge.titleLabel.font = [UIFont fontWithName:@"Heiti SC Light" size:17];
    [self buttonAction:recharge];
    recharge.tag = 10230;
    [recharge setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateSelected];
    recharge.frame = CGRectMake(0, CGRectGetMaxY(iconView.frame), K_Screen_Width/3, 44);
    
    //提现
    UIButton *withDraw = [UIButton buttonWithType:UIButtonTypeCustom];
    [withDraw setTitle:@"提现" forState:UIControlStateNormal];
    [withDraw setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [withDraw addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    withDraw.frame = CGRectMake(CGRectGetMaxX(recharge.frame), CGRectGetMinY(recharge.frame), CGRectGetWidth(recharge.frame), CGRectGetHeight(recharge.frame));
    withDraw.tag = 10231;
    withDraw.titleLabel.font = [UIFont fontWithName:@"Heiti SC Light" size:17];
    [withDraw setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateSelected];
    
    //转账明细
    UIButton *detail = [UIButton buttonWithType:UIButtonTypeCustom];
    [detail setTitle:@"转账明细" forState:UIControlStateNormal];
    [detail setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [detail addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    detail.frame = CGRectMake(CGRectGetMaxX(withDraw.frame), CGRectGetMinY(recharge.frame), CGRectGetWidth(recharge.frame), CGRectGetHeight(recharge.frame));
    detail.tag = 10232;
    detail.titleLabel.font = [UIFont fontWithName:@"Heiti SC Light" size:17];
    [detail setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateSelected];
    
    [self addSubview:recharge];
    [self addSubview:withDraw];
    [self addSubview:detail];
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(recharge.frame) - 1, K_Screen_Width, 1)];
    viewLine.backgroundColor = defaultBackGroundColor;
    [self addSubview:viewLine];
}

#pragma mark - event response
- (void)buttonAction:(UIButton *)btn{    
    if (self.delegate && [self.delegate respondsToSelector:@selector(gr_rechargeTopButtonViewDidClickBtn:)]) {
        [self.delegate gr_rechargeTopButtonViewDidClickBtn:btn];
    }
}

@end
