//
//  GRLogInViewController.m
//  GoldRush
//
//  Created by Jack on 2016/12/18.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRLogInViewController.h"
#import "GRLoginScrollView.h"                   ///登陆 view
#import "UIBarButtonItem+GRItem.h"
#import "GRProtocolViewController.h"            ///协议控制器
#import "GRCountDownBtn.h"                      ///倒计时按钮
#import "GRHDRegisterViewController.h"          ///恒大注册


@interface GRLogInViewController ()<LoginDelegate>
{
    int surPlusNumber;
}
@property (nonatomic,strong) GRLoginScrollView *scrollView;
@property (nonatomic)        BOOL isAgree;
@property (nonatomic,strong) NSString *stringIphone;
@property (nonatomic,strong) NSString *stringCode;
@property (nonatomic,strong) NSString *scuccessCode;
@end

@implementation GRLogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpChildView];
    
    self.isAgree = YES;
}

- (void)setUpChildView{
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 24)];
    view1.backgroundColor = mainColor;

    UILabel *labelTitle1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, K_Screen_Width, 40)];
    labelTitle1.text = @"注册／登录";
    labelTitle1.font = [UIFont systemFontOfSize:18];
    labelTitle1.backgroundColor = mainColor;
    labelTitle1.textColor = [UIColor whiteColor];
    labelTitle1.textAlignment = NSTextAlignmentCenter;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(K_Screen_Width-80, CGRectGetMinY(labelTitle1.frame), 80,40);
    [button addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];

    _scrollView = [[GRLoginScrollView alloc] initWithFrame:self.view.frame];
    _scrollView.loginDelegate = self;
    [self.view addSubview:self.scrollView];
    [self.view addSubview:view1];
    [self.view addSubview:labelTitle1];
    [self.view addSubview:button];
}

- (void)cancelButtonAction{
    [self.scrollView endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark LoginDelegate
//结束编辑
- (void)loginEndChangeWithTextField:(UITextField *)textField{
    if (textField.tag == 1000) {
        self.stringIphone = textField.text;
    }else{
        self.stringCode = textField.text;
    }
}

//获得验证码
- (void)loginGetCodeAction:(GRCountDownBtn *)btn{
    [self.view endEditing:YES];
    btn.enabled = NO;
    __weak GRLoginScrollView *loginView = self.scrollView;
    [btn didChange:^NSString *(GRCountDownBtn *countDownButton, int second) {
        loginView.isTime = YES;
        NSString *title = [NSString stringWithFormat:@"%d秒重新获取",second];
        return title;
    }];
    [btn didFinished:^NSString *(GRCountDownBtn *countDownButton, int second) {
        countDownButton.enabled = YES;
        btn.backgroundColor = [UIColor colorWithHexString:@"#00a0e9"];
        loginView.isTime = YES;
        return @"点击重新获取";
    }];
    WS(weakself)
    //获得验证码
    //https://api.taojin.6789.net/?r=code/login&mobile
    if (self.stringIphone.length != 0 && self.stringIphone.length == 11) {
        NSDictionary *dicparam = @{@"mobile":self.stringIphone,
                                   @"r":@"code/login"};
        [GRNetWorking postWithURLString:@"?r=code/login" parameters:dicparam callBack:^(NSDictionary *dict) {
            NSNumber *code = [dict objectForKey:@"status"];
            if ([code isEqualToNumber:@(HttpSuccess)]) {
                //设置按钮的倒计时
                [btn startWithSecond:60];
                btn.backgroundColor = GRColor(224, 224, 224);
                weakself.scuccessCode = dict[@"recordset"];
                btn.enabled = YES;
            }else{
                [SVProgressHUD showErrorWithStatus:dict[@"message"]];
                btn.enabled = YES;
            }
        }];
    }
}

//下一步
- (void)loginSureActionWith:(UIButton *)sender{
    [self.scrollView endEditing:YES];
    if (self.isAgree) {//同意
        //https://api.taojin.6789.net/?r=member/login/fast&mobile=手机号&vcode=手机验证码&vhash=验证码发送成功后接口返回的字符串
        if (self.stringIphone.length != 0 && self.stringCode.length != 0 && self.scuccessCode.length != 0) {
            [SVProgressHUD show];
            NSDictionary *dicParam = @{@"mobile":self.stringIphone,
                                       @"vcode":self.stringCode,
                                       @"vhash":self.scuccessCode,
                                       @"r":@"member/login/do",
                                       @"aliDeviceID":[CloudPushSDK getDeviceId]};
            [GRNetWorking postWithURLString:@"?r=member/login/do" parameters:dicParam callBack:^(NSDictionary *dict) {
                NSNumber *status = dict[@"status"];
                if ([status isEqualToNumber:@(HttpSuccess)]) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                    [GRUserDefault setKey:@"header-icon" Value:dict[@"recordset"][@"avatar"]];
                    [GRUserDefault setKey:@"UserPhone" Value:dict[@"recordset"][@"mobile"]];
                    //获取 cookie
                    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:@"https://api.taojin.6789.net/?r=member/login/fast"]];
                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
                    [GRUserDefault setKey:@"NSHTTPCookie" Value:data];
                    [CloudPushSDK bindAccount:self.stringIphone withCallback:^(CloudPushCallbackResult *res) {
                        if (res.success) {
                            GRLog(@"绑定成功");
                        }else{
                            
                        }
                    }];
                    [[NSNotificationCenter defaultCenter] postNotificationName:GRAccountIsLoginNotification object:@{@"isRequest":@"YES"}];
                    [SVProgressHUD dismiss];
                    [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
                }else{
                    [SVProgressHUD showErrorWithStatus:dict[@"message"]];
                }
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:@"请填写验证码!"];
        }
    }else{
         [SVProgressHUD showErrorWithStatus:@"请选择我已同意并阅读<<全民淘金贵金属服务协议>>"];
    }
}
//协议
- (void)loginWithProtocol{
    GRProtocolViewController *protocolVC = [[GRProtocolViewController alloc] init];
    protocolVC.text = @"<<全民淘金贵金属服务协议>>";
    protocolVC.url = @"https://www.baidu.com";
    [self presentViewController:protocolVC animated:YES completion:nil];
}

- (void)loginAgreeAction:(UIButton *)sender{
    self.isAgree = sender.showsTouchWhenHighlighted;
}

- (void)loginCancelAction{
    [self cancelButtonAction];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_scrollView endEditing:YES];
    [self.view endEditing:YES];
}


@end
