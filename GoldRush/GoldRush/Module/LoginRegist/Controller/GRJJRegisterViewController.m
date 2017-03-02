//
//  GRJJRegisterViewController.m
//  GoldRush
//
//  Created by Jack on 2017/2/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRJJRegisterViewController.h"
#import "GRJJRegisterView.h"                    ///注册 view


@interface GRJJRegisterViewController ()<GRJJRegisterViewDelegate>

///注册 view
@property (nonatomic, strong) GRJJRegisterView *registerView;
///记录密码
@property (nonatomic, copy) NSString *passWord;
///记录验证码
@property (nonatomic, copy) NSString *code;

@end

@implementation GRJJRegisterViewController

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
    label.text = @"吉交所注册";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithHexString:@"#ffffff"];
    label.font = [UIFont systemFontOfSize:20];
    label.backgroundColor = [UIColor clearColor];
    
    _registerView = [[GRJJRegisterView alloc] initWithFrame:self.view.bounds];
    _registerView.delegate = self;
    
    [self.view addSubview:_registerView];
    [self.view addSubview:button];
    [self.view addSubview:label];
}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - GRJJRegisterViewDelegate
- (void)JJ_getPasswordTextEndWithTextField:(UITextField *)field{
    if (field.tag == 897) {
        self.passWord = field.text;
    }else if(field.tag == 896){
        self.code = field.text;
    }
}

- (void)JJ_protocolClick:(GRJJRegisterView *)registerView withProtocolBtn:(UIButton *)btn{

}

- (void)JJ_registerClick:(GRJJRegisterView *)registerView withRegisterBtn:(UIButton *)btn{
    ///吉交所注册
    NSDictionary *paraDict = @{@"r":@"jlmmex/register/do",
                               @"mobile":[GRUserDefault getUserPhone],
                               @"vcode":self.code,
                               @"password":self.passWord};
    [GRNetWorking postWithURLString:@"?r=jlmmex/register/do" parameters:paraDict callBack:^(NSDictionary *dict) {
        NSNumber *code = dict[@"status"];
        if ([code isEqualToNumber:@(HttpSuccess)]) {
            [GRUserDefault setKey:@"isRegistJJ" Value:@(YES)];
            [SVProgressHUD showInfoWithStatus:@"成功注册吉交所"];
            ///吉交所登陆
            NSDictionary *paramDict = @{@"r":@"jlmmex/oauth/login",
                                        @"mobile":[GRUserDefault getUserPhone],
                                        @"password":self.passWord};
            [GRNetWorking postWithURLString:@"?r=jlmmex/oauth/login" parameters:paramDict callBack:^(NSDictionary *dict) {
                NSString *code = dict[@"status"];
                if (code.integerValue == HttpSuccess) {
                    [GRUserDefault setKey:@"isLoginJJ" Value:@(YES)];
                    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
                }else{
                    [SVProgressHUD showInfoWithStatus:dict[@"message"]];
                }
            }];
        }else if ([code isEqualToNumber:@300]){
            [SVProgressHUD showInfoWithStatus:@"验证码过期"];
        }
    }];
}

@end
