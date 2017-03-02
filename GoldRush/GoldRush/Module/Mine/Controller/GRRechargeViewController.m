//
//  GRRechargeViewController.m
//  GoldRush
//
//  Created by Jack on 2017/1/10.
//  Copyright © 2017年 Jack. All rights reserved.
//

#define theme @"恒大"

#import "GRRechargeViewController.h"
#import "GRAddBankCardView.h"
#import "GRMineUserHDWithdrawView.h"
#import "GRTransferAccountDetailCell.h"             ///转账明细细节
#import "GRTransferAccountJJDetail.h"               ///吉交所转账明细模型
#import "GRTransferAccountHDDetail.h"               ///恒大转账明细模型
#import "GRHTMLViewController.h"                    ///网页充值
#import "GRWithDrawViewController.h"                ///提现VC
#import "GRMineUserJJWithdrawView.h"                ///提现
#import "GRTransferAccountDetailNoDataCell.h"       ///转账交易明细没有数据
#import "GRRechargeTopButtonView.h"                 ///头部按钮 view
#import "GRTransferAccountDetailHeaderView.h"       ///交易明细头部 view

#import "GRRechargeHeaderView.h"                    ///充值 view 的头视图
#import "GRRechargeFooterView.h"                    ///充值 view 的尾视图
#import "GRRechargePayTypeCell.h"                   ///支付方式 cell
#import "GRJDPaySignViewController.h"               ///京东签约
#import "GRAddBankViewController.h"

#import "XHDatePickerView.h"                        ////时间选择器
#import "NSDate+Extension.h"
#import "GRDateFormatter.h"
#import "GRHDWithDrawCell.h"                        ///恒大提现的 cell 输入框
#import "GRWithDrawBank.h"                          ///提现银行
#import "PSCityPickerView.h"                        ///城市选择器

#import "GRJDBankModel.h"                           ///银行模型
#import "GRCountDownBtn.h"

@interface GRRechargeViewController ()<UITableViewDelegate,
                                       UITableViewDataSource,
                                       GRRechargeTopButtonViewDelegate,
                                       GRRechargeHeaderViewDelegate,
                                       GRRechargeFooterViewDelegate,
                                       GRRechargePayTypeCellDelegate,
                                       GRMineUserJJWithdrawViewDelegate,
                                       GRTransferAccountDetailHeaderViewDelegate,
                                       GRAddBankCardViewDelegate,
                                       GRHDWithDrawCellDlegate,
                                       GRWithDrawBankDelegate,
                                       PSCityPickerViewDelegate,
                                       GRMineUserHDWithdrawViewDelegate>

@property (nonatomic, weak) GRRechargeTopButtonView *buttonView;                ///头部按钮 view
@property (nonatomic, assign) NSInteger index;                                  ///当前点击按钮的索引值
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;                        ///交易流水数组
@property (nonatomic, strong) GRMineUserJJWithdrawView *withDrawJJView;         ///提现
@property (nonatomic, strong) GRMineUserHDWithdrawView *withDrawHDView;
@property (nonatomic, copy) NSString *startTime;                                ///选择开始时间
@property (nonatomic, copy) NSString *endTime;                                  ///选择结束时间
@property (nonatomic, copy) NSString *bankCardNum;                              ///银行卡号
@property (nonatomic, copy) NSString *bankName;                                 ///开户姓名
@property (nonatomic, copy) NSString *withDrawMoney;                            ///提现金额
@property (nonatomic, copy) NSString *password;                                 ///交易密码
@property (nonatomic, copy) NSString *code;                                     ///验证码
@property (nonatomic, copy) NSString *bankType;                                 ///银行类型
@property (nonatomic, copy) NSString *provice;                                  ///省份
@property (nonatomic, copy) NSString *city;                                     ///城市
@property (nonatomic, copy) NSString *subBank;                                  ///支行
@property (nonatomic, copy) NSString *bankCode;                                 ///银行编码
@property (nonatomic, strong) GRRechargeFooterView *footer;                     ///充值的尾视图
@property (nonatomic, strong) GRRechargeHeaderView *header;                     ///充值的头视图
@property (nonatomic, strong) NSMutableArray *payTypeArray;                     ///支付类型数组
@property (nonatomic, strong) NSMutableArray *titleArray;                       ///恒大签约输入框的文字
@property (nonatomic, strong) NSMutableArray *placeholderArray;                 ///恒大签约输入框的文字
@property (nonatomic, copy) NSString *money;                                    ///充值金额

