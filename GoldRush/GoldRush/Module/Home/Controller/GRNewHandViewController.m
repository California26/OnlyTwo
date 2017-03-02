//
//  GRNewHandViewController.m
//  GoldRush
//
//  Created by Jack on 2016/12/24.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRNewHandViewController.h"
#import "GRADImageCell.h"
#import "GRHTMLViewController.h"

@interface GRNewHandViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation GRNewHandViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GRADImageCell *cell = [GRADImageCell cellWithTableView:tableView];
    cell.imageName = self.dataArray[indexPath.row];
    cell.imageClick = ^{
        
    };
    return cell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GRHTMLViewController *htmlVC = [[GRHTMLViewController alloc] init];
    [self.navigationController pushViewController:htmlVC animated:YES];
    if (indexPath.row == 0) {
        htmlVC.title = @"一分钟看懂K线图";
        htmlVC.url = @"https://dev.taojin.6789.net/?r=help/view&id=4";
    }
}

#pragma mark - getter and getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource  = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@"Home_School_KLine",@"Home_School_Deal",@"Home_School_Deal2", nil];
    }
    return _dataArray;
}

@end
