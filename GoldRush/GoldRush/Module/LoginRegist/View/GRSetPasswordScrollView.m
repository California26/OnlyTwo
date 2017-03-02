//
//  GRSetPasswordScrollView.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/7.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRSetPasswordScrollView.h"
#import "GRCountDownBtn.h"              ///获取验证码按钮

#define KLabelX 15

@interface GRSetPasswordScrollView ()<UITextFieldDelegate>

@property (nonatomic, weak) GRCountDownBtn *getCountBtn;        ///倒计时按钮

@property (nonatomic, assign) BOOL isTime;                      ///是否在获取验证码

@end

@implementation GRSetPasswordScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = defaultBackGroundColor;
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height/3)];
    iconView.image = [UIImage imageNamed:@"HPME_Exchange"];
    [self addSubview:iconView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(KLabelX, CGRectGetMaxY(iconView.frame), K_Screen_Width-15*2, 47)];
    label.text = @"恒交所重新设置交易密码";
    label.textColor = [UIColor colorWithHexString:@"#333333"];
    label.font = [UIFont systemFontOfSize:15];
    [self addSubview:label];
    
    ///手机号
    UITextField *phone = [[UITextField alloc] initWithFrame:CGRectMake(KLabelX, CGRectGetMaxY(label.frame), CGRectGetWidth(label.frame), 45)];
    phone.borderStyle = UITextBorderStyleRoundedRect;
    phone.text = [GRUserDefault getUserPhone];
    phone.enabled = NO;
    [self addSubview:phone];
    
    UITextField *capcha = [[UITextField alloc] initWithFrame:CGRectMake(KLabelX, CGRectGetMaxY(phone.frame) + 10, CGRectGetWidth(label.frame) - 103, 45)];
    capcha.borderStyle = UITextBorderStyleRoundedRect;
    capcha.placeholder = @"请输入验证码";
    capcha.keyboardType = UIKeyboardTypeNumberPad;
    capcha.delegate = self;
    capcha.tag = 4678;
    [self addSubview:capcha];
    
    GRCountDownBtn *getCountBtn = [[GRCountDownBtn alloc] initWithFrame:CGRectMake(CGRectGetMaxX(capcha.frame) + 10, CGRectGetMaxY(phone.frame) + 13, 93, 40)];
    [self addSubview:getCountBtn];
    self.getCountBtn = getCountBtn;
    [getCountBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCountBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getCountBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    getCountBtn.layer.cornerRadius = 5.0f;
    getCountBtn.layer.masksToBounds = YES;
    [getCountBtn addTarget:self action:@selector(getBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    getCountBtn.backgroundColor = mainColor;
    
    UITextField *textFiled1 = [[UITextField alloc] initWithFrame:CGRectMake(KLabelX, CGRectGetMaxY(capcha.frame) + 10, CGRectGetWidth(label.frame), 45)];
    textFiled1.placeholder = @"密码只能使用数字、字母，长度6-15位";
    textFiled1.textColor = [UIColor colorWithHexString:@"#cccccc"];
    textFiled1.keyboardType = UIKeyboardTypeNumberPad;
    textFiled1.clearButtonMode = UITextFieldViewModeWhileEditing;
    textFiled1.secureTextEntry = YES;
    textFiled1.borderStyle = UITextBorderStyleRoundedRect;
    textFiled1.tag = 4679;
    textFiled1.delegate = self;
    textFiled1.returnKeyType = UIReturnKeyDone;
    [self addSubview:textFiled1];
    
    UIButton *regButton = [UIButton buttonWithType:UIButtonTypeCustom];
    regButton.frame = CGRectMake(15, CGRectGetMaxY(textFiled1.frame) + 20, K_Screen_Width-30, 44);
    [regButton setTitle:@"确认修改" forState:UIControlStateNormal];
    regButton.backgroundColor = mainColor;
    [regButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    regButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [regButton addTarget:self action:@selector(regButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    regButton.layer.cornerRadius = 5.0f;
    regButton.layer.masksToBounds = YES;
    [self addSubview:regButton];
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self.passwordDelegate getPasswordTextBeginWithTextField:textField];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [self.passwordDelegate getPasswordTextEndWithTextField:textField];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.text.length || ![string isEqualToString:@""]) {
        if (self.isTime) {  //正在获取验证码
            self.getCountBtn.enabled = NO;
        }else{
            self.getCountBtn.enabled = YES;
        }
    }
    //改变获取验证码按钮的颜色
    [self changeCaptchaButtonColor];
    return YES;
}

#pragma event response
#pragma mark - 改变注册按钮的颜色
//改变获取验证码按钮的颜色
- (void)changeCaptchaButtonColor{
    if (self.getCountBtn.enabled) {
        self.getCountBtn.backgroundColor = mainColor;
    } else {
        self.getCountBtn.backgroundColor = GRColor(224, 224, 224);
    }
}

- (void)buttonUserProtocol:(UIButton *)sender{
    if (self.passwordDelegate && [self.passwordDelegate respondsToSelector:@selector(userProtocol)]) {
        [self.passwordDelegate userProtocol];
    }
}

- (void)regButtonAction:(UIButton *)sender{
    if (self.passwordDelegate && [self.passwordDelegate respondsToSelector:@selector(updatePasswordAction)]) {
        [self.passwordDelegate updatePasswordAction];
    }
}

- (void)getBtnAction:(GRCountDownBtn *)btn{
    __weak GRSetPasswordScrollView *setPassword = self;
    btn.enabled = NO;
    btn.backgroundColor = GRColor(224, 224, 224);
    //设置按钮的倒计时
    [btn startWithSecond:60];
    [btn didChange:^NSString *(GRCountDownBtn *countDownButton, int second) {
        setPassword.isTime = YES;
        NSString *title = [NSString stringWithFormat:@"%d秒重新获取",second];
        return title;
    }];
    [btn didFinished:^NSString *(GRCountDownBtn *countDownButton, int second) {
        countDownButton.enabled = YES;
        btn.backgroundColor = [UIColor colorWithHexString:@"#d43c33"];
        setPassword.isTime = NO;
        return @"点击重新获取";
    }];
    
    if (self.passwordDelegate && [self.passwordDelegate respondsToSelector:@selector(JJ_getCode:didClickGetCodeBtn:)]) {
        [self.passwordDelegate JJ_getCode:self didClickGetCodeBtn:btn];
    }
}

@end
