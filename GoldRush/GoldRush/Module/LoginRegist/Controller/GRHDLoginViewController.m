//
//  GRHDLoginViewController.m
//  GoldRush
//
//  Created by Jack on 2017/1/18.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRHDLoginViewController.h"
#import "GRHDLogin.h"                   ///登陆
#import "GRSetPasswordViewController.h" ///设置密码

@interface GRHDLoginViewController ()<GRHDLoginDelegate>

@property (nonatomic, strong) GRHDLogin *loginView;
@property (nonatomic, copy) NSString *password;

@end

@implementation GRHDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置 UI
    [self setupUI];
}

#pragma mark - 设置头视图
- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"Back_Btn"] forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 24, 40, 34);
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, K_Screen_Width, 34)];
    label.text = @"恒大登陆";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithHexString:@"#ffffff"];
    label.font = [UIFont systemFontOfSize:20];
    label.backgroundColor = [UIColor clearColor];
    
    _loginView = [[GRHDLogin alloc] initWithFrame:self.view.bounds];
    _loginView.delegate = self;
    
    [self.view addSubview:_loginView];
    [self.view addSubview:button];
    [self.view addSubview:label];
}

#pragma mark - event response
- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:GRAccountIsLoginNotification object:@{@"isRequest":@"NO"}];
}

#pragma mark - GRHDLoginDelegate
- (void)HD_forgetClick:(GRHDLogin *)loginView withForgetBtn:(UIButton *)btn{
    GRSetPasswordViewController *setPasswordVC = [[GRSetPasswordViewController alloc] init];
    [self presentViewController:setPasswordVC animated:YES completion:nil];
}

- (void)HD_loginClick:(GRHDLogin *)loginView withLoginBtn:(UIButton *)btn{
    //登陆恒大
    [self.view endEditing:YES];
    [SVProgressHUD show];
    NSDictionary *parameter = @{@"r":@"baibei/user/login",
                                @"password":self.password,
                                @"mobile":[GRUserDefault getUserPhone]};
    [GRNetWorking postWithURLString:@"?r=baibei/user/login" parameters:parameter callBack:^(NSDictionary *dict) {
        NSString *code = dict[@"status"];
        if (code.integerValue == HttpSuccess) {
            [GRUserDefault setKey:@"isLoginHD" Value:@(YES)];
            [GRUserDefault setKey:@"isRegistHD" Value:@(YES)];
            [[NSNotificationCenter defaultCenter] postNotificationName:GRAccountIsLoginNotification object:@{@"isRequest":@"YES"}];
            [SVProgressHUD showSuccessWithStatus:@"恒大登陆成功"];
            [SVProgressHUD dismiss];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
    }];
}

- (void)HD_getPasswordTextEndWithTextField:(UITextField *)field{
    self.password = field.text;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
