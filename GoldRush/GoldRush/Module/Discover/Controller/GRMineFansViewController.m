//
//  GRMineFansViewController.m
//  GoldRush
//
//  Created by Jack on 2017/1/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRMineFansViewController.h"
#import "GRMineDealRingFansCell.h"          ///粉丝cell
#import "GRMineDealRingFansModel.h"         ///粉丝模型

@interface GRMineFansViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;        ///数据源数组

@end

@implementation GRMineFansViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //初始化tableview
    [self initTableView];
    
    self.dataArray = [GRMineDealRingFansModel mj_objectArrayWithKeyValuesArray:@[@{@"iconUrl":@"Header_Icon_Default",
                                                                                   @"name":@"全民小道",
                                                                                   @"fellow":@YES},
                                                                                 @{@"iconUrl":@"Header_Icon_Default",
                                                                                   @"name":@"XIAONIU",
                                                                                   @"fellow":@NO},
                                                                                 @{@"iconUrl":@"Header_Icon_Default",
                                                                                   @"name":@"HHH",
                                                                                   @"fellow":@YES},
                                                                                 @{@"iconUrl":@"Header_Icon_Default",
                                                                                   @"name":@"HHHTRT",
                                                                                   @"fellow":@NO},
                                                                                 @{@"iconUrl":@"Header_Icon_Default",
                                                                                   @"name":@" 全民淘金",
                                                                                   @"fellow":@NO},
                                                                                 @{@"iconUrl":@"Header_Icon_Default",
                                                                                   @"name":@"淘金",
                                                                                   @"fellow":@YES}]];
    [self.tableView reloadData];
}

- (void)initTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorColor = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GRMineDealRingFansCell *cell = [GRMineDealRingFansCell cellWithTableView:tableView];
    WS(weakSelf)
    cell.fellowBlock = ^{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"你确定要取消关注吗?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *remind = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            GRMineDealRingFansModel *model = self.dataArray[indexPath.row];
            if (model.isFellow) {
                model.fellow = NO;
            }else{
                model.fellow = YES;
            }
            [weakSelf.tableView reloadData];
        }];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
           
        }];
        [alertVC addAction:remind];
        [alertVC addAction:cancle];
        [weakSelf presentViewController:alertVC animated:YES completion:nil];
    };
    cell.fansModel = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
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
