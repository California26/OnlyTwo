//
//  GRHDLogin.m
//  GoldRush
//
//  Created by Jack on 2017/1/18.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRHDLogin.h"

@interface GRHDLogin ()<UITextFieldDelegate>

@end

@implementation GRHDLogin

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height/3)];
        iconView.image = [UIImage imageNamed:@"HPME_Exchange"];
        [self addSubview:iconView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(iconView.frame), K_Screen_Width-15*2, 30)];
        label.text = @"为了资金安全,交易2小时后需要重新登陆!";
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        label.font = [UIFont systemFontOfSize:15];
        [self addSubview:label];
        
        UITextField *passWord = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(label.frame), CGRectGetWidth(label.frame), 45)];
        passWord.placeholder = @"请输入6位数字密码";
        passWord.textColor = [UIColor colorWithHexString:@"#cccccc"];
        passWord.keyboardType = UIKeyboardTypeNumberPad;
        passWord.clearButtonMode = UITextFieldViewModeWhileEditing;
        passWord.secureTextEntry = YES;
        passWord.borderStyle = UITextBorderStyleRoundedRect;
        passWord.delegate = self;
        passWord.returnKeyType = UIReturnKeyDone;
        [self addSubview:passWord];
        
        UIButton *forget = [UIButton buttonWithType:UIButtonTypeCustom];
        forget.frame = CGRectMake(K_Screen_Width - 80, CGRectGetMaxY(passWord.frame) + 10, 80, 20);
        [forget setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [forget setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        forget.titleLabel.font = [UIFont systemFontOfSize:15];
        [forget addTarget:self action:@selector(forgetButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:forget];
        
        UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
        login.frame = CGRectMake(15, CGRectGetMaxY(forget.frame) + 10, K_Screen_Width-30, 44);
        [login setTitle:@"登陆" forState:UIControlStateNormal];
        login.backgroundColor = mainColor;
        [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        login.titleLabel.font = [UIFont systemFontOfSize:18];
        [login addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        login.layer.cornerRadius = 5.0f;
        login.layer.masksToBounds = YES;
        [self addSubview:login];
    }
    return self;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(HD_getPasswordTextEndWithTextField:)]) {
        [self.delegate HD_getPasswordTextEndWithTextField:textField];
    }
    return YES;
}

#pragma mark - event response
- (void)loginButtonAction:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(HD_loginClick:withLoginBtn:)]) {
        [self.delegate HD_loginClick:self withLoginBtn:btn];
    }
}

- (void)forgetButtonAction:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(HD_forgetClick:withForgetBtn:)]) {
        [self.delegate HD_forgetClick:self withForgetBtn:btn];
    }
}

@end
