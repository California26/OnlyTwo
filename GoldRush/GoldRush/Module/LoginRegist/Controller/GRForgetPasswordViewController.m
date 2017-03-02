//
//  GRForgetPasswordViewController.m
//  GoldRush
//
//  Created by Jack on 2016/12/21.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRForgetPasswordViewController.h"

#import "GRCountDownBtn.h"

@interface GRForgetPasswordViewController ()<UITextFieldDelegate>
///电话号的输入框
@property (nonatomic, weak) UITextField *phone;
///验证码的输入框
@property (nonatomic, weak) UITextField *captcha;
///密码的输入框
@property (nonatomic, weak) UITextField *password;
///重复密码输入框
@property (nonatomic, weak) UITextField *repeatPassword;
///获取验证码按钮
@property (nonatomic, weak) GRCountDownBtn *getCaptchaBtn;
///确认按钮
@property (nonatomic, weak) UIButton *affirmBtn;
///是否在获取验证码
@property (nonatomic, assign) BOOL isTime;
@end

@implementation GRForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加子控件
    [self setUpChildControl];
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)setUpChildControl{
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = mainColor;
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(64);
    }];
    
    UILabel *title = [[UILabel alloc] init];
    [topView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView).offset(20);
        make.left.equalTo(topView).offset(100);
        make.right.equalTo(topView).offset(-100);
        make.height.mas_equalTo(44);
    }];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"忘记密码";
    title.font = [UIFont systemFontOfSize:18    ];
    title.textColor = [UIColor colorWithHexString:@"#ffffff"];
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [topView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).offset(13);
        make.height.and.with.equalTo(@44);
        make.top.equalTo(topView).offset(20);
    }];
    [backBtn setImage:[UIImage imageNamed:@"Back_Btn"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    
//    UIView *background = [[UIView alloc] init];
//    [self.view addSubview:background];
    //手机号输入框
    UITextField *phoneField = [[UITextField alloc] init];
    [self.view addSubview:phoneField];
    self.phone = phoneField;
    [phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom).offset(30);
        make.left.equalTo(self.view).offset(27);
        make.right.equalTo(self.view);
        make.height.equalTo(@45);
    }];
    phoneField.placeholder = @"请输入手机号";
    phoneField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:phoneField.placeholder attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13], NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#999999"]}];
    phoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    phoneField.delegate = self;
    
    //验证码输入框
    UITextField *captchaField = [[UITextField alloc] init];
    [self.view addSubview:captchaField];
    captchaField.delegate = self;
    self.captcha = captchaField;
    [captchaField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneField.mas_bottom);
        make.left.equalTo(self.view).offset(27);
        make.height.equalTo(@45);
    }];
    captchaField.placeholder = @"短信验证码";
    captchaField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:captchaField.placeholder attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13], NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#999999"]}];
    captchaField.clearButtonMode = UITextFieldViewModeWhileEditing;
    captchaField.keyboardType = UIKeyboardTypeNumberPad;
    
    //获取验证码按钮
    GRCountDownBtn *getCaptcha = [GRCountDownBtn buttonWithType:UIButtonTypeCustom];
    self.getCaptchaBtn = getCaptcha;
    [getCaptcha setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCaptcha addTarget:self action:@selector(getCaptchaClick:) forControlEvents:UIControlEventTouchUpInside];
    [getCaptcha setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    getCaptcha.titleLabel.font = [UIFont systemFontOfSize:15];
    getCaptcha.layer.cornerRadius = 10;
    getCaptcha.layer.masksToBounds = YES;
    getCaptcha.backgroundColor = GRColor(224, 224, 224);
    [self.view addSubview:getCaptcha];
    [getCaptcha mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-20);
        make.centerY.equalTo(captchaField);
        make.width.equalTo(@105);
        make.height.equalTo(@40);
    }];
    
    [captchaField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(getCaptcha.mas_left).offset(-15);
    }];
    
    //密码输入框
    UITextField *passwordField = [[UITextField alloc] init];
    [self.view addSubview:passwordField];
    [passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(captchaField.mas_bottom);
        make.left.equalTo(self.view).offset(27);
        make.right.equalTo(self.view);
        make.height.equalTo(@45);
    }];
    self.password = passwordField;
    passwordField.delegate = self;
    passwordField.placeholder = @"设置新密码(6-20位字母与数字组合)";
    passwordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:passwordField.placeholder attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13], NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#999999"]}];
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordField.secureTextEntry = YES;
    
    //密码输入框
    UITextField *repeatField = [[UITextField alloc] init];
    [self.view addSubview:repeatField];
    [repeatField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(passwordField.mas_bottom);
        make.left.equalTo(self.view).offset(27);
        make.right.equalTo(self.view);
        make.height.equalTo(@45);
    }];
    self.repeatPassword = repeatField;
    repeatField.delegate = self;
    repeatField.placeholder = @"重复密码";
    repeatField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:repeatField.placeholder attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13], NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#999999"]}];
    repeatField.clearButtonMode = UITextFieldViewModeWhileEditing;
    repeatField.secureTextEntry = YES;
    
    //登陆按钮
    UIButton *affirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:affirmBtn];
    [affirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(repeatField.mas_bottom).offset(24);
        make.width.equalTo(@270);
        make.height.equalTo(@44);
        make.centerX.equalTo(self.view);
    }];
    self.affirmBtn = affirmBtn;
    [affirmBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    affirmBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [affirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [affirmBtn addTarget:self action:@selector(affirmClick:) forControlEvents:UIControlEventTouchUpInside];
    affirmBtn.backgroundColor = GRColor(224, 224, 224);
    affirmBtn.layer.cornerRadius = 10;
    affirmBtn.layer.masksToBounds = YES;
}

#pragma mark - 按钮点击事件
//返回点击事件
- (void)backClick:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//点击确认登陆按钮
- (void)affirmClick:(UIButton *)btn{
    [self.view endEditing:YES];
    if ([GRUtils validateMobilePhone:self.phone.text] == NO) {
        [SVProgressHUD showErrorWithStatus:@"手机号码格式错误!"];
    }else if (self.password.text.length < 6){
        [SVProgressHUD showErrorWithStatus:@"密码长度不足6位!"];
    }else if(![self.password.text isEqualToString:self.repeatPassword.text]){
        [SVProgressHUD showErrorWithStatus:@"两次密码输入不一致!"];
    }else{
        //发送请求注册
        GRLog(@"注册成功!");
    }
}

//获取验证码
- (void)getCaptchaClick:(GRCountDownBtn *)btn{
    if ([self.phone.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空!"];
        return;
    }else if (![GRUtils validateMobilePhone:self.phone.text]){
        [SVProgressHUD showErrorWithStatus:@"手机号格式错误!"];
        return;
    }else{
        GRLog(@"获取验证码请求!!!");
        __weak GRForgetPasswordViewController *forgetVC = self;
        btn.enabled = NO;
        btn.backgroundColor = GRColor(224, 224, 224);
        //设置按钮的倒计时
        [btn startWithSecond:60];
        [btn didChange:^NSString *(GRCountDownBtn *countDownButton, int second) {
            forgetVC.isTime = YES;
            NSString *title = [NSString stringWithFormat:@"%d秒重新获取",second];
            return title;
        }];
        [btn didFinished:^NSString *(GRCountDownBtn *countDownButton, int second) {
            countDownButton.enabled = YES;
            btn.backgroundColor = [UIColor colorWithHexString:@"#d43c33"];
            forgetVC.isTime = NO;
            return @"点击重新获取";
        }];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.text.length || ![string isEqualToString:@""]) {
        if (textField.text.length == 1 && [string isEqualToString:@""]) {   //长度为1且为空时
            if (textField == self.phone) {
                self.getCaptchaBtn.enabled = NO;
            }else{
                self.getCaptchaBtn.enabled = YES;
            }
            self.affirmBtn.enabled = NO;
        }else{
            if (self.isTime) {  //正在获取验证码
                self.getCaptchaBtn.enabled = NO;
            }else{
                self.getCaptchaBtn.enabled = YES;
            }
            if (textField == self.phone) {
                if (self.phone.text.length == 0 ||
                    self.captcha.text.length == 0 ||
                    self.password.text.length == 0 ||
                    self.repeatPassword.text.length == 0) {
                    self.affirmBtn.enabled = NO;
                }else{
                    self.affirmBtn.enabled = YES;
                }
            }else if (textField == self.captcha){
                if (self.phone.text.length == 0 ||
                    self.captcha.text.length == 0 ||
                    self.password.text.length == 0 ||
                    self.repeatPassword.text.length == 0) {
                    self.affirmBtn.enabled = NO;
                }else{
                    self.affirmBtn.enabled = YES;
                }
            }else if (textField == self.password){
                if (self.phone.text.length == 0 ||
                    self.captcha.text.length == 0 ||
                    self.password.text.length == 0 ||
                    self.repeatPassword.text.length == 0) {
                    self.affirmBtn.enabled = NO;
                }else{
                    self.affirmBtn.enabled = YES;
                }
            }else{
                if (self.phone.text.length == 0 ||
                    self.captcha.text.length == 0 ||
                    self.password.text.length == 0 ||
                    self.repeatPassword.text.length == 0) {
                    self.affirmBtn.enabled = NO;
                }else{
                    self.affirmBtn.enabled = YES;
                }
            }
        }
    }
    //改变注册按钮的颜色
    [self changeRegisterButtonColor];
    //改变获取验证码按钮的颜色
    [self changeCaptchaButtonColor];
    return YES;
}
#pragma mark - 改变注册按钮的颜色
- (void)changeRegisterButtonColor {
    if (self.affirmBtn.enabled) {
        self.affirmBtn.backgroundColor = mainColor;
    } else {
        self.affirmBtn.backgroundColor = GRColor(224, 224, 224);
    }
}

//改变获取验证码按钮的颜色
- (void)changeCaptchaButtonColor{
    if (self.getCaptchaBtn.enabled) {
        self.getCaptchaBtn.backgroundColor = mainColor;
    } else {
        self.getCaptchaBtn.backgroundColor = GRColor(224, 224, 224);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


@end
