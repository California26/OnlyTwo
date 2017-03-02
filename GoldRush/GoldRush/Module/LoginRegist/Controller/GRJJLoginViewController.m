//
//  GRJJLoginViewController.m
//  GoldRush
//
//  Created by Jack on 2017/2/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRJJLoginViewController.h"
#import "GRHDLogin.h"                   ///登陆
#import "GRJJTestGetCodeViewController.h"


@interface GRJJLoginViewController ()<GRHDLoginDelegate>

@property (nonatomic, strong) GRHDLogin *loginView;
@property (nonatomic, copy) NSString *password;

@end

@implementation GRJJLoginViewController

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
    label.text = @"吉交所登陆";
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
    GRJJTestGetCodeViewController *setPasswordVC = [[GRJJTestGetCodeViewController alloc] init];
    setPasswordVC.type = @"修改吉交所交易密码";
    [self presentViewController:setPasswordVC animated:YES completion:nil];
}

- (void)HD_loginClick:(GRHDLogin *)loginView withLoginBtn:(UIButton *)btn{
    //登陆吉交所
    [self.view endEditing:YES];
    [SVProgressHUD show];
    NSDictionary *parameter = @{@"r":@"jlmmex/oauth/login",
                                @"password":self.password,
                                @"mobile":[GRUserDefault getUserPhone]};
    [GRNetWorking postWithURLString:@"?r=jlmmex/oauth/login" parameters:parameter callBack:^(NSDictionary *dict) {
        NSString *code = dict[@"status"];
        if (code.integerValue == HttpSuccess) {
            [GRUserDefault setKey:@"isLoginJJ" Value:@(YES)];
            [GRUserDefault setKey:@"isRegistJJ" Value:@(YES)];
            [[NSNotificationCenter defaultCenter] postNotificationName:GRAccountIsLoginNotification object:@{@"isRequest":@"YES"}];
            [SVProgressHUD showSuccessWithStatus:@"吉交所登陆成功"];
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
