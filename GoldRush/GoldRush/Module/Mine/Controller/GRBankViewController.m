//
//  GRBankViewController.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/11.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRBankViewController.h"

#import "GRAddBankViewController.h"         ///添加银行卡
#import "GRBankCardCell.h"                  ///银行卡 cell
#import "GRRechargeBottomView.h"            ///充值底部的 view

@interface GRBankViewController ()<UITableViewDelegate,UITableViewDataSource,GRRechargeBottomViewDelegate,GRBankCardCellDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;

///当前选中行的索引
@property (nonatomic, strong) NSIndexPath *preIndexPath;

@end

@implementation GRBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self.view addSubview:self.tableView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
        
    if (self.delegate && [self.delegate respondsToSelector:@selector(gr_notficationRechargeVCShowRechargrOrWithDraw:)]) {
        [self.delegate gr_notficationRechargeVCShowRechargrOrWithDraw:self.title];
    }
    
    if ([self.stringType isEqualToString:@"充值"]) {
        [self requestBankCardBind];
    }else{
        [self requestIsCardBinded];
    }
}

- (void)requestBankCardBind{
    //查询绑定银行卡信息
    NSDictionary *paramDict = @{@"r":@"baibei/account/queryCardBind"};
    [GRNetWorking postWithURLString:@"?r=baibei/account/queryCardBind" parameters:paramDict callBack:^(NSDictionary *dict) {
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

- (void)requestIsCardBinded{
    //是否绑定银行卡
    NSDictionary *paraDict = @{@"r":@"baibei/account/isCardBinded"};
    [GRNetWorking postWithURLString:@"?r=baibei/account/isCardBinded" parameters:paraDict callBack:^(NSDictionary *dict) {
        NSNumber *code = dict[@"status"];
        if ([code isEqualToNumber:@(HttpSuccess)]) {
            
            [self requestBankCardBind];
            
        }else if([dict[@"message"] isEqualToString:@"baibei"]){
            [GRUserDefault removeHDLogin];
            GRHDLoginViewController *loginHD = [[GRHDLoginViewController alloc] init];
            [self presentViewController:loginHD animated:YES completion:nil];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataSource.count == 0) {
        return 1;
    }else{
        return self.dataSource.count + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *stringCell = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringCell];
        }
        cell.backgroundColor = defaultBackGroundColor;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        if ([self.stringType isEqualToString:@"提现"]) {
            cell.textLabel.text = [NSString stringWithFormat:@"提现金额%@元",self.stringMoney];
        }else{
            cell.textLabel.text = [NSString stringWithFormat:@"充值金额%@元",self.stringMoney];
        }
        return cell;
    }else{
        GRBankCardCell *cell = [GRBankCardCell cellWithTableView:tableView];
        cell.delegate = self;
        return cell;
    }
}

#pragma mark UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    GRRechargeBottomView *footer = [[GRRechargeBottomView alloc] init];
    footer.buttonType = self.stringType;
    footer.delegate = self;
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 88;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GRBankCardCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    GRBankCardCell *preCell = [tableView cellForRowAtIndexPath:self.preIndexPath];
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

#pragma mark - GRBankCardCellDelegate
- (void)gr_bankCardCell:(GRBankCardCell *)cell selectWhichBank:(UIButton *)btn{
    GRBankCardCell *preCell = [self.tableView cellForRowAtIndexPath:self.preIndexPath];
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

#pragma mark - GRRechargeBottomViewDelegate
- (void)gr_rechargeBottomView:(GRRechargeBottomView *)view didClickAddBankButton:(UIButton *)btn{
    GRAddBankViewController *addBankVC = [[GRAddBankViewController alloc] init];
    addBankVC.passBankCardBlock = ^(NSString *bankType,NSString *bankCard){
        [self.dataSource addObject:@"12"];
        [self.tableView reloadData];
    };
    addBankVC.title = @"绑定银行卡";
    [self.navigationController pushViewController:addBankVC animated:YES];
}

- (void)gr_rechargeBottomView:(GRRechargeBottomView *)view didClickNextButton:(UIButton *)btn{
    if ([self.stringType isEqualToString:@"充值"]) {
        if (self.preIndexPath) {
            [self requestUnionPay];
        }else{
            [SVProgressHUD showInfoWithStatus:@"请选择银行卡"];
        }
    }else{
        if (self.preIndexPath) {
//            [self requestWithDraw];
        }else{
            [SVProgressHUD showInfoWithStatus:@"请选择银行卡"];
        }
    }
}

- (void)requestUnionPay{
    ///银联充值
    NSDictionary *paraDict = @{@"r":@"baibei/recharge/unionpay",
                               @"cardNo":@"6217000010048253978",
                               @"money":@"1293.23",
                               @"select":@"1"};
    [GRNetWorking postWithURLString:@"?r=baibei/recharge/unionpay" parameters:paraDict callBack:^(NSDictionary *dict) {
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


#pragma mark - setter and getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource  = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithObjects:@"12",@"12",@"12", nil];
    }
    return _dataSource;
}

@end
