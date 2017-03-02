//
//  GRRechargeFooterView.m
//  GoldRush
//
//  Created by Jack on 2017/2/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRRechargeFooterView.h"

@implementation GRRechargeFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    UIButton *buttonNext = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonNext.frame = CGRectMake(15, 15, K_Screen_Width - 15 * 2, 44);
    [buttonNext setTitle:@"下一步" forState:UIControlStateNormal];
    [buttonNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonNext.titleLabel.font = [UIFont systemFontOfSize:20];
    buttonNext.backgroundColor = [UIColor colorWithHexString:@"#f39800"];
    [buttonNext addTarget:self action:@selector(buttonNextAction:) forControlEvents:UIControlEventTouchUpInside];
    buttonNext.layer.cornerRadius = 5.0f;
    buttonNext.layer.masksToBounds = YES;
    [self addSubview:buttonNext];
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(K_Screen_Width / 2 - 17, CGRectGetMaxY(buttonNext.frame) + 15, 34, 44)];
    iconView.image = [UIImage imageNamed:@"Mine_Safe"];
    iconView.contentMode = UIViewContentModeCenter;
    [self addSubview:iconView];
    
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iconView.frame) + 10, K_Screen_Width, 18)];
    label5.text = @"保证您的资金安全";
    label5.textColor = [UIColor colorWithHexString:@"#666666"];
    label5.font = [UIFont systemFontOfSize:13];
    label5.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label5];
    
    UIImageView *picView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label5.frame) + 5, K_Screen_Width, 60)];
    picView2.image = [UIImage imageNamed:@"Mine_UnionPay"];
    picView2.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:picView2];
}

- (void)buttonNextAction:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gr_rechargeFooterViewDidNextClickBtn:)]) {
        [self.delegate gr_rechargeFooterViewDidNextClickBtn:sender];
    }
}

@end
