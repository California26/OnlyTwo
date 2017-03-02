//
//  GRContractServiceViewController.m
//  GoldRush
//
//  Created by Jack on 2017/3/1.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRContractServiceViewController.h"
#import "GRContractServiceCell.h"

@interface GRContractServiceViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation GRContractServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GRContractServiceCell *cell = [GRContractServiceCell cellWithTableView:tableView];
    cell.dataDict = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self jumpQQWithTitle:@"80535636"];
        [self.webView removeFromSuperview];
    }else if (indexPath.row == 2){
        [self callPhone:@"15031599217"];
        [self.webView removeFromSuperview];
    }
}

- (void)jumpQQWithTitle:(NSString *)qqNum{
    NSString *qqstr = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",qqNum];
    NSURL *url = [NSURL URLWithString:qqstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}

//拨打电话
- (void)callPhone:(NSString *)phoneNumber{
    //phoneNumber = "18369......"
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneNumber];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:self.webView];
}

#pragma mark - getter and setter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource  = self;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);
        _tableView.layoutMargins = UIEdgeInsetsZero;
    }
    return _tableView;
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _webView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithObjects:@{@"icon":@"Home_Contract_QQ",@"title":@"QQ123456",@"desc":@"工作时间08:00-22:00"},
                                                       @{@"icon":@"Home_Contract_WeChat",@"title":@"微信: qqty444",@"desc":@"长按可复制微信号"},
                                                       @{@"icon":@"Home_Contract_Phone",@"title":@"电话:14123213",@"desc":@"工作时间08:00-22:00"},nil];
    }
    return _dataSource;
}

@end