@property (nonatomic, strong) NSIndexPath *preIndexPath;                        ///当前选中行的索引
@property (nonatomic, weak) UIButton *selectedBtn;                              ///顶部选中的按钮(充值/提现/交易明细)
@property (nonatomic, strong) UIView *bottomView;                               ///恒大提现尾部按钮/和头部提示文字
@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) GRWithDrawBank *bankPickerView;                   ///银行选择器
@property (nonatomic, strong) PSCityPickerView *cityPicker;                     ///城市选择器
@property (nonatomic, strong) NSMutableArray *bankArray;                        ///支持提现银行数组
@property (nonatomic, strong) NSMutableArray *dataArray;                        ///银行编码

@end

@implementation GRRechargeViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建子视图
    [self creatSubViews];
    
    //初始化参数
    [self initData];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ///当前是哪个按钮被点击的
    if (self.isCharge) {
        UIButton *recharge = [self.buttonView viewWithTag:10230];
        [self gr_rechargeTopButtonViewDidClickBtn:recharge];
    }else{
        UIButton *withDraw = [self.buttonView viewWithTag:10231];
        [self gr_rechargeTopButtonViewDidClickBtn:withDraw];
    }
}

//初始化参数
- (void)initData{
    self.view.backgroundColor = [UIColor whiteColor];
    //获取当前时间，日期
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [GRDateFormatter sharedInstance];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    self.startTime = dateString;
    self.endTime = dateString;
    self.money = @"10";
    self.index = 1;
    //Mine_JD_Pay
    if ([[self.title substringToIndex:2] isEqualToString:theme]){
        [self.payTypeArray addObjectsFromArray:@[@{@"imageName":@"Mine_JD_Pay",
                                          @"payType":@"京东支付",
                                          @"payDesc":@"安全急速支付，无需开通网银"}]];
    }else{
        [self.payTypeArray addObjectsFromArray:@[@{@"imageName":@"Mine_Card",
                                                   @"payType":@"支付宝支付",
                                                   @"payDesc":@"安全急速支付，无需开通网银"},
                                                 @{@"imageName":@"Mine_WeChat",
                                                   @"payType":@"微信支付",
                                                   @"payDesc":@"安全急速支付，无需开通网银"}]];
    }
    

}


#pragma mark - GRMineUserJJWithdrawViewDelegate
#pragma mark - 吉交所提现
- (void)gr_withDrawView:(GRMineUserJJWithdrawView *)withDrawView didClickNextButton:(UIButton *)btn{
    [self requestJJWithDraw];
}

- (void)gr_withDrawView:(GRMineUserJJWithdrawView *)withDrawView didEndEditing:(UITextField *)textField{
    NSInteger index = textField.tag;
    if (index == 2017 + 1) {
        self.bankCardNum = textField.text;
    }else if (index == 2017 + 2){
        self.bankName = textField.text;
    }else if (index == 2017 + 3){
        self.withDrawMoney = textField.text;
    }else if (index == 2017 + 4){
        self.password = textField.text;
    }else{
        self.code = textField.text;
    }
}

