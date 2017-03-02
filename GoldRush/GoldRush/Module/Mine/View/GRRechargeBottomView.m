//
//  GRRechargeBottomView.m
//  GoldRush
//
//  Created by Jack on 2017/1/20.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRRechargeBottomView.h"

@interface GRRechargeBottomView ()

@property (nonatomic, weak) UIButton *affirmBtn;

@end

@implementation GRRechargeBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加银行卡按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"+添加银行卡" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.frame = CGRectMake(0, 0, K_Screen_Width, 44);
        [button addTarget:self action:@selector(addBankAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        //充值按钮
        UIButton *buttontype = [UIButton buttonWithType:UIButtonTypeCustom];
        buttontype.frame = CGRectMake(15, CGRectGetMaxY(button.frame), K_Screen_Width-15*2, 44);
        buttontype.layer.cornerRadius = 5.0f;
        buttontype.layer.masksToBounds = YES;
        [buttontype setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buttontype addTarget:self action:@selector(buttonSureAction:) forControlEvents:UIControlEventTouchUpInside];
        buttontype.backgroundColor = mainColor;
        [self addSubview:buttontype];
        self.affirmBtn = buttontype;
    }
    return self;
}

#pragma mark response 
///确认按钮
- (void)buttonSureAction:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gr_rechargeBottomView:didClickNextButton:)]) {
        [self.delegate gr_rechargeBottomView:self didClickNextButton:sender];
    }
}

//添加银行卡
- (void)addBankAction:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(gr_rechargeBottomView:didClickAddBankButton:)]) {
        [self.delegate gr_rechargeBottomView:self didClickAddBankButton:sender];
    }
}

- (void)setButtonType:(NSString *)buttonType{
    _buttonType = buttonType;
    [self.affirmBtn setTitle:buttonType forState:UIControlStateNormal];
}

@end
