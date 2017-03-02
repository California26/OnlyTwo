//
//  GRMineUserRechargeView.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/10.
//  Copyright © 2017年 Jack. All rights reserved.
//  充值页面

#import "GRMineUserRechargeView.h"

@interface GRMineUserRechargeView ()<UITextFieldDelegate>

@property (nonatomic, weak) UILabel *rechargeTimeLabel;         ///充值时间
@property (nonatomic, weak) UIButton *bankBtn;
@property (nonatomic, weak) UIButton *weChatBtn;

@end

@implementation GRMineUserRechargeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatSubViews];
    }
    return self;
}


- (void)creatSubViews{
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, K_Screen_Width-15*2, 30)];
    label1.text = @"充值时间为07:00(周一08:00)～次日04:00(冬令时)";
    label1.textColor = [UIColor colorWithHexString:@"#666666"];
    label1.font = [UIFont systemFontOfSize:12];
    [self addSubview:label1];
    self.rechargeTimeLabel = label1;
    
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
        button.tag = i+100;
        [viewButton addSubview:button];
    }
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label2.frame)+30+60, K_Screen_Width, 10)];
    view1.backgroundColor = defaultBackGroundColor;
    
    UIImageView *picView = [[UIImageView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(view1.frame)+9, 36, 36)];
    picView.image = [UIImage imageNamed:@"Mine_Card"];
    picView.layer.cornerRadius = picView.frame.size.width/2;
    picView.layer.masksToBounds = YES;
    [self addSubview:view1];
    [self addSubview:picView];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(picView.frame)+5, CGRectGetMinY(picView.frame), 180, 18)];
    label3.text = @"银行卡支付";
    label3.textColor = [UIColor colorWithHexString:@"#333333"];
    label3.font = [UIFont systemFontOfSize:15];
    [self addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(label3.frame), CGRectGetMaxY(label3.frame), CGRectGetWidth(label3.frame), CGRectGetHeight(label3.frame))];
    label4.textColor = [UIColor colorWithHexString:@"#666666"];
    label4.text = @"安全急速支付，无需开通网银";
    label4.font = [UIFont systemFontOfSize:13];
    [self addSubview:label4];
    
    //选中按钮
    UIButton *selected = [UIButton buttonWithType:UIButtonTypeCustom];
    selected.frame = CGRectMake(K_Screen_Width - 30, CGRectGetMinY(picView.frame) + 8, 20, 20);
    [selected setImage:[UIImage imageNamed:@"Mine_Selected_Default"] forState:UIControlStateNormal];
    [selected setImage:[UIImage imageNamed:@"Mine_Selected_Selected"] forState:UIControlStateSelected];
    [selected addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:selected];
    self.bankBtn = selected;
    selected.selected = YES;
    selected.tag = 1024;
    
//    UIImageView *weChat = [[UIImageView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(picView.frame)+9, 36, 36)];
//    weChat.image = [UIImage imageNamed:@"Mine_WeChat"];
//    weChat.layer.cornerRadius = picView.frame.size.width/2;
//    weChat.layer.masksToBounds = YES;
//    [self addSubview:weChat];
//    
//    UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(weChat.frame)+5, CGRectGetMinY(weChat.frame), 180, 18)];
//    tip.text = @"微信支付";
//    tip.textColor = [UIColor colorWithHexString:@"#333333"];
//    tip.font = [UIFont systemFontOfSize:15];
//    [self addSubview:tip];
    
//    UILabel *pay = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(tip.frame), CGRectGetMaxY(tip.frame), CGRectGetWidth(label3.frame), CGRectGetHeight(label3.frame))];
//    pay.textColor = [UIColor colorWithHexString:@"#666666"];
//    pay.text = @"安全急速支付";
//    pay.font = [UIFont systemFontOfSize:13];
//    [self addSubview:pay];
    
    //选中按钮
//    UIButton *weBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    weBtn.frame = CGRectMake(K_Screen_Width - 30, CGRectGetMinY(weChat.frame) + 8, 20, 20);
//    [weBtn setImage:[UIImage imageNamed:@"Mine_Selected_Default"] forState:UIControlStateNormal];
//    [weBtn setImage:[UIImage imageNamed:@"Mine_Selected_Selected"] forState:UIControlStateSelected];
//    [weBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:weBtn];
//    self.weChatBtn = weBtn;
//    weBtn.tag = 1025;
    
    ///输入银行卡号
//    UITextField *card = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(weChat.frame)+15, K_Screen_Width-15*2, 44)];
//    card.placeholder = @"请填写充值银行卡号";
//    card.borderStyle = UITextBorderStyleRoundedRect;
//    card.delegate = self;
//    [self addSubview:card];
    
    UIButton *buttonNext = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonNext.frame = CGRectMake(15, CGRectGetMaxY(picView.frame) + 15, K_Screen_Width - 15 * 2, 44);
    [buttonNext setTitle:@"下一步" forState:UIControlStateNormal];
    [buttonNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonNext.titleLabel.font = [UIFont systemFontOfSize:20];
    buttonNext.backgroundColor = [UIColor colorWithHexString:@"#f39800"];
    [buttonNext addTarget:self action:@selector(buttonNextAction:) forControlEvents:UIControlEventTouchUpInside];
    buttonNext.layer.cornerRadius = 5.0f;
    buttonNext.layer.masksToBounds = YES;
    [self addSubview:buttonNext];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(buttonNext.frame)+45, (K_Screen_Width-15*2-44-34)/2, 0.5)];
    view2.backgroundColor = defaultBackGroundColor;
    [self addSubview:view2];
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(K_Screen_Width/2-17, CGRectGetMaxY(buttonNext.frame)+22.5, 34, 44)];
    iconView.image = [UIImage imageNamed:@"Mine_Safe"];
    iconView.contentMode = UIViewContentModeCenter;
    [self addSubview:iconView];
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(K_Screen_Width-15-CGRectGetWidth(view2.frame), CGRectGetMinY(view2.frame), CGRectGetWidth(view2.frame), CGRectGetHeight(view2.frame))];
    view3.backgroundColor = view2.backgroundColor;
    [self addSubview:view3];
    
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iconView.frame)+10, K_Screen_Width, 18)];
    label5.text = @"保证您的资金安全";
    label5.textColor = [UIColor colorWithHexString:@"#666666"];
    label5.font = [UIFont systemFontOfSize:13];
    label5.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label5];
    
    UIImageView *picView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label5.frame)+15, K_Screen_Width, 60)];
    picView2.image = [UIImage imageNamed:@"Mine_UnionPay"];
    picView2.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:picView2];
}

- (void)buttonAction:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(buttonMoneyTypeAction:)]) {
        [self.delegate buttonMoneyTypeAction:sender];
    }
}

- (void)buttonNextAction:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(NextAction:)]) {
        [self.delegate NextAction:sender];
    }
}

///支付方式后面的选择按钮
- (void)selectClick:(UIButton *)btn{
    
    if (btn == self.bankBtn) {
        self.bankBtn.selected = YES;
        self.weChatBtn.selected = NO;
    }else{
        self.bankBtn.selected = NO;
        self.weChatBtn.selected = YES;
    }
    
    if ([self.delegate respondsToSelector:@selector(selectedWhichPayType:)]) {
        [self.delegate selectedWhichPayType:btn];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(getBankCardNumberWithTextField:)]) {
        [self.delegate getBankCardNumberWithTextField:textField];
    }
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

@end