///获取验证码
- (void)gr_getCodeBtnClick:(GRCountDownBtn *)btn{
    NSDictionary *paraDict = @{@"r":@"jlmmex/code/withdraw"};
    [GRNetWorking postWithURLString:@"?r=jlmmex/code/withdraw" parameters:paraDict callBack:^(NSDictionary *dict) {
        NSNumber *code = dict[@"status"];
        if ([code isEqualToNumber:@(HttpSuccess)]) {
            [SVProgressHUD showInfoWithStatus:@"验证码发送成功"];
        }else if ([dict[@"message"] isEqualToString:@"jlmmex"]){
            GRJJLoginViewController *loginVC = [[GRJJLoginViewController alloc] init];
            [self presentViewController:loginVC animated:YES completion:nil];
            [GRUserDefault removeJJLogin];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
    }];
}

///吉交所交易流水
- (void)requestqueryRechargeWithdrawmoneyLog{
    NSDictionary *parameters = @{@"r":@"jlmmex/user/moneyLog",
                                 @"st":self.startTime,
                                 @"et":self.endTime};
    WS(weakSelf)
    [SVProgressHUD show];
    //查询充值和提现流水
    [GRNetWorking postWithURLString:@"?r=jlmmex/user/moneyLog" parameters:parameters callBack:^(NSDictionary *dict) {
        NSString *code = dict[@"status"];
        if (code.integerValue == HttpSuccess) {
            [weakSelf.dataSource removeAllObjects];
            NSArray *array = dict[@"recordset"][@"list"];
            //添加数据
            if (array.count) {
                for (NSDictionary *dict in array) {
                    GRTransferAccountJJDetail *model = [GRTransferAccountJJDetail mj_objectWithKeyValues:dict];
                    if ([model.type isEqualToString:@"3"] || [model.type isEqualToString:@"4"]) {
                        [weakSelf.dataSource addObject:model];
                    }
                }
            }
            [SVProgressHUD dismiss];
        }else if([dict[@"message"] isEqualToString:@"baibei"]){
            [GRUserDefault removeHDLogin];
            GRHDLoginViewController *loginHD = [[GRHDLoginViewController alloc] init];
            [self presentViewController:loginHD animated:YES completion:nil];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    }];
}

///吉交所提现
- (void)requestJJWithDraw{
    if (self.password.length == 0 ||
        self.bankName.length == 0 ||
        self.bankCardNum.length == 0 ||
        self.withDrawMoney.length == 0 ||
        self.code.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请填写完整对应信息!"];
    }else{
        NSDictionary *paramDict = @{@"r":@"jlmmex/withdraw/apply",
                                    @"password":self.password,
                                    @"cardno":[self.bankCardNum stringByReplacingOccurrencesOfString:@" " withString:@""],
                                    @"cardusername":self.bankName,
                                    @"amount":self.withDrawMoney,
                                    @"vcode":self.code};
        [SVProgressHUD show];
        [GRNetWorking postWithURLString:@"?r=jlmmex/withdraw/apply" parameters:paramDict callBack:^(NSDictionary *dict) {
            NSNumber *code = dict[@"status"];
            if ([code isEqualToNumber:@(HttpSuccess)]) {
                UIButton *withDraw = [self.buttonView viewWithTag:10232];
                [self gr_rechargeTopButtonViewDidClickBtn:withDraw];
                [SVProgressHUD dismiss];
            }else if ([dict[@"message"] isEqualToString:@"jlmmex"]){
                GRJJLoginViewController *loginVC = [[GRJJLoginViewController alloc] init];
                [self presentViewController:loginVC animated:YES completion:nil];
                [GRUserDefault removeJJLogin];
            } else{
                [SVProgressHUD showInfoWithStatus:dict[@"message"]];
            }
        }];
    }
}



#pragma mark - GRMineUserHDWithdrawViewDelegate
#pragma mark - 恒大提现
///确认提现按钮
- (void)gr_sureButtonAction:(UIButton *)sender{
    [self requestHDWithDraw];
}

///提现金额输入框
- (void)gr_surewithDrawMoneyAction:(UITextField *)sender{
    if (sender.tag == 9036) {
        self.withDrawMoney = sender.text;
    }else if (sender.tag == 9037){
        self.code = sender.text;
    }
}

///获取验证码
- (void)gr_getCodeClick:(GRCountDownBtn *)btn{
    NSDictionary *paramDict = @{@"r":@"?r=baibei/user/getCode",
                                @"mobile":[GRUserDefault getUserPhone]};
    [GRNetWorking postWithURLString:@"?r=baibei/user/getCode" parameters:paramDict callBack:^(NSDictionary *dict) {
        NSNumber *code = dict[@"status"];
        if ([code isEqualToNumber:@(HttpSuccess)]) {
            btn.backgroundColor = GRColor(224, 224, 224);
            //设置按钮的倒计时
            [btn startWithSecond:60];
            [btn didChange:^NSString *(GRCountDownBtn *countDownButton, int second) {
                NSString *title = [NSString stringWithFormat:@"%d秒重新获取",second];
                return title;
            }];
            [btn didFinished:^NSString *(GRCountDownBtn *countDownButton, int second) {
                countDownButton.enabled = YES;
                btn.backgroundColor = [UIColor colorWithHexString:@"#00a0e9"];
                return @"点击重新获取";
            }];
            
        }else if([dict[@"message"] isEqualToString:@"baibei"]){
            [GRUserDefault removeHDLogin];
            GRHDLoginViewController *loginHD = [[GRHDLoginViewController alloc] init];
            [self presentViewController:loginHD animated:YES completion:nil];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
    }];
}

///恒大提现
- (void)requestHDWithDraw{
    if (self.bankType.length == 0 ||
        self.bankName.length == 0 ||
        self.bankCardNum.length == 0 ||
        self.withDrawMoney.length == 0 ||
        self.code.length == 0 ||
        self.subBank.length == 0 ||
        self.provice.length == 0 ||
        self.city.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请填写完整对应信息!"];
    }else{
        NSDictionary *paramDict = @{@"r":@"baibei/withdraw/apply",
                                    @"account":self.bankName,
                                    @"cardNo":[self.bankCardNum stringByReplacingOccurrencesOfString:@" " withString:@""],
                                    @"bank":self.bankType,
                                    @"txMoney":self.withDrawMoney,
                                    @"vcode":self.code,
                                    @"province":self.provice,
                                    @"city":self.city,
                                    @"subBank":self.subBank,
                                    @"channel":@"41",
                                    @"bankCode":self.bankCode};
        [SVProgressHUD show];
        [GRNetWorking postWithURLString:@"?r=baibei/withdraw/apply" parameters:paramDict callBack:^(NSDictionary *dict) {
            NSNumber *code = dict[@"status"];
            if ([code isEqualToNumber:@(HttpSuccess)]) {
                UIButton *withDraw = [self.buttonView viewWithTag:10232];
                [self gr_rechargeTopButtonViewDidClickBtn:withDraw];
                [SVProgressHUD dismiss];
            }else if([dict[@"message"] isEqualToString:@"baibei"]){
                [GRUserDefault removeHDLogin];
                GRHDLoginViewController *loginHD = [[GRHDLoginViewController alloc] init];
                [self presentViewController:loginHD animated:YES completion:nil];
            }else{
                [SVProgressHUD showInfoWithStatus:dict[@"message"]];
            }
        }];
    }
}

///恒大提现可提现银行列表
- (void)requestWithDrawBank{
    ///恒大请求可提现银行列表
    WS(weakSelf)
    NSDictionary *bankDict = @{@"r":@"baibei/bank/jdpaySupportBank"};
    [GRNetWorking postWithURLString:@"?r=baibei/bank/jdpaySupportBank" parameters:bankDict callBack:^(NSDictionary *dict) {
        NSString *code = dict[@"status"];
        if (code.integerValue == HttpSuccess) {
            NSArray *array = dict[@"recordset"];
            for (NSDictionary *bankDict in array) {
                GRJDBankModel *model = [GRJDBankModel mj_objectWithKeyValues:bankDict];
                [weakSelf.bankArray addObject:model.name];
                [weakSelf.dataArray addObject:model];
            }
        }else if([dict[@"message"] isEqualToString:@"baibei"]){
            [GRUserDefault removeHDLogin];
            GRHDLoginViewController *loginHD = [[GRHDLoginViewController alloc] init];
            [self presentViewController:loginHD animated:YES completion:nil];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.bankPickerView.dataArray = weakSelf.bankArray;
        });
    }];
}

///恒大交易流水
- (void)requestqueryRechargeWithdrawalLogList{
    NSDictionary *parameters = @{@"r":@"baibei/account/queryRechargeWithdrawalLogList",
                                 @"type":@"all",
                                 @"startNo":@"0",
                                 @"endNo":@"50",
                                 @"st":self.startTime,
                                 @"et":self.endTime};
    WS(weakSelf)
    [SVProgressHUD show];
    //查询充值和提现流水
    [GRNetWorking postWithURLString:@"?r=baibei/account/queryRechargeWithdrawalLogList" parameters:parameters callBack:^(NSDictionary *dict) {
        [weakSelf.dataSource removeAllObjects];
        NSString *code = dict[@"status"];
        if (code.integerValue == HttpSuccess) {
            NSArray *detailArray = dict[@"recordset"];
            for (NSDictionary *detailDict in detailArray) {
                //添加数据
                GRTransferAccountHDDetail *model = [GRTransferAccountHDDetail mj_objectWithKeyValues:detailDict];
                [weakSelf.dataSource addObject:model];
            }
            [SVProgressHUD dismiss];
        }else if([dict[@"message"] isEqualToString:@"baibei"]){
            [GRUserDefault removeHDLogin];
            GRHDLoginViewController *loginHD = [[GRHDLoginViewController alloc] init];
            [self presentViewController:loginHD animated:YES completion:nil];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    }];
}


#pragma mark - GRHDWithDrawCellDlegate
#pragma mark - 恒大提现第一个页面
- (void)gr_HDWithDrawCell:(GRHDWithDrawCell *)cell didEndEditing:(UITextField *)field{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.row == 0) {
        self.bankCardNum = field.text;
    }else if (indexPath.row == 1){
        field.text = self.bankType;
    }else if (indexPath.row == 2){
        self.bankName = field.text;
    }else if(indexPath.row == 3){
        self.provice = field.text;
    }else if(indexPath.row == 4){
        self.city = field.text;
    }else{
        self.subBank = field.text;
    }
}

- (void)gr_HDWithDrawCell:(GRHDWithDrawCell *)cell shouldBeginEditing:(UITextField *)field{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.row == 1) {
        field.inputView = self.bankPickerView;
        [field reloadInputViews];
        if (field.isFirstResponder) {
            field.text = self.bankArray.firstObject;
            self.bankType = self.bankArray.firstObject;
        }
    }else if (indexPath.row == 3 || indexPath.row == 4){
        field.inputView = self.cityPicker;
        [field reloadInputViews];
        if (field.isFirstResponder) {
            if (indexPath.row == 3) {
                field.text = @"北京市";
                self.provice = field.text;
            }else{
                field.text = @"北京市";
                self.city = field.text;
            }
        }
    }
}

#pragma mark - PSCityPickerViewDelegate
- (void)cityPickerView:(PSCityPickerView *)picker finishPickProvince:(NSString *)province city:(NSString *)city district:(NSString *)district{
    GRHDWithDrawCell *threeCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    for (UIView *view in threeCell.contentView.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *field = (UITextField *)view;
            field.text = province;
        }
    }
    self.provice = province;
    
    GRHDWithDrawCell *fourCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    for (UIView *view in fourCell.contentView.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *field = (UITextField *)view;
            field.text =  [NSString stringWithFormat:@"%@",city];;
        }
    }
    self.city = [NSString stringWithFormat:@"%@",city];
}

