//
//  GRHDRegisterViewController.m
//  GoldRush
//
//  Created by Jack on 2017/1/18.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRHDRegisterViewController.h"
#import "GRProtocolViewController.h"        //协议控制器
#import "GRHDRegister.h"
#import "GRHDLoginViewController.h"

@interface GRHDRegisterViewController ()<UIScrollViewDelegate,GRHDRegisterDelegate>

@property (nonatomic,strong) GRHDRegister *registerView;
@property (nonatomic, copy) NSString *password;

@end

@implementation GRHDRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加 UI
    [self setupUI];
    
    //用户注册
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark - 设置头视图
- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"Back_Btn"] forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 24, 40, 34);
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, K_Screen_Width, 34)];
    label.text = self.stringTitle;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithHexString:@"#ffffff"];
    label.font = [UIFont systemFontOfSize:20];
    label.backgroundColor = [UIColor clearColor];
    
    _registerView = [[GRHDRegister alloc] initWithFrame:self.view.bounds];
    _registerView.delegate = self;
    
    [self.view addSubview:_registerView];
    [self.view addSubview:button];
    [self.view addSubview:label];
}

- (void)keyBoardWillShow:(NSNotification *)info{
    NSDictionary *userinfo = [info userInfo];
    NSValue *animationDurationValue = [userinfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
//    WS(weakself)
    [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (iPhone5) {
//            weakself.scrollView.contentOffset = CGPointMake(0,95);
        }
    } completion:^(BOOL finished) {
        
    }];
}

- (void)keyBoardWillHide:(NSNotification *)info{
    NSDictionary *userinfo = [info userInfo];
    NSValue *animationDurationValue = [userinfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
//    WS(weakself)
    [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (iPhone5) {
//            weakself.scrollView.contentOffset = CGPointMake(0,0);
        }
    } completion:^(BOOL finished) {
        
    }];
}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark GRHDRegisterDelegate
- (void)HD_getPasswordTextEndWithTextField:(UITextField *)field{
    self.password = field.text;
}

//协议按钮
- (void)HD_protocolClick:(GRHDRegister *)registerView withProtocolBtn:(UIButton *)btn{
    GRProtocolViewController *protpcolVC = [[GRProtocolViewController alloc] init];
    protpcolVC.text = @"用户协议";
    protpcolVC.url = @"https://www.google.com";
    [self presentViewController:protpcolVC animated:YES completion:nil];
}

//注册按钮
- (void)HD_registerClick:(GRHDRegister *)registerView withRegisterBtn:(UIButton *)btn{
    [self.registerView endEditing:YES];
    //注册恒大
    NSDictionary *parameter = @{@"r":@"baibei/user/register",
                                @"password":self.password,
                                @"mobile":[GRUserDefault getUserPhone]};
    [GRNetWorking postWithURLString:@"?r=baibei/user/register" parameters:parameter callBack:^(NSDictionary *dict) {
        NSString *code = dict[@"status"];
        if (code.integerValue == HttpSuccess) {
            [GRUserDefault setKey:@"isRegistHD" Value:@(YES)];
            [SVProgressHUD showInfoWithStatus:@"成功注册恒大"];
            ///判断手机号是否注册
            NSDictionary *parameDict = @{@"r":@"baibei/user/verifyMobile"};
            [GRNetWorking postWithURLString:@"?r=baibei/user/verifyMobile" parameters:parameDict callBack:^(NSDictionary *dict) {
                NSNumber *status = dict[@"status"];
                if ([status isEqualToNumber:@(HttpPhoneExist)]) {
                    NSDictionary *parameter = @{@"r":@"baibei/user/login",
                                                @"password":self.password,
                                                @"mobile":[GRUserDefault getUserPhone]};
                    [GRNetWorking postWithURLString:@"?r=baibei/user/login" parameters:parameter callBack:^(NSDictionary *dict) {
                        NSString *code = dict[@"status"];
                        if (code.integerValue == HttpSuccess) {
                            [GRUserDefault setKey:@"isLoginHD" Value:@(YES)];
                            [self dismissViewControllerAnimated:YES completion:nil];
                        }else{
                            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
                        }
                    }];
                }
            }];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
    }];
}

#pragma mark scrollViewDelagete

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.registerView endEditing:YES];
    [self.view endEditing:YES];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

@end
