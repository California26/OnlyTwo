//
//  GRSchoolViewController.m
//  GoldRush
//
//  Created by Jack on 2017/2/3.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRSchoolViewController.h"
#import "GRSchoolClickDetailViewController.h"
#import "GRSchoolCell.h"
#import "GRHTMLViewController.h"

@interface GRSchoolViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
///数据源数组
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSMutableArray *urlArray;

@end

@implementation GRSchoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
}

- (void)initTableView{
    self.navigationItem.title = @"全民学堂";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height - 64 - 49) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GRSchoolCell *cell = [GRSchoolCell cellWithTableView:tableView];
    cell.dataDict = self.dataArray[indexPath.section];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [GRSchoolCell tableView:tableView rowHeightForObject:self.dataArray[indexPath.section]];
    return 160 + height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GRHTMLViewController *htmlVC = [[GRHTMLViewController alloc] init];
    htmlVC.url = self.urlArray[indexPath.section];
    htmlVC.title = self.dataArray[indexPath.section][@"title"];
    [self.navigationController pushViewController:htmlVC animated:YES];
}

#pragma mark - setter and getter
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:
  @{@"imageName":@"School_Thickets",@"title":@"什么是""抵金券""",@"desc":@"抵金券-就是我们免费送给您的交易本金"},
  @{@"imageName":@"School_RiseDown",@"title":@"什么是""买涨买跌""",@"desc":@"买涨,也被称为做多。买跌,也被称为做空。"},@{@"imageName":@"School_StopProfit",@"title":@"什么是""止盈止损""",@"desc":@"止盈,当您下单之后没有时间一直看手机时。自动进行平仓"}, nil];
    }
    return _dataArray;
}

- (NSMutableArray *)urlArray{
    if (!_urlArray) {
        _urlArray = [NSMutableArray arrayWithObjects:@"https://dev.taojin.6789.net/?r=help/view&id=1",@"https://dev.taojin.6789.net/?r=help/view&id=2",@"https://dev.taojin.6789.net/?r=help/view&id=3", nil];
    }
    return _urlArray;
}

@end
