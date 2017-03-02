//
//  GRJDPaySignViewController.m
//  GoldRush
//
//  Created by Jack on 2017/2/17.
//  Copyright © 2017年 Jack. All rights reserved.
//  京东签约

#import "GRJDPaySignViewController.h"
#import "GRJDPayCell.h"
#import "GRWithDrawBank.h"
#import "GRJDRechargeViewController.h"
#import "GRJDBankModel.h"

@interface GRJDPaySignViewController ()<UITableViewDelegate,UITableViewDataSource,GRJDPayCellDlegate,GRWithDrawBankDelegate>

///
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *placeholderArray;

@property (nonatomic, copy) NSString *bankCardNum;                  ///银行卡号
@property (nonatomic, copy) NSString *bankCardType;                 ///银行卡类型
@property (nonatomic, copy) NSString *bankCardName;                 ///开户名字
@property (nonatomic, copy) NSString *bankCardID;                   ///身份证号码
@property (nonatomic, copy) NSString *bankCardPhone;                ///手机号
@property (nonatomic, copy) NSString *bankCode;                     ///银行编码

@property (nonatomic, strong) NSMutableArray *bankArray;            ///银行数组
@property (nonatomic, strong) NSMutableArray *dataArray;            ///银行编码数组

@property (nonatomic, strong) GRWithDrawBank *bankPickerView;       ///银行选择

@property (nonatomic, copy) NSString *ordernum;                     ///返回订单号

@end

@implementation GRJDPaySignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    
        ///请求京东可充值银行
        [self requestJDBank];
    
}

///请求京东可充值银行
- (void)requestJDBank{
    WS(weakSelf)
    NSDictionary *paraDict = @{@"r":@"baibei/bank/jdpaySupportBank"};
    [GRNetWorking postWithURLString:@"?r=baibei/bank/jdpaySupportBank" parameters:paraDict callBack:^(NSDictionary *dict) {
        NSNumber *code = dict[@"status"];
        if ([code isEqualToNumber:@(HttpSuccess)]) {
            NSArray *bankArray = dict[@"recordset"];
            for (NSDictionary *dict in bankArray) {
                GRJDBankModel *model = [GRJDBankModel mj_objectWithKeyValues:dict];
                [self.bankArray addObject:model.name];
                [self.dataArray addObject:model];
            }
        }else if([dict[@"message"] isEqualToString:@"baibei"]){
            [GRUserDefault removeHDLogin];
            GRHDLoginViewController *loginHD = [[GRHDLoginViewController alloc] init];
            [self presentViewController:loginHD animated:YES completion:nil];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.bankPickerView.dataArray = self.bankArray;
            [weakSelf.tableView reloadData];
        });
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *stringCell = @"JD";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringCell];
        }
        cell.backgroundColor = defaultBackGroundColor;
        cell.textLabel.text = [NSString stringWithFormat:@"充值金额:%@元",self.money];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        GRJDPayCell *cell = [GRJDPayCell cellWithTableView:tableView];
        cell.title = self.titleArray[indexPath.row - 1];
        cell.placeholder = self.placeholderArray[indexPath.row - 1];
        cell.delegate = self;
        return cell;
    }
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 74;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 30;
    }else{
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 74)];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 0, K_Screen_Width - 15, 1)];
    line.backgroundColor = defaultBackGroundColor;
    [view addSubview:line];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    btn.layer.cornerRadius = 8;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor = [UIColor colorWithHexString:@"#f39800"];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(13, 30, K_Screen_Width - 26, 44);
    [view addSubview:btn];
    return view;
}

#pragma mark - GRJDPayCellDlegate
- (void)gr_JDPayCell:(GRJDPayCell *)cell didEndEditing:(UITextField *)field{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.row == 1) {
        self.bankCardNum = field.text;
    }else if (indexPath.row == 2){
        field.text = self.bankCardType;
    }else if (indexPath.row == 3){
        self.bankCardName = field.text;
    }else if(indexPath.row == 4){
        self.bankCardID = field.text;
    }else{
        self.bankCardPhone = field.text;
    }
}

- (void)gr_JDPayCell:(GRJDPayCell *)cell shouldBeginEditing:(UITextField *)field{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.row == 2) {
        field.inputView = self.bankPickerView;
        [field reloadInputViews];
        if (field.isFirstResponder) {
            field.text = self.bankArray.firstObject;
            self.bankCardType = self.bankArray.firstObject;
        }
    }
}

#pragma mark - GRWithDrawBankDelegate
- (void)gr_withDrawBankView:(GRWithDrawBank *)view didSelectedBank:(NSString *)bankName{
    GRJDPayCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *field = (UITextField *)view;
            field.text = bankName;
        }
    }
    self.bankCardType = bankName;
    for (GRJDBankModel *model in self.dataArray) {
        if ([model.name isEqualToString:bankName]) {
            self.bankCode = model.bankID;
        }
    }
    
}

#pragma mark - event response
//点击下一步
- (void)btnClick:(UIButton *)btn{
    [self.view endEditing:YES];
//    [self requestjdpaySign];
    GRJDRechargeViewController *rechargeVC = [[GRJDRechargeViewController alloc] init];
    rechargeVC.title = @"京东充值";
    rechargeVC.money = self.money;
    rechargeVC.dataDict = @{@"card_bank":self.bankCode,
                            @"card_no":self.bankCardNum,
                            @"card_name":self.bankCardName,
                            @"card_idno":self.bankCardID,
                            @"card_phone":self.bankCardPhone,
                            @"trade_amount":self.money,
                            @"bankName":self.bankCardType,
                            @"ordernum":self.ordernum};
    [self.navigationController pushViewController:rechargeVC animated:YES];
}

- (void)requestjdpaySign{
    ///京东签约
    NSDictionary *paramDict = @{@"r":@"baibei/recharge/jdpaySign",
                                @"card_bank":self.bankCode,
                                @"card_no":self.bankCardNum,
                                @"card_name":self.bankCardName,
                                @"card_idno":self.bankCardID,
                                @"card_phone":self.bankCardPhone,
                                @"trade_amount":self.money};
    [GRNetWorking postWithURLString:@"?r=baibei/recharge/jdpaySign" parameters:paramDict callBack:^(NSDictionary *dict) {
        NSNumber *code = dict[@"status"];
        if ([code isEqualToNumber:@(HttpSuccess)]) {
            self.ordernum = dict[@"recordset"][@"data.trade.id"];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
        
    }];
    
}

#pragma mark - setter and getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource  = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"银行卡号",@"银行类型",@"开户姓名",@"身份证号码",@"手机号码", nil];
    }
    return _titleArray;
}

- (NSMutableArray *)placeholderArray{
    if (!_placeholderArray) {
        _placeholderArray = [NSMutableArray arrayWithObjects:@"请输入银行卡号",@"请选择银行卡类型",@"请输入持卡人姓名",@"请输入身份证号码",@"请填写手机号码", nil];
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
