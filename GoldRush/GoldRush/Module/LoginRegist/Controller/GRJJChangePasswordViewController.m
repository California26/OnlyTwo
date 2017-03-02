//
//  GRChangePasswordViewController.m
//  GoldRush
//
//  Created by Jack on 2017/2/7.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRJJChangePasswordViewController.h"
#import "GRJJLoginViewController.h"

@interface GRJJChangePasswordViewController ()<UITextFieldDelegate>

///验证码
@property (nonatomic, copy) NSString *code;
///密码
@property (nonatomic, copy) NSString *password;

@property (nonatomic, weak) UITextField *codeField;
@property (nonatomic, weak) UITextField *passwordField;

@end

@implementation GRJJChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

#pragma mark - 设置头视图
- (void)setupUI{
    
    [self creatChildView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"Back_Btn"] forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 24, 40, 34);
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, K_Screen_Width, 34)];
    label.text = @"修改吉交所密码";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithHexString:@"#ffffff"];
    label.font = [UIFont systemFontOfSize:20];
    label.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:button];
    [self.view addSubview:label];
    
}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)creatChildView{
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height/3)];
    iconView.image = [UIImage imageNamed:@"HPME_Exchange"];
    [self.view addSubview:iconView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(13, CGRectGetMaxY(iconView.frame), K_Screen_Width-15*2, 47)];
    label.text = @"吉交所重新设置交易密码";
    label.textColor = [UIColor colorWithHexString:@"#333333"];
    label.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label];
    
    ///手机号
    UITextField *phone = [[UITextField alloc] initWithFrame:CGRectMake(13, CGRectGetMaxY(label.frame), CGRectGetWidth(label.frame), 45)];
    phone.borderStyle = UITextBorderStyleRoundedRect;
    phone.text = [GRUserDefault getUserPhone];
    phone.enabled = NO;
    [self.view addSubview:phone];
    
    UITextField *code = [[UITextField alloc] initWithFrame:CGRectMake(13, CGRectGetMaxY(phone.frame) + 10, CGRectGetWidth(label.frame), 45)];
    self.codeField = code;
    code.placeholder = @"请输入验证码";
    code.textColor = [UIColor colorWithHexString:@"#cccccc"];
    code.keyboardType = UIKeyboardTypeNumberPad;
    code.clearButtonMode = UITextFieldViewModeWhileEditing;
    code.borderStyle = UITextBorderStyleRoundedRect;
    code.delegate = self;
    code.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:code];
    
    UITextField *passWord = [[UITextField alloc] initWithFrame:CGRectMake(13, CGRectGetMaxY(code.frame) + 10, CGRectGetWidth(label.frame), 45)];
    self.passwordField = passWord;
    passWord.placeholder = @"请输入6位数字密码";
    passWord.textColor = [UIColor colorWithHexString:@"#cccccc"];
    passWord.keyboardType = UIKeyboardTypeNumberPad;
    passWord.clearButtonMode = UITextFieldViewModeWhileEditing;
    passWord.secureTextEntry = YES;
    passWord.borderStyle = UITextBorderStyleRoundedRect;
    passWord.delegate = self;
    passWord.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:passWord];
    
    UIButton *regButton = [UIButton buttonWithType:UIButtonTypeCustom];
    regButton.frame = CGRectMake(15, CGRectGetMaxY(passWord.frame) + 20, K_Screen_Width-30, 44);
    [regButton setTitle:@"确认修改" forState:UIControlStateNormal];
    regButton.backgroundColor = mainColor;
    [regButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    regButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [regButton addTarget:self action:@selector(affirmChangeAction:) forControlEvents:UIControlEventTouchUpInside];
    regButton.layer.cornerRadius = 5.0f;
    regButton.layer.masksToBounds = YES;
    [self.view addSubview:regButton];
    
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.view endEditing:YES];

    if (textField == self.codeField) {
        self.code = textField.text;
    }else if (textField == self.passwordField){
        self.password = textField.text;
    }
    
}

///确认修改按钮点击
- (void)affirmChangeAction:(UIButton *)sender{
    [self.view endEditing:YES];
    
    ///修改密码
    if (self.code && self.password) {
        NSDictionary *paramDict = @{@"r":@"jlmmex/user/resetPassword",
                                    @"mobile":[GRUserDefault getUserPhone],
                                    @"vcode":self.code,
                                    @"password":self.password};
        [GRNetWorking postWithURLString:@"?r=jlmmex/user/resetPassword" parameters:paramDict callBack:^(NSDictionary *dict) {
            NSNumber *code = dict[@"status"];
            if ([code isEqualToNumber:@(HttpSuccess)]) {
                [SVProgressHUD showInfoWithStatus:@"密码修改成功"];
                [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            }else if ([dict[@"message"] isEqualToString:@"jlmmex"]){
                GRJJLoginViewController *loginVC = [[GRJJLoginViewController alloc] init];
                [self presentViewController:loginVC animated:YES completion:nil];
                [GRUserDefault removeJJLogin];
            }else{
                [SVProgressHUD showInfoWithStatus:dict[@"message"]];
            }
        }];
    }
}


@end
