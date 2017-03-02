//
//  GRRegisterViewController.m
//  GoldRush
//
//  Created by Jack on 2016/12/20.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRRegisterViewController.h"

///协议控制器
#import "GRProtocolViewController.h"

///倒计时按钮
#import "GRCountDownBtn.h"

@interface GRRegisterViewController ()<UITextFieldDelegate>
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
///注册按钮
@property (nonatomic, weak) UIButton *registerBtn;
///是否在获取验证码
@property (nonatomic, assign) BOOL isTime;

///是否遵守协议
@property (nonatomic, assign) BOOL isSelected;


@end

@implementation GRRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
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
    title.text = @"注册";
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
    
    //手机号输入框
    UITextField *phoneField = [[UITextField alloc] init];
    [self.view addSubview:phoneField];
    self.phone = phoneField;
    phoneField.delegate = self;
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
    getCaptcha.enabled = NO;
    [getCaptcha addTarget:self action:@selector(getCaptchaClick:) forControlEvents:UIControlEventTouchUpInside];
    [getCaptcha setTitle:@"获取验证码" forState:UIControlStateNormal];
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
    passwordField.delegate = self;
    [passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(captchaField.mas_bottom);
        make.left.equalTo(self.view).offset(27);
        make.right.equalTo(self.view);
        make.height.equalTo(@45);
    }];
    self.password = passwordField;
    passwordField.secureTextEntry = YES;
    passwordField.placeholder = @"设置密码(6-20位字母与数字组合)";
    passwordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:passwordField.placeholder attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13], NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#999999"]}];
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;

    //重复密码输入框
    UITextField *repeatField = [[UITextField alloc] init];
    repeatField.delegate = self;
    [self.view addSubview:repeatField];
    [repeatField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(passwordField.mas_bottom);
        make.left.equalTo(self.view).offset(27);
        make.right.equalTo(self.view);
        make.height.equalTo(@45);
    }];
    self.repeatPassword = repeatField;
    repeatField.secureTextEntry = YES;
    repeatField.placeholder = @"重复密码";
    repeatField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:repeatField.placeholder attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13], NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#999999"]}];
    repeatField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    //注册按钮
    UIButton *affirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerBtn = affirmBtn;
    [self.view addSubview:affirmBtn];
    [affirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(repeatField.mas_bottom).offset(24);
        make.width.equalTo(@270);
        make.height.equalTo(@44);
        make.centerX.equalTo(self.view);
    }];
    
    [affirmBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    affirmBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [affirmBtn setTitle:@"注册" forState:UIControlStateNormal];
    [affirmBtn addTarget:self action:@selector(affirmClick:) forControlEvents:UIControlEventTouchUpInside];
    affirmBtn.backgroundColor = GRColor(224, 224, 224);
    affirmBtn.enabled = NO;
    affirmBtn.layer.cornerRadius = 10;
    affirmBtn.layer.masksToBounds = YES;
    
    //底部view
    UIView *bottomView = [[UIView alloc] init];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(affirmBtn.mas_bottom).offset(24);
        make.height.equalTo(@25);
    }];

    UIButton *select = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomView addSubview:select];
    UIImage *image = [UIImage imageNamed:@"Reg_Round"];
    CGFloat top = 2; // 顶端盖高度
    CGFloat bottom = 2; // 底端盖高度
    CGFloat left = 2; // 左端盖宽度
    CGFloat right = 2; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeTile];
    
    select.selected = YES;
    self.isSelected = select.selected;
    [select setBackgroundImage:image forState:UIControlStateNormal];
    [select setBackgroundImage:image forState:UIControlStateSelected];
    select.adjustsImageWhenHighlighted = NO;
    select.imageView.contentMode = UIViewContentModeCenter;
    [select setImage:[UIImage imageNamed:@"Reg_Right"] forState:UIControlStateSelected];
    [select addTarget:self action:@selector(selectedBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //说明
    UILabel *desc = [[UILabel alloc] init];
    desc.text = @"我已同意并阅读";
    desc.textColor = [UIColor colorWithHexString:@"#666666"];
    desc.font = [UIFont systemFontOfSize:12];
    desc.textAlignment = NSTextAlignmentRight;
    [bottomView addSubview:desc];
    
    UIButton *deal = [UIButton buttonWithType:UIButtonTypeCustom];
    [deal setTitle:@"<<全民淘金贵金属服务协议>>" forState:UIControlStateNormal];
    [deal setTitleColor:[UIColor colorWithHexString:@"#3d7aeb"] forState:UIControlStateNormal];
    deal.titleLabel.textAlignment = NSTextAlignmentLeft;
    [deal addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    deal.titleLabel.font = [UIFont systemFontOfSize:12];
    [bottomView addSubview:deal];
    deal.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    [select mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.left.equalTo(bottomView.mas_left);
        make.right.equalTo(desc.mas_left).offset(-5);
        make.width.and.height.equalTo(@14);
    }];
    [desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.left.equalTo(select.mas_right).offset(5);
        make.right.equalTo(deal.mas_left);
        make.height.equalTo(bottomView.mas_height);
    }];
    [deal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.left.equalTo(desc.mas_right);
        make.right.equalTo(bottomView.mas_right);
        make.height.equalTo(bottomView.mas_height);
    }];
}

