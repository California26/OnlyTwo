//
//  GRJJRegisterView.m
//  GoldRush
//
//  Created by Jack on 2017/2/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRJJRegisterView.h"

@interface GRJJRegisterView ()<UITextFieldDelegate>

@end

@implementation GRJJRegisterView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //设置 UI
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI{
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height/3)];
    iconView.image = [UIImage imageNamed:@"HPME_Exchange"];
    [self addSubview:iconView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(13, CGRectGetMaxY(iconView.frame), K_Screen_Width-15*2, 47)];
    label.text = @"手机号将与交易所绑定以进行交易";
    label.textColor = [UIColor colorWithHexString:@"#333333"];
    label.font = [UIFont systemFontOfSize:15];
    [self addSubview:label];
    
    ///手机号
    UITextField *phone = [[UITextField alloc] initWithFrame:CGRectMake(13, CGRectGetMaxY(label.frame), CGRectGetWidth(label.frame), 45)];
    phone.borderStyle = UITextBorderStyleRoundedRect;
    phone.text = [GRUserDefault getUserPhone];
    phone.enabled = NO;
    [self addSubview:phone];
    
    UITextField *code = [[UITextField alloc] initWithFrame:CGRectMake(13, CGRectGetMaxY(phone.frame) + 10, CGRectGetWidth(label.frame), 45)];
    code.placeholder = @"请输入验证码";
    code.textColor = [UIColor colorWithHexString:@"#cccccc"];
    code.keyboardType = UIKeyboardTypeNumberPad;
    code.clearButtonMode = UITextFieldViewModeWhileEditing;
    code.borderStyle = UITextBorderStyleRoundedRect;
    code.delegate = self;
    code.tag = 896;
    code.returnKeyType = UIReturnKeyDone;
    [self addSubview:code];
    
    UITextField *passWord = [[UITextField alloc] initWithFrame:CGRectMake(13, CGRectGetMaxY(code.frame) + 10, CGRectGetWidth(label.frame), 45)];
    passWord.placeholder = @"请输入6位数字密码";
    passWord.textColor = [UIColor colorWithHexString:@"#cccccc"];
    passWord.keyboardType = UIKeyboardTypeNumberPad;
    passWord.clearButtonMode = UITextFieldViewModeWhileEditing;
    passWord.secureTextEntry = YES;
    passWord.borderStyle = UITextBorderStyleRoundedRect;
    passWord.delegate = self;
    passWord.returnKeyType = UIReturnKeyDone;
    passWord.tag = 897;
    [self addSubview:passWord];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(passWord.frame) + 10, K_Screen_Width/3*2, 18)];
    label1.textColor = [UIColor colorWithHexString:@"#333333"];
    label1.text = @"点击注册即表示同意本交易所";
    label1.font = [UIFont systemFontOfSize:12];
    label1.textAlignment = NSTextAlignmentRight;
    [self addSubview:label1];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(CGRectGetMaxX(label1.frame), CGRectGetMinY(label1.frame), 60, CGRectGetHeight(label1.frame));
    [button setTitle:@"用户协议" forState:UIControlStateNormal];
    button.titleLabel.textColor = [UIColor colorWithHexString:@"#3d7aeb"];
    [button setTitleColor:[UIColor colorWithHexString:@"#3d7aeb"] forState:UIControlStateNormal];
    button.titleLabel.font = label1.font;
    [button addTarget:self action:@selector(buttonUserProtocol:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    UIButton *regButton = [UIButton buttonWithType:UIButtonTypeCustom];
    regButton.frame = CGRectMake(15, CGRectGetMaxY(button.frame) + 10, K_Screen_Width-30, 44);
    [regButton setTitle:@"立即注册" forState:UIControlStateNormal];
    regButton.backgroundColor = mainColor;
    [regButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    regButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [regButton addTarget:self action:@selector(regButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    regButton.layer.cornerRadius = 5.0f;
    regButton.layer.masksToBounds = YES;
    [self addSubview:regButton];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(regButton.frame)+25, K_Screen_Width, 18)];
    label2.textColor = [UIColor colorWithHexString:@"#d43c33"];
    label2.text = @"一个交易所账户只能注册一个手机号";
    label2.font = label1.font;
    label2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label2.frame)+7, K_Screen_Width, 18)];
    label3.text = @"(如果于其他平台注册过本次交易所，将无法再注册)";
    label3.textColor = [UIColor colorWithHexString:@"#999999"];
    label3.font = label2.font;
    label3.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label3];

}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(JJ_getPasswordTextEndWithTextField:)]) {
        [self.delegate JJ_getPasswordTextEndWithTextField:textField];
    }
    return YES;
}


- (void)buttonUserProtocol:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(JJ_protocolClick:withProtocolBtn:)]) {
        [self.delegate JJ_protocolClick:self withProtocolBtn:sender];
    }
}

///注册按钮点击
- (void)regButtonAction:(UIButton *)sender{
    [self endEditing:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(JJ_registerClick:withRegisterBtn:)]) {
        [self.delegate JJ_registerClick:self withRegisterBtn:sender];
    }
}


@end