#pragma mark - GRWithDrawBankDelegate
#pragma mark - 选择银行的名字
- (void)gr_withDrawBankView:(GRWithDrawBank *)view didSelectedBank:(NSString *)bankName{
    GRHDWithDrawCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *field = (UITextField *)view;
            field.text = bankName;
        }
    }
    self.bankType = bankName;
    for (GRJDBankModel *model in self.dataArray) {
        if ([model.name isEqualToString:bankName]) {
            self.bankCode = model.bankID;
        }
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.index == 1) {
        return self.payTypeArray.count;
    }else if (self.index == 2){
        if ([[self.title substringToIndex:2] isEqualToString:theme]) {
            return self.titleArray.count;
        }else{
            return 1;
        }
    } else{
        if (self.dataSource.count == 0) {
            return 1;
        }else{
            return self.dataSource.count;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.index == 1) {      ///充值
        GRRechargePayTypeCell *cell = [GRRechargePayTypeCell cellWithTableView:tableView];
        cell.delegate = self;
        cell.payTypeDict = self.payTypeArray[indexPath.row];
        return cell;
    }else if (self.index == 2){
        if ([[self.title substringToIndex:2] isEqualToString:theme]) {
            GRHDWithDrawCell *cell = [GRHDWithDrawCell cellWithTableView:tableView];
            cell.title = self.titleArray[indexPath.row];
            cell.placeholder = self.placeholderArray[indexPath.row];
            cell.delegate = self;
            return cell;
        }else{
            static NSString *cellID = @"JJWithDraw";
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
            [cell.contentView addSubview:self.withDrawJJView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    } else{
        if (self.dataSource.count) {
            GRTransferAccountDetailCell *cell = [GRTransferAccountDetailCell cellWithTableView:tableView];
            if ([[self.title substringToIndex:2] isEqualToString:theme]) {
                cell.detailModelHD = self.dataSource[indexPath.row];
            }else{
                cell.detailModelJJ = self.dataSource[indexPath.row];
            }
            return cell;
        }else{
            GRTransferAccountDetailNoDataCell *cell = [GRTransferAccountDetailNoDataCell cellWithTableView:tableView];
            return cell;
        }
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.index == 1) {  ///充值
        if (![[self.title substringToIndex:2] isEqualToString:theme]) {
            if (self.preIndexPath == indexPath) {
                return 64 + 44;
            }else{
                return 64;
            }
        }else{
            return 64;
        }
    }else if (self.index == 2){
        if ([[self.title substringToIndex:2] isEqualToString:theme]){
            return 44;
        }else{
            return K_Screen_Height - 159 - 64;
        }
    } else{          ///转账明细
        if (self.dataSource.count == 0) {
            return 200;
        }else{
            return 44;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.index == 1) {
        return nil;
    }else if(self.index == 2){
        return nil;
    } else{
        GRTransferAccountDetailHeaderView *header = [[GRTransferAccountDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 64)];
        header.delegate = self;
        header.startTime = self.startTime;
        header.endTime = self.endTime;
        header.backgroundColor = [UIColor whiteColor];
        return header;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.index == 1) {
        return 0.001;
    }else if (self.index == 2){
        return 0.001;
    } else{
        return 64;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.index == 1) {
        GRRechargePayTypeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        GRRechargePayTypeCell *preCell = [tableView cellForRowAtIndexPath:self.preIndexPath];
        if (self.preIndexPath != indexPath) {
            for (UIView *view in preCell.contentView.subviews) {
                if ([view isKindOfClass:[UIButton class]]) {
                    UIButton *btn = (UIButton *)view;
                    btn.selected = NO;
                }
            }
            for (UIView *view in cell.contentView.subviews) {
                if ([view isKindOfClass:[UIButton class]]) {
                    UIButton *btn = (UIButton *)view;
                    btn.selected = YES;
                }
            }
            self.preIndexPath = indexPath;
            if (self.preIndexPath && self.preIndexPath.row == 0) {
                if (![[self.title substringToIndex:2] isEqualToString:theme]){
                    cell.showField = YES;
                    preCell.showField = NO;
                }else{
                    cell.showField = NO;
                    preCell.showField = NO;
                }
            }else{
                cell.showField = YES;
                preCell.showField = NO;
            }
            [self.tableView reloadData];
        }else{
            for (UIView *view in cell.contentView.subviews) {
                if ([view isKindOfClass:[UIButton class]]) {
                    UIButton *btn = (UIButton *)view;
                    btn.selected = YES;
                }
            }
            self.preIndexPath = indexPath;
        }
    }
}

#pragma mark - GRTransferAccountDetailHeaderViewDelegate
#pragma mark - 转账明细
- (void)gr_transferAccountDetailTimeSelectedClick{
    WS(weakSelf)
    XHDatePickerView *datepicker = [[XHDatePickerView alloc] initWithCompleteBlock:^(NSDate *startDate,NSDate *endDate) {
        if ([startDate stringWithFormat:@"yyyy-MM-dd"]) {
            weakSelf.startTime = [startDate stringWithFormat:@"yyyy-MM-dd"];
        }
        if ([endDate stringWithFormat:@"yyyy-MM-dd"]) {
            weakSelf.endTime = [endDate stringWithFormat:@"yyyy-MM-dd"];
        }
        if ([[self.title substringToIndex:2] isEqualToString:theme]) {
            //请求恒大数据
            [self requestqueryRechargeWithdrawalLogList];
        }else{
            [self requestqueryRechargeWithdrawmoneyLog];
        }
    }];
    datepicker.datePickerStyle = DateStyleShowYearMonthDay;
    datepicker.dateType = DateTypeStartDate;
    datepicker.minLimitDate = [NSDate date:@"1949-01-01" WithFormat:@"yyyy-MM-dd"];
    datepicker.maxLimitDate = [NSDate date:@"2050-12-12" WithFormat:@"yyyy-MM-dd"];
    [datepicker show];
}

#pragma mark - GRRechargePayTypeCellDelegate
#pragma mark - 支付方式 cell
- (void)gr_rechargePayTypeCell:(GRRechargePayTypeCell *)cell selectWhichPayType:(UIButton *)btn{
    GRRechargePayTypeCell *preCell = [self.tableView cellForRowAtIndexPath:self.preIndexPath];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (self.preIndexPath != indexPath) {
        for (UIView *view in preCell.contentView.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton *btn = (UIButton *)view;
                btn.selected = NO;
            }
        }
        for (UIView *view in cell.contentView.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton *btn = (UIButton *)view;
                btn.selected = YES;
            }
        }
        self.preIndexPath = indexPath;
        if (self.preIndexPath && self.preIndexPath.row == 0) {
            if (![[self.title substringToIndex:2] isEqualToString:theme]){
                cell.showField = YES;
                preCell.showField = NO;
            }else{
                cell.showField = NO;
                preCell.showField = NO;
            }
        }else{
            cell.showField = YES;
            preCell.showField = NO;
        }
        [self.tableView reloadData];
    }else{
        for (UIView *view in cell.contentView.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton *btn = (UIButton *)view;
                btn.selected = YES;
            }
        }
        self.preIndexPath = indexPath;
    }
}

