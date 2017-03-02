//
//  GRJJRegisterViewController.m
//  GoldRush
//
//  Created by Jack on 2017/2/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRJJTestGetCodeViewController.h"
#import "GRJJGetCodeView.h"                     ///获取验证码 view
#import "GRJJRegisterViewController.h"          ///注册控制器
#import "GRJJChangePasswordViewController.h"    ///修改密码

@interface GRJJTestGetCodeViewController ()<GRJJGetCodeViewDelegate>
@property (nonatomic, strong) GRJJGetCodeView *getCodeView;

///验证码
@property (nonatomic, copy) NSString *code;

///标题
@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation GRJJTestGetCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
    self.titleLabel = label;
    label.text = self.type;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithHexString:@"#ffffff"];
    label.font = [UIFont systemFontOfSize:20];
    label.backgroundColor = [UIColor clearColor];
    
    _getCodeView = [[GRJJGetCodeView alloc] initWithFrame:self.view.bounds];
    _getCodeView.delegate = self;
    
    [self.view addSubview:_getCodeView];
    [self.view addSubview:button];
    [self.view addSubview:label];
}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - GRJJRegisterDelegate
- (void)JJ_getCode:(GRJJGetCodeView *)view withTextField:(UITextField *)field{
    self.code = field.text;
}

- (void)JJ_getCodeClick:(GRJJGetCodeView *)registerView withGetCodeBtn:(UIButton *)btn{
    if (self.code) {
        if ([self.type isEqualToString:@"修改吉交所交易密码"]) {
            //找回密码验证码
            NSDictionary *dict = @{@"r":@"jlmmex/code/findPassword",
                                   @"mobile":[GRUserDefault getUserPhone],
                                   @"imageCode":self.code};
            [GRNetWorking postWithURLString:@"?r=jlmmex/code/findPassword" parameters:dict callBack:^(NSDictionary *dict) {
                NSString *code = dict[@"status"];
                if (code.integerValue == HttpSuccess) {
                    GRJJChangePasswordViewController *changeVC = [[GRJJChangePasswordViewController alloc] init];
                    [self presentViewController:changeVC animated:YES completion:nil];
                }else if ([dict[@"message"] isEqualToString:@"jlmmex"]){
                    GRJJLoginViewController *loginVC = [[GRJJLoginViewController alloc] init];
                    [self presentViewController:loginVC animated:YES completion:nil];
                    [GRUserDefault removeJJLogin];
                }else{
                    [SVProgressHUD showInfoWithStatus:dict[@"message"]];
                }
            }];
        }else{
            //获取短信验证码
            NSDictionary *paraDict = @{@"r":@"jlmmex/code/registerMessage",
                                       @"mobile":[GRUserDefault getUserPhone],
                                       @"imageCode":self.code};
            [GRNetWorking postWithURLString:@"?r=jlmmex/code/registerMessage" parameters:paraDict callBack:^(NSDictionary *dict) {
                NSString *code = dict[@"status"];
                if (code.integerValue == HttpSuccess) {
                    GRJJRegisterViewController *registerVC = [[GRJJRegisterViewController alloc] init];
                    [self presentViewController:registerVC animated:YES completion:nil];
                }else if ([dict[@"message"] isEqualToString:@"此手机号已经注册过"]){
                    [GRUserDefault setKey:@"isRegistJJ" Value:@(YES)];
                    [SVProgressHUD showInfoWithStatus:@"手机号已注册!请立即登录!"];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }else if ([dict[@"message"] isEqualToString:@"jlmmex"]){
                    GRJJLoginViewController *loginVC = [[GRJJLoginViewController alloc] init];
                    [self presentViewController:loginVC animated:YES completion:nil];
                    [GRUserDefault removeJJLogin];
                } else{
//                    [SVProgressHUD showInfoWithStatus:dict[@"message"]];
                    [SVProgressHUD showInfoWithStatus:@"图片验证码已过期"];
                }
            }];
        }
    }else{
        [SVProgressHUD showInfoWithStatus:@"请填写验证码"];
    }
}


@end
