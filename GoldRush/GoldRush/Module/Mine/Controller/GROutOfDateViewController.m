//
//  GROutOfDateViewController.m
//  GoldRush
//
//  Created by Jack on 2017/1/17.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GROutOfDateViewController.h"
#import "GROutOfDateCell.h"             ///过期 cell
#import "GROutDateThicket.h"            ///模型数据

@interface GROutOfDateViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation GROutOfDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = defaultBackGroundColor;
    
    //初始化 tableview
    [self initTableView];
    
    self.dataArray = [GROutDateThicket mj_objectArrayWithKeyValuesArray:@[@{@"money":@"8",@"expire":@"2016-12-25"},
                                                                          @{@"money":@"80",@"expire":@"2016-12-25"},
                                                                          @{@"money":@"200",@"expire":@"2017-12-25"}]];
}

- (void)initTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GROutOfDateCell *cell = [GROutOfDateCell cellWithTableView:tableView];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 144;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

#pragma mark - setter and getter
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
