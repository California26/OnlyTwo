//
//  GRMineUserWithdrawView.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/11.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRMineUserHDWithdrawView.h"
#import "GRCountDownBtn.h"

@interface GRMineUserHDWithdrawView ()<UITextFieldDelegate>

///
@property (nonatomic, weak) UILabel *bankLabel;

@end

@implementation GRMineUserHDWithdrawView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    UIView *view = [[UIView alloc] init];
    [self addSubview:view];
    view.backgroundColor = defaultBackGroundColor;
    UILabel *label = [[UILabel alloc] init];
    [view addSubview:label];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor colorWithHexString:@"#666666"];
    label.backgroundColor = defaultBackGroundColor;
    label.text = @"提现时间为周一07:00～周六04:00 提现2500以内将收取1%的手续费，提现不足200元收取2元手续费，手续费25元封顶";
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view).offset(5);
        make.left.mas_equalTo(13);
        make.right.mas_equalTo(-13);
    }];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(5);
        make.left.right.equalTo(self);
        make.height.equalTo(label.mas_height).multipliedBy(1.3);
    }];
    
    UILabel *bank = [[UILabel alloc] init];
    [self addSubview:bank];
    bank.textColor = [UIColor colorWithHexString:@"#333333"];
    bank.font = [UIFont systemFontOfSize:18];
    bank.text = @"建设银行(尾号4159)";
    [bank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).offset(15);
        make.left.mas_equalTo(13);
    }];
    self.bankLabel = bank;
    
    ///充值金额
    UILabel *nameL = [[UILabel alloc] init];
    [self addSubview:nameL];
    nameL.text = @"提现金额";
    nameL.textColor = [UIColor colorWithHexString:@"#333333"];
    nameL.font = [UIFont systemFontOfSize:16];
    [nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).offset(50);
        make.left.mas_equalTo(13);
    }];
    //设置Label的水平抗压缩 这样就不会变形了
    [nameL setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    UITextField *hhTF = [[UITextField alloc]init];
    [self addSubview:hhTF];
    hhTF.tag = 9036;
    hhTF.borderStyle = UITextBorderStyleRoundedRect;
    hhTF.keyboardType = UIKeyboardTypeDecimalPad;
    hhTF.font = [UIFont systemFontOfSize:14];
    hhTF.placeholder = @"请输入提现金额";
    hhTF.delegate = self;
    [hhTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(nameL.mas_centerY);
        make.left.mas_equalTo(nameL.mas_right).mas_offset(5);
        make.right.mas_equalTo(-13);
        make.height.mas_equalTo(30);
    }];
    
    //添加手机号
    UILabel *phoneLabel = [[UILabel alloc] init];
    [self addSubview:phoneLabel];
    phoneLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    phoneLabel.font = [UIFont systemFontOfSize:16];
    phoneLabel.text = @"手机号码";
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameL.mas_bottom).offset(25);
        make.left.mas_equalTo(13);
    }];
    [phoneLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    UITextField *phone = [[UITextField alloc] init];
    [self addSubview:phone];
    phone.borderStyle = UITextBorderStyleRoundedRect;
    phone.text = [GRUserDefault getUserPhone];
    phone.enabled = NO;
    phone.keyboardType = UIKeyboardTypeNumberPad;
    phone.font = [UIFont systemFontOfSize:14];
    phone.delegate = self;
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(phoneLabel.mas_centerY);
        make.left.mas_equalTo(phoneLabel.mas_right).mas_offset(5);
        make.right.mas_equalTo(-13);
        make.height.mas_equalTo(30);
    }];
    
    //添加短信验证码
    UILabel *codeLabel = [[UILabel alloc] init];
    [self addSubview:codeLabel];
    codeLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    codeLabel.font = [UIFont systemFontOfSize:16];
    codeLabel.text = @"验证码";
    [codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneLabel.mas_bottom).offset(25);
        make.left.mas_equalTo(13);
    }];
    [codeLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

    UITextField *code = [[UITextField alloc] init];
    [self addSubview:code];
    code.borderStyle = UITextBorderStyleRoundedRect;
    code.placeholder = @"输入验证码";
    code.delegate = self;
    code.tag = 9037;
    code.font = [UIFont systemFontOfSize:14];
    code.keyboardType = UIKeyboardTypeNumberPad;
    
    //获取验证码按钮
    GRCountDownBtn *codeBtn = [GRCountDownBtn buttonWithType:UIButtonTypeCustom];
    [self addSubview:codeBtn];
    [codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    codeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    codeBtn.layer.cornerRadius = 5.0f;
    codeBtn.layer.masksToBounds = YES;
    [codeBtn addTarget:self action:@selector(getBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    codeBtn.backgroundColor = [UIColor colorWithHexString:@"#00a0e9"];
    [code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(codeLabel.mas_centerY);
        make.leftMargin.mas_equalTo(phone);
        make.right.mas_equalTo(codeBtn.mas_left).mas_offset(-3);
        make.height.mas_equalTo(30);
    }];
    [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(codeLabel.mas_centerY);
        make.left.mas_equalTo(code.mas_right).mas_offset(3);
        make.right.mas_equalTo(-13);
        make.width.mas_equalTo(@80);
        make.height.mas_equalTo(30);
    }];
    [codeBtn setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:button];
    [button setTitle:@"确认提现" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    button.backgroundColor = [UIColor colorWithHexString:@"#f39800"];
    button.layer.cornerRadius = 5.0f;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(buttonSure:) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(13);
        make.right.equalTo(self).offset(-13);
        make.top.equalTo(code.mas_bottom).offset(15);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textColor = [UIColor colorWithHexString:@"#666666"];
    label2.text = @"更换银行卡后充值／提现账号后全部更换";
    label2.font = [UIFont systemFontOfSize:13];
    [self addSubview:label2];
    UILabel *labelLG = [[UILabel alloc] init];
    labelLG.layer.borderColor = defaultBackGroundColor.CGColor;
    labelLG.layer.borderWidth = 0.5;
    labelLG.font = [UIFont systemFontOfSize:20];
    labelLG.text = @"LG";
    labelLG.textAlignment = NSTextAlignmentCenter;
    labelLG.textColor = [UIColor colorWithHexString:@"#666666"];
    labelLG.layer.cornerRadius = labelLG.frame.size.width/2;
    labelLG.layer.masksToBounds = YES;
    [self addSubview:labelLG];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(button.mas_bottom).offset(25);
    }];
    
    [labelLG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label2.mas_centerY);
        make.right.equalTo(label2.mas_left).offset(-5);
    }];
}

- (void)buttonSure:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(gr_sureButtonAction:)]) {
        [self.delegate gr_sureButtonAction:sender];
    }
}

- (void)getBtnAction:(GRCountDownBtn *)btn{
    if ([self.delegate respondsToSelector:@selector(gr_getCodeClick:)]) {
        [self.delegate gr_getCodeClick:btn];
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(gr_surewithDrawMoneyAction:)]) {
        [self.delegate gr_surewithDrawMoneyAction:textField];
    }
}

- (void)setBank:(NSString *)bank{
    _bank = bank;
    self.bankLabel.text = bank;
}

@end