- (void)gr_textFieldDidEndEditing:(UITextField *)textField{
    self.money = textField.text;
}

#pragma mark - GRRechargeFooterViewDelegate
#pragma mark - 恒大京东签约 和 吉交所充值
- (void)gr_rechargeFooterViewDidNextClickBtn:(UIButton *)btn{
    [self.view endEditing:YES];
    if ([[self.title substringToIndex:2] isEqualToString:theme]) {      ///恒大
        if (self.preIndexPath && self.preIndexPath.row == 0){
            GRJDPaySignViewController *JDVC = [[GRJDPaySignViewController alloc] init];
            JDVC.title = @"京东签约";
            JDVC.money = self.money;
            [self.navigationController pushViewController:JDVC animated:YES];
        } else{
            [SVProgressHUD showInfoWithStatus:@"请选择支付方式"];
        }
    }else{   ///吉交所
        if (self.preIndexPath && self.preIndexPath.row == 0) {       ///支付宝充值
            NSDictionary *paramDict = @{@"r":@"jlmmex/recharge/alipay",
                                        @"amount":self.money,
                                        @"channels":@"ios"};
            [SVProgressHUD show];
            [GRNetWorking postWithURLString:@"?r=jlmmex/recharge/alipay" parameters:paramDict callBack:^(NSDictionary *dict) {
                NSString *code = dict[@"status"];
                if (code.integerValue == HttpSuccess) {
                    GRHTMLViewController *JJRechargeVC = [[GRHTMLViewController alloc] init];
                    JJRechargeVC.url = dict[@"recordset"][@"payUrl"];
                    JJRechargeVC.title = @"吉交所支付宝充值";
                    [SVProgressHUD dismiss];
                    [self.navigationController pushViewController:JJRechargeVC animated:YES];
                }else if ([dict[@"message"] isEqualToString:@"jlmmex"]){
                    GRJJLoginViewController *loginVC = [[GRJJLoginViewController alloc] init];
                    [self presentViewController:loginVC animated:YES completion:nil];
                    [GRUserDefault removeJJLogin];
                }else{
                    [SVProgressHUD showInfoWithStatus:dict[@"message"]];
                }
            }];
        }else if(self.preIndexPath && self.preIndexPath.row == 1){      ///微信充值
            NSDictionary *paramDict = @{@"r":@"jlmmex/recharge/wechat",
                                        @"amount":self.money,
                                        @"channels":@"ios"};
            [SVProgressHUD show];
            [GRNetWorking postWithURLString:@"?r=jlmmex/recharge/wechat" parameters:paramDict callBack:^(NSDictionary *dict) {
                NSString *code = dict[@"status"];
                if (code.integerValue == HttpSuccess) {
                    GRHTMLViewController *JJRechargeVC = [[GRHTMLViewController alloc] init];
                    JJRechargeVC.url = dict[@"recordset"][@"payUrl"];
                    JJRechargeVC.title = @"吉交所微信充值";
                    [SVProgressHUD dismiss];
                    [self.navigationController pushViewController:JJRechargeVC animated:YES];
                }else if ([dict[@"message"] isEqualToString:@"jlmmex"]){
                    GRJJLoginViewController *loginVC = [[GRJJLoginViewController alloc] init];
                    [self presentViewController:loginVC animated:YES completion:nil];
                    [GRUserDefault removeJJLogin];
                }else{
                    [SVProgressHUD showInfoWithStatus:dict[@"message"]];
                }
            }];
        }else{
            [SVProgressHUD showInfoWithStatus:@"请选择支付方式"];
        }
    }
}
///保存图片到相册
- (void)loadImageFinished:(UIImage *)image{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}
///保存图片之后的回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    GRLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}

