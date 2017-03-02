//
//  GRAddBankViewController.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/11.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRAddBankViewController.h"
#import "GRAddBankCardView.h"           ///添加银行卡的 view
#import "GRKeyBoardManager.h"           ///键盘管理者
#import "PSCityPickerView.h"


@interface GRAddBankViewController ()<UIScrollViewDelegate,GRAddBankCardViewDelegate,PSCityPickerViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property(nonatomic, strong) GRKeyBoardManager *keyBoardManager;       ///键盘管理者

@property (nonatomic, weak) GRAddBankCardView *bankView;               ///输入框 view
@property (strong, nonatomic) PSCityPickerView *cityPicker;


@property (nonatomic,strong) NSString *cardNum;                        ///开户卡号
@property (nonatomic,strong) NSString *cardType;                       ///开户类型
@property (nonatomic,strong) NSString *cardName;                       ///开户名
@property (nonatomic,strong) NSString *cardProvince;                   ///开户省份
@property (nonatomic,strong) NSString *cardCity;                       ///开户城市
@property (nonatomic,strong) NSString *cardSubBranch;                  ///开户支行
@end

@implementation GRAddBankViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    ///设置子控件
    [self setupUI];
    
//    [self requestjdpaySign];
//    [self requestjdpay];
    
    [self requestWithDraw];
}

///提现的请求数据
- (void)requestWithDrawBank{
    ///请求可提现银行列表
    NSDictionary *bankDict = @{@"r":@"baibei/bank/getBankList"};
    [GRNetWorking postWithURLString:@"?r=baibei/bank/getBankList" parameters:bankDict callBack:^(NSDictionary *dict) {
        NSString *code = dict[@"status"];
        if (code.integerValue == HttpSuccess) {
            //            NSArray *array = dict[@"recordset"];
            
        }
    }];
}

- (void)getDataFromHttp{
    [self.view endEditing:YES];
    WS(weakSelf)
    ///修改绑定银行卡信息
    NSDictionary *dicParam = @{@"r":@"baibei/account/updateCardBind",
                               @"cardNum":[self.cardNum stringByReplacingOccurrencesOfString:@" " withString:@""],
                               @"cardName":self.cardName,
                               @"province":self.cardProvince,
                               @"city":self.cardCity,
                               @"bankName":self.cardType,
                               @"subBranch":self.cardSubBranch};
    [GRNetWorking postWithURLString:@"?r=baibei/account/updateCardBind" parameters:dicParam callBack:^(NSDictionary *dict) {
        NSNumber *code = dict[@"status"];
        if ([code isEqualToNumber:@(HttpSuccess)]) {
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else if([dict[@"message"] isEqualToString:@"baibei"]){
            [GRUserDefault removeHDLogin];
            GRHDLoginViewController *loginHD = [[GRHDLoginViewController alloc] init];
            [self presentViewController:loginHD animated:YES completion:nil];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
    }];
}

- (void)requestWithDraw{
    
//    NSDictionary *dict = @{@"r":@"baibei/user/getCode",
//                           @"mobile":[GRUserDefault getUserPhone]};
//    [GRNetWorking postWithURLString:@"?r=baibei/user/getCode" parameters:dict callBack:^(NSDictionary *dict) {
//        NSString *code = dict[@"status"];
//        if (code.integerValue == HttpSuccess) {
//            
//        }
//    }];
    
    ///提现
    NSDictionary *paraDict = @{@"r":@"baibei/withdraw/apply",
                               @"txMoney":@"2",
                               @"province":@"北京",
                               @"city":@"北京",
                               @"bank":@"建设银行",
                               @"subBank":@"北京天通苑支行",
                               @"cardNo":@"6217000010048253978",
                               @"account":@"王庆飞",
                               @"vcode":@"9386",
                               @"select":@""};
    [GRNetWorking postWithURLString:@"?r=baibei/withdraw/apply" parameters:paraDict callBack:^(NSDictionary *dict) {
        NSNumber *code = dict[@"status"];
        if ([code isEqualToNumber:@(HttpSuccess)]) {
            
            
        }else if([dict[@"message"] isEqualToString:@"baibei"]){
            [GRUserDefault removeHDLogin];
            GRHDLoginViewController *loginHD = [[GRHDLoginViewController alloc] init];
            [self presentViewController:loginHD animated:YES completion:nil];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.keyBoardManager) {
        self.keyBoardManager = [[GRKeyBoardManager alloc] initWithScrollView:self.scrollView];
    }
}

///设置子控件
- (void)setupUI{
    self.view.backgroundColor = GRColor(240, 240, 240);
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height)];
    [self.view addSubview:scroll];
    scroll.delegate = self;
    self.scrollView = scroll;
    
    GRAddBankCardView *bankView = [[GRAddBankCardView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height)];
    [scroll addSubview:bankView];
    bankView.buttonTittle = self.btnTitle;
    if ([self.title isEqualToString:@"京东签约"]) {
        bankView.textArray = @[@"银行卡号",@"银行类型",@"持卡人姓名",@"身份证号",@"",@""];
    }else{
    
    }
    bankView.delegate = self;
    self.bankView = bankView;
    
    scroll.contentSize = CGSizeMake(0, K_Screen_Height + 50);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - GRAddBankCardViewDelegate
- (void)gr_addBankCardView:(GRAddBankCardView *)addBankView textFieldShouldBeginEditing:(UITextField *)textField{
    [self.keyBoardManager scrollToIdealPositionWithTargetView:textField];
    if (textField.tag == 103 || textField.tag == 104) {
        textField.inputView = self.cityPicker;
        [textField.inputView reloadInputViews];
    }else{
        [textField becomeFirstResponder];
    }
}

- (void)gr_addBankCardView:(GRAddBankCardView *)addBankView didClickBindButton:(UIButton *)btn{
    if (self.passBankCardBlock) {
        self.passBankCardBlock(self.cardType,self.cardNum);
    }
}

- (void)gr_addBankCardView:(GRAddBankCardView *)addBankView textFieldDidEndEditing:(UITextField *)textField{
    NSInteger tag = textField.tag;
    if (tag == 100) {
        self.cardNum = textField.text;
        UITextField *field = [addBankView viewWithTag:101];
        self.cardType = field.text;
        [textField endEditing:YES];
    }else if (tag == 102){
        self.cardName = textField.text;
        [textField endEditing:YES];
    }else if (tag == 105){
        self.cardSubBranch = textField.text;
        [textField endEditing:YES];
    }
}

#pragma mark - PSCityPickerViewDelegate
- (void)cityPickerView:(PSCityPickerView *)picker finishPickProvince:(NSString *)province city:(NSString *)city district:(NSString *)district{
    UITextField *provinceField = [self.bankView viewWithTag:103];
    provinceField.text = province;
    self.cardProvince = province;
    
    UITextField *cityField = [self.bankView viewWithTag:104];
    cityField.text = [NSString stringWithFormat:@"%@  %@",city,district];
    self.cardCity = [NSString stringWithFormat:@"%@  %@",city,district];
}

#pragma mark - Getter and Setter
- (PSCityPickerView *)cityPicker{
    if (!_cityPicker){
        _cityPicker = [[PSCityPickerView alloc] init];
        _cityPicker.cityPickerDelegate = self;
    }
    return _cityPicker;
}


@end
