//
//  GRWithDrawView.m
//  GoldRush
//
//  Created by Jack on 2017/1/19.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRMineUserJJWithdrawView.h"
#import "GRCountDownBtn.h"

@interface GRMineUserJJWithdrawView ()<UITextFieldDelegate>

@property (nonatomic, weak) UITextField *bankCardFiled;         ///银行卡


@end

@implementation GRMineUserJJWithdrawView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
//        UILabel *tip = [[UILabel alloc] init];
//        [self addSubview:tip];
//        tip.text = @"   您需要使用现金交易一次后才可提现";
//        tip.textColor = [UIColor colorWithHexString:@"#666666"];
//        tip.backgroundColor = defaultBackGroundColor;
//        tip.font = [UIFont systemFontOfSize:15];
        
        //添加银行卡号输入框
        UITextField *cardNum = [[UITextField alloc] init];
        [self addSubview:cardNum];
        cardNum.borderStyle = UITextBorderStyleRoundedRect;
        cardNum.placeholder = @"请输入银行卡号";
        self.bankCardFiled = cardNum;
        cardNum.keyboardType = UIKeyboardTypeNumberPad;
        cardNum.delegate = self;
        cardNum.tag = 2017 + 1;
        
        UILabel *bankNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        [self addSubview:bankNum];
        bankNum.textColor = [UIColor colorWithHexString:@"#333333"];
        bankNum.font = [UIFont systemFontOfSize:17];
        bankNum.textAlignment = NSTextAlignmentCenter;
        bankNum.text = @"银行卡号";
        cardNum.leftView = bankNum;
        cardNum.leftViewMode = UITextFieldViewModeAlways;
        
        //添加请输入姓名输入框
        UITextField *name = [[UITextField alloc] init];
        [self addSubview:name];
        name.borderStyle = UITextBorderStyleRoundedRect;
        name.placeholder = @"请输入银行卡开户名";
        name.delegate = self;
        name.tag = 2017 + 2;
        
        UILabel *bankType = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        [self addSubview:bankType];
        bankType.textColor = [UIColor colorWithHexString:@"#333333"];
        bankType.font = [UIFont systemFontOfSize:17];
        bankType.textAlignment = NSTextAlignmentCenter;
        bankType.text = @"开户姓名";
        name.leftView = bankType;
        name.leftViewMode = UITextFieldViewModeAlways;
        
        //添加提现金额输入框
        UITextField *money = [[UITextField alloc] init];
        [self addSubview:money];
        money.delegate = self;
        money.borderStyle = UITextBorderStyleRoundedRect;
        money.placeholder = @"请输入提现金额";
        money.tag = 2017 + 3;
        money.keyboardType = UIKeyboardTypeDecimalPad;
        
        UILabel *provinceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        [self addSubview:provinceLabel];
        provinceLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        provinceLabel.font = [UIFont systemFontOfSize:17];
        provinceLabel.textAlignment = NSTextAlignmentCenter;
        provinceLabel.text = @"提现金额";
        money.leftView = provinceLabel;
        money.leftViewMode = UITextFieldViewModeAlways;
        
        //添加交易密码输入框
        UITextField *password = [[UITextField alloc] init];
        [self addSubview:password];
        password.borderStyle = UITextBorderStyleRoundedRect;
        password.placeholder = @"请输入交易密码";
        password.delegate = self;
        password.tag = 2017 + 4;
        password.secureTextEntry = YES;
        
        UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        [self addSubview:passwordLabel];
        passwordLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        passwordLabel.font = [UIFont systemFontOfSize:17];
        passwordLabel.textAlignment = NSTextAlignmentCenter;
        passwordLabel.text = @"交易密码";
        password.leftView = passwordLabel;
        password.leftViewMode = UITextFieldViewModeAlways;
        
        //添加短信验证码输入框
        UITextField *code = [[UITextField alloc] init];
        [self addSubview:code];
        code.borderStyle = UITextBorderStyleRoundedRect;
        code.placeholder = @"输入短信验证码";
        if (iPhone5) {
            NSAttributedString *attributStr = [[NSAttributedString alloc] initWithString:@"输入短信验证码" attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:16.2], NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
            code.attributedPlaceholder = attributStr;
        }
        code.delegate = self;
        code.tag = 2017 + 5;
        code.keyboardType = UIKeyboardTypeNumberPad;
        
        UILabel *cityLabel = [[UILabel alloc] init];
        if (iPhone5) {
            cityLabel.frame = CGRectMake(0, 0, 60, 30);
        }else{
            cityLabel.frame = CGRectMake(0, 0, 80, 30);
        }
        [self addSubview:cityLabel];
        cityLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        cityLabel.font = [UIFont systemFontOfSize:17];
        cityLabel.textAlignment = NSTextAlignmentCenter;
        cityLabel.text = @"验证码";
        code.leftView = cityLabel;
        code.leftViewMode = UITextFieldViewModeAlways;
        
        //获取验证码按钮
        GRCountDownBtn *codeBtn = [GRCountDownBtn buttonWithType:UIButtonTypeCustom];
        [self addSubview:codeBtn];
        [codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        codeBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        codeBtn.layer.cornerRadius = 5.0f;
        codeBtn.layer.masksToBounds = YES;
        [codeBtn addTarget:self action:@selector(getBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        codeBtn.backgroundColor = [UIColor colorWithHexString:@"#00a0e9"];
        
        //下一步按钮
        UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        nextBtn.backgroundColor = [UIColor colorWithHexString:@"#f39800"];
        nextBtn.layer.masksToBounds = YES;
        nextBtn.layer.cornerRadius = 10;
        [nextBtn addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:nextBtn];
        
        //约束
//        [tip mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.equalTo(self);
//            make.top.equalTo(self).offset(5);
//            make.height.equalTo(@30);
//        }];
        
        [cardNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(13);
            make.top.equalTo(self).offset(5);
            make.right.equalTo(self).offset(-13);
            make.height.equalTo(@44);
        }];
        
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(13);
            make.top.equalTo(cardNum.mas_bottom).offset(5);
            make.right.equalTo(self).offset(-13);
            make.height.equalTo(@44);
        }];
        
        [money mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(13);
            make.top.equalTo(name.mas_bottom).offset(5);
            make.right.equalTo(self).offset(-13);
            make.height.equalTo(@44);
        }];
        
        [password mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(13);
            make.top.equalTo(money.mas_bottom).offset(5);
            make.right.equalTo(self).offset(-13);
            make.height.equalTo(@44);
        }];
        
        [code mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(13);
            make.top.equalTo(password.mas_bottom).offset(5);
            if (iPhone5) {
                make.width.equalTo(@190);
            }else{
                make.right.equalTo(codeBtn.mas_left).offset(-13);
            }
            make.height.equalTo(@44);
        }];
        
        [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(code.mas_right).offset(8);
            make.centerY.equalTo(code.mas_centerY);
            make.right.equalTo(self).offset(-13);
            make.height.equalTo(@45);
        }];
        
        [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(code.mas_bottom).offset(13);
            make.height.equalTo(@44);
            make.width.equalTo(@(K_Screen_Width - 26));
        }];
    }
    return self;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(gr_withDrawView:didEndEditing:)]) {
        [self.delegate gr_withDrawView:self didEndEditing:textField];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.bankCardFiled) {
        NSString *text = textField.text;
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        }
        text = [text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *newString = @"";
        while (text.length > 0) {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4) {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        // 限制长度
        if (newString.length >= 24) {
            return NO;
        }
        textField.text = newString;
        return NO;
    }else{
        return YES;
    }
}

///点击下一步按钮
- (void)nextClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(gr_withDrawView:didClickNextButton:)]) {
        [self.delegate gr_withDrawView:self didClickNextButton:btn];
    }
}

///获取验证码按钮
- (void)getBtnAction:(GRCountDownBtn *)btn{
    btn.enabled = NO;
    btn.backgroundColor = GRColor(224, 224, 224);
    //设置按钮的倒计时
    [btn startWithSecond:120];
    [btn didChange:^NSString *(GRCountDownBtn *countDownButton, int second) {
        NSString *title = [NSString stringWithFormat:@"%d秒重新获取",second];
        return title;
    }];
    [btn didFinished:^NSString *(GRCountDownBtn *countDownButton, int second) {
        countDownButton.enabled = YES;
        btn.backgroundColor = [UIColor colorWithHexString:@"#d43c33"];
        return @"点击重新获取";
    }];
    if ([self.delegate respondsToSelector:@selector(gr_getCodeBtnClick:)]) {
        [self.delegate gr_getCodeBtnClick:btn];
    }

}

@end
