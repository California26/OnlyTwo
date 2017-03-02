//
//  GRSetPasswordViewController.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/9.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRSetPasswordViewController.h"
#import "GRSetPasswordScrollView.h"         //设置交易密码 view
#import "GRProtocolViewController.h"        //协议控制器

@interface GRSetPasswordViewController ()<UIScrollViewDelegate,GRSetPasswordScrollViewDelegate>

@property (nonatomic,strong) GRSetPasswordScrollView *scrollView;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *code;

@end

@implementation GRSetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加 UI
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
    label.text = @"设置恒大交易密码";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithHexString:@"#ffffff"];
    label.font = [UIFont systemFontOfSize:20];
    label.backgroundColor = [UIColor clearColor];
    _scrollView = [[GRSetPasswordScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.delegate = self;
    _scrollView.passwordDelegate = self;
    [self.view addSubview:self.scrollView];
    [self.view addSubview:button];
    [self.view addSubview:label];
}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark setPasswordDelegate
- (void)getPasswordTextBeginWithTextField:(UITextField *)sender{
    
}

- (void)getPasswordTextEndWithTextField:(UITextField *)sender{
    if (sender.tag == 4679) {
        self.password = sender.text;
    }else if (sender.tag == 4678){
        self.code = sender.text;
    }
}

- (void)JJ_getCode:(GRSetPasswordScrollView *)view didClickGetCodeBtn:(UIButton *)btn{
    
    //获取验证码
    NSDictionary *dict = @{@"r":@"baibei/user/getCode",
                           @"mobile":[GRUserDefault getUserPhone]};
    [GRNetWorking postWithURLString:@"?r=baibei/user/getCode" parameters:dict callBack:^(NSDictionary *dict) {
        NSString *code = dict[@"status"];
        if ([code integerValue] == HttpSuccess) {
            
        }else if([dict[@"message"] isEqualToString:@"baibei"]){
            [GRUserDefault removeHDLogin];
            GRHDLoginViewController *loginHD = [[GRHDLoginViewController alloc] init];
            [self presentViewController:loginHD animated:YES completion:nil];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
    }];
}

//协议按钮
- (void)userProtocol{
    GRProtocolViewController *protpcolVC = [[GRProtocolViewController alloc] init];
    protpcolVC.text = @"用户协议";
    protpcolVC.url = @"https://www.google.com";
    [self presentViewController:protpcolVC animated:YES completion:nil];
}

//修改密码
- (void)updatePasswordAction{
    
    [self.scrollView endEditing:YES];
    
    //修改恒大密码
    NSDictionary *parameter = @{@"r":@"baibei/user/modifyPassword",
                                @"password":self.password,
                                @"mobile":[GRUserDefault getUserPhone],
                                @"vcode":self.code};
    [GRNetWorking postWithURLString:@"?r=baibei/user/modifyPassword" parameters:parameter callBack:^(NSDictionary *dict) {
        
        NSString *code = dict[@"status"];
        if (code.integerValue == HttpSuccess) {
            [SVProgressHUD showInfoWithStatus:@"密码修改成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else if([dict[@"message"] isEqualToString:@"baibei"]){
            [GRUserDefault removeHDLogin];
            GRHDLoginViewController *loginHD = [[GRHDLoginViewController alloc] init];
            [self presentViewController:loginHD animated:YES completion:nil];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
    }];
    
}

#pragma mark scrollViewDelagete

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.scrollView endEditing:YES];
    [self.view endEditing:YES];
}


@end
