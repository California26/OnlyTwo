//
//  GRJDRechargeViewController.m
//  GoldRush
//
//  Created by Jack on 2017/2/17.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRJDRechargeViewController.h"
#import "GRJDRechargeCell.h"

@interface GRJDRechargeViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *code;

@end

@implementation GRJDRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
}

- (void)requestjdpay{
    ///充值
    NSMutableDictionary *parDict = [NSMutableDictionary dictionaryWithDictionary:self.dataDict];
    [parDict setObject:@"trade_code" forKey:self.code];
    
    [GRNetWorking postWithURLString:@"?r=baibei/recharge/jdpay" parameters:parDict callBack:^(NSDictionary *dict) {
        NSNumber *code = dict[@"status"];
        if ([code isEqualToNumber:@(HttpSuccess)]) {
            
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
        
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *stringCell = @"cell1fd";
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
        GRJDRechargeCell *cell = [GRJDRechargeCell cellWithTableView:tableView];
        return cell;
    }
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 30;
    }else{
        return 64;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 120)];
    UILabel *label = [[UILabel alloc] init];
    [view addSubview:label];
    label.text = @"验证码";
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@13);
        make.top.equalTo(@25);
    }];
    UITextField *field = [[UITextField alloc] init];
    field.placeholder = @"请输入验证码";
    field.borderStyle = UITextBorderStyleRoundedRect;
    [view addSubview:field];
    field.delegate = self;
    [field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label.mas_centerY);
        make.left.equalTo(label.mas_right).offset(10);
        make.width.equalTo(@150);
        make.height.equalTo(@30);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:btn];
    [btn setTitle:@"充值" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithHexString:@"#f39800"];
    [btn addTarget:self action:@selector(rechargeClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 8;
    btn.layer.masksToBounds = YES;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(13);
        make.top.equalTo(field.mas_bottom).offset(20);
        make.height.equalTo(@44);
        make.width.equalTo(@(K_Screen_Width - 26));
    }];
    return view;
}

- (void)rechargeClick:(UIButton *)btn{
    if (self.code) {
        [self requestjdpay];
    }else{
        [SVProgressHUD showWithStatus:@"请输入验证码!"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.code = textField.text;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource  = self;
    }
    return _tableView;
}


@end