#pragma mark - 按钮点击事件
//返回点击事件
- (void)backClick:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//点击确认注册按钮
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
        [GRNetWorking postWithURLString:@"user/encode" parameters:@{@"mid":@"12",@"mobile":@"18588888888",@"type":@"rg"}  callBack:^(NSDictionary *dict) {
             GRLog(@"%@",dict[@"description"]);
        }];
    }
}

//点击选择按钮
- (void)selectedBtn:(UIButton *)btn{
    [self.view endEditing:YES];
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        self.isSelected = YES;
        self.registerBtn.enabled = YES;
        [self changeRegisterButtonColor];
    }else{
        self.isSelected = NO;
        self.registerBtn.enabled = NO;
        [self changeRegisterButtonColor];
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
        __weak GRRegisterViewController *registerVC = self;
        btn.enabled = NO;
        btn.backgroundColor = GRColor(224, 224, 224);
        //设置按钮的倒计时
        [btn startWithSecond:60];
        [btn didChange:^NSString *(GRCountDownBtn *countDownButton, int second) {
            registerVC.isTime = YES;
            NSString *title = [NSString stringWithFormat:@"%d秒重新获取",second];
            return title;
        }];
        [btn didFinished:^NSString *(GRCountDownBtn *countDownButton, int second) {
            countDownButton.enabled = YES;
            btn.backgroundColor = [UIColor colorWithHexString:@"#d43c33"];
            registerVC.isTime = NO;
            return @"点击重新获取";
        }];
    }
}

//点击协议按钮
- (void)btnClick:(UIButton *)btn{
    [self.view endEditing:YES];
    GRProtocolViewController *protocol = [[GRProtocolViewController alloc] init];
    [self presentViewController:protocol animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
            self.registerBtn.enabled = NO;
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
                    self.repeatPassword.text.length == 0 ||
                    !self.isSelected) {
                    self.registerBtn.enabled = NO;
                }else{
                    self.registerBtn.enabled = YES;
                }
            }else if (textField == self.captcha){
                if (self.phone.text.length == 0 ||
                    self.captcha.text.length == 0 ||
                    self.password.text.length == 0 ||
                    self.repeatPassword.text.length == 0 ||
                    !self.isSelected) {
                    self.registerBtn.enabled = NO;
                }else{
                    self.registerBtn.enabled = YES;
                }
            }else if (textField == self.password){
                if (self.phone.text.length == 0 ||
                    self.captcha.text.length == 0 ||
                    self.password.text.length == 0 ||
                    self.repeatPassword.text.length == 0 ||
                    !self.isSelected) {
                    self.registerBtn.enabled = NO;
                }else{
                    self.registerBtn.enabled = YES;
                }
            }else{
                if (self.phone.text.length == 0 ||
                    self.captcha.text.length == 0 ||
                    self.password.text.length == 0 ||
                    self.repeatPassword.text.length == 0 ||
                    !self.isSelected) {
                    self.registerBtn.enabled = NO;
                }else{
                    self.registerBtn.enabled = YES;
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
    if (self.registerBtn.enabled) {
        self.registerBtn.backgroundColor = mainColor;
    } else {
        self.registerBtn.backgroundColor = GRColor(224, 224, 224);
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

@end
