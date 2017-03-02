//
//  GRSchoolClickDetailViewController.m
//  GoldRush
//
//  Created by Jack on 2017/2/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRSchoolClickDetailViewController.h"
#import "GRSchoolDetailCell.h"                          ///学堂 cell

@interface GRSchoolClickDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation GRSchoolClickDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ///初始化
    [self initTableView];
}

- (void)initTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height - 64) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GRSchoolDetailCell *cell = [GRSchoolDetailCell cellWithTableView:tableView];
    cell.imageName = self.imageName;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 615;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}



@end