#pragma mark - GRRechargeHeaderViewDelegate
#pragma mark - 选择充值金额按钮
- (void)gr_rechargeHeaderView:(GRRechargeHeaderView *)headerView didSelectMoneyBtn:(UIButton *)sender{
    UIView *view = [headerView viewWithTag:10];
    for (UIButton *button in view.subviews) {
        if (button.tag == sender.tag) {
            [button setTitleColor:mainColor forState:UIControlStateNormal];
            button.layer.borderColor = mainColor.CGColor;
        }else{
        [button setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        button.layer.borderColor = [UIColor colorWithHexString:@"#999999"].CGColor;
        }
    }
    self.money = sender.titleLabel.text;
}

#pragma mark - GRRechargeTopButtonViewDelegate
#pragma mark - 头部按钮
- (void)gr_rechargeTopButtonViewDidClickBtn:(UIButton *)sender{
    self.selectedBtn.selected = NO;
    self.selectedBtn.titleLabel.font = [UIFont fontWithName:@"Heiti SC Light" size:17];
    sender.selected = YES;
    sender.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    self.selectedBtn = sender;
    if (sender.tag == 10230) {    ///充值
        [self.view endEditing:YES];
        self.withDrawJJView.hidden = YES;
        self.tableView.hidden = NO;
        self.withDrawHDView.hidden = YES;
        self.charge = YES;
        self.index = 1;
        self.tableView.tableHeaderView = self.header;
        self.tableView.tableFooterView = self.footer;
        
        ///默认让支付方式选中第一个
        self.preIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        GRRechargePayTypeCell *cell = [self.tableView cellForRowAtIndexPath:self.preIndexPath];
        if (![[self.title substringToIndex:2] isEqualToString:theme]) {
            cell.showField = YES;
        }
        for (UIView *view in cell.contentView.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton *btn = (UIButton *)view;
                btn.selected = YES;
            }
        }
        [self.tableView reloadData];
        
    }else if (sender.tag == 10231){       ///提现
        self.withDrawJJView.hidden = NO;
        self.charge = NO;
        self.tableView.tableHeaderView = self.tipLabel;
        self.tableView.tableFooterView = self.bottomView;
        self.index = 2;
        self.tableView.hidden = NO;
        self.withDrawHDView.hidden = NO;
        if ([[self.title substringToIndex:2] isEqualToString:theme]) {
            ///请求恒大提现支持银行
            [self requestWithDrawBank];
        }
    }else{                  ///转账明细
        self.tableView.scrollEnabled = YES;
        self.tableView.tableFooterView = nil;
        self.tableView.tableHeaderView = nil;
        self.withDrawJJView.hidden = YES;
        self.index = 3;
        self.tableView.hidden = NO;
        self.withDrawHDView.hidden = YES;
        if ([[self.title substringToIndex:2] isEqualToString:theme]) {
            //请求恒大转账明细数据
            [self requestqueryRechargeWithdrawalLogList];
        }else{
            //请求吉交所转账明细数据
            [self requestqueryRechargeWithdrawmoneyLog];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)creatSubViews{
    //头部按钮 view
    GRRechargeTopButtonView *topButtonView = [[GRRechargeTopButtonView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 159)];
    topButtonView.delegate = self;
    self.buttonView = topButtonView;
    [self.view addSubview:topButtonView];
    
    [self.view addSubview:self.tableView];
    
    if (self.isCharge) {
        self.tableView.tableHeaderView = self.header;
        self.tableView.tableFooterView = self.footer;
        self.index = 1;
    }else{
        if ([[self.title substringToIndex:2] isEqualToString:theme]){
            self.tableView.tableHeaderView = self.tipLabel;
            self.tableView.tableFooterView = self.bottomView;
        }else{
            self.tableView.tableHeaderView = self.tipLabel;
            self.tableView.tableFooterView = nil;
        }
        self.index = 2;
    }
}

#pragma mark - setter and getter 
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 115 + 44, K_Screen_Width, K_Screen_Height - 159 - 64) style:UITableViewStylePlain];
        _tableView.delegate  = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (GRRechargeHeaderView *)header{
    if (!_header) {
        _header = [[GRRechargeHeaderView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 150)];
        _header.delegate = self;
        _header.backgroundColor = [UIColor whiteColor];;
    }
    return _header;
}

- (GRRechargeFooterView *)footer{
    if (!_footer) {
        _footer = [[GRRechargeFooterView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 200)];
        _footer.delegate = self;
        _footer.backgroundColor = [UIColor whiteColor];
    }
    return _footer;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 74)];
        UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"下一步" forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        btn.backgroundColor = [UIColor colorWithHexString:@"#f39800"];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(15, 15, K_Screen_Width - 30, 44);
        [_bottomView addSubview:btn];
    }
    return _bottomView;
}

#pragma mark - private method
- (void)btnClick:(UIButton *)btn{
    if (self.bankCardNum.length == 0 ||
        self.bankType.length == 0 ||
        self.bankName.length == 0||
        self.provice.length == 0||
        self.city.length == 0||
        self.subBank.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请填写完整信息"];
    }else{
        self.withDrawHDView.bank = [NSString stringWithFormat:@"%@:(尾号%@)",self.bankType,[self.bankCardNum substringFromIndex:4]];
        self.tableView.hidden = YES;
        [self.view addSubview:self.withDrawHDView];
    }
}

- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64 + 159, K_Screen_Width, 30)];
        _tipLabel.backgroundColor = defaultBackGroundColor;
        _tipLabel.text = @"   您需要使用现金交易一次后才可提现";
        _tipLabel.font = [UIFont systemFontOfSize:13];
    }
    return _tipLabel;
}

- (void)setIndex:(NSInteger)index{
    _index = index;
    [self.tableView reloadData];
}

- (NSMutableArray *)payTypeArray{
    if (!_payTypeArray) {
        _payTypeArray = [NSMutableArray array];
    }
    return _payTypeArray;
}

- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"银行卡号",@"银行类型",@"开户姓名",@"开户省份",@"开户城市",@"开户支行", nil];
    }
    return _titleArray;
}

- (NSMutableArray *)placeholderArray{
    if (!_placeholderArray) {
        _placeholderArray = [NSMutableArray arrayWithObjects:@"请输入银行卡号",@"请选择银行卡类型",@"请输入持卡人姓名",@"请输入开户省份",@"请输入开户城市",@"请输入支行名称", nil];
    }
    return _placeholderArray;
}

- (GRWithDrawBank *)bankPickerView{
    if (!_bankPickerView) {
        _bankPickerView = [[GRWithDrawBank alloc] init];
        _bankPickerView.bankDelegate = self;
    }
    return _bankPickerView;
}

- (PSCityPickerView *)cityPicker{
    if (!_cityPicker){
        _cityPicker = [[PSCityPickerView alloc] init];
        _cityPicker.cityPickerDelegate = self;
    }
    return _cityPicker;
}

- (GRMineUserHDWithdrawView *)withDrawHDView{
    if (!_withDrawHDView) {
        _withDrawHDView = [[GRMineUserHDWithdrawView alloc] initWithFrame:CGRectMake(0, 159, K_Screen_Width, K_Screen_Height - 159 - 64)];
        _withDrawHDView.delegate = self;
    }
    return _withDrawHDView;
}

- (GRMineUserJJWithdrawView *)withDrawJJView{
    if (!_withDrawJJView) {
        _withDrawJJView = [[GRMineUserJJWithdrawView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height)];
        _withDrawJJView.delegate = self;
        _withDrawJJView.hidden = YES;
    }
    return _withDrawJJView;
}

- (NSMutableArray *)bankArray{
    if (!_bankArray) {
        _bankArray = [NSMutableArray array];
    }
    return _bankArray;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
