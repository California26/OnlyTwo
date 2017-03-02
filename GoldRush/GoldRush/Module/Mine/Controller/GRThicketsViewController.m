//
//  GRThicketsViewController.m
//  GoldRush
//
//  Created by Jack on 2017/1/17.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRThicketsViewController.h"
#import "GROutOfDateCell.h"             ///已过期 cell
#import "GRUnexpiredThicketCell.h"      ///未过期 cell
#import "GRThicketNoDataCell.h"         ///无数据 cell

#import "GRJJThicketsModel.h"           /// 吉交所模型
#import "GRHDThicketsModel.h"           /// 恒大模型
#import "GRRefreshHeader.h"             /// 刷新


#define ButtonWidth (K_Screen_Width / 3)

@interface GRThicketsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;                ///存放券模型数组
@property (nonatomic, strong) NSMutableArray *titleArray;               ///按钮文字
@property (nonatomic, weak) UIButton *selectedBtn;                      ///选中的按钮
@property (nonatomic, weak) UITableView *tableView;                     ///tableview
@property (nonatomic, assign) NSInteger index;                          ///当前点击第几个按钮
@property (nonatomic, assign) NSInteger page;                           ///请求页面数

@end

@implementation GRThicketsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;
    
    //初始化 tableview
    [self initTableView];
    
    //创建头部按钮
    [self createTopButton];
    
    //添加刷新
    [self addRefresh];
}

//添加刷新控件
- (void)addRefresh{
    self.tableView.mj_header = [GRRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)loadNewData{
    self.page = 1;
    if ([[self.title substringToIndex:2] isEqualToString:@"吉交"]) {
        [self requestJJCouponsWithIndex:self.selectedBtn.tag + 1];
    }else{
        [self requestHDCouponsWithIndex:self.selectedBtn.tag + 1];
    }
}

#pragma mark 上拉加载更多数据
- (void)loadMoreData{
    self.page ++;
    
    if ([self.title containsString:@"吉交"]) {
        //查询用户所有的赢家券信息
        NSDictionary *dict = @{@"r":@"jlmmex/user/getWinnerTicket",
                               @"type":[NSString stringWithFormat:@"%zd",self.index],
                               @"pageno":[NSString stringWithFormat:@"%zd",self.page],
                               @"pagesize":@"50"};
        WS(weakSelf)
        [GRNetWorking postWithURLString:@"?r=jlmmex/user/getWinnerTicket" parameters:dict callBack:^(NSDictionary *dict) {
            NSNumber *code = dict[@"status"];
            if ([code isEqualToNumber:@(HttpSuccess)]) {
                NSArray *array = dict[@"recordset"][@"tickets"];
                for (NSDictionary *thicketDict in array) {
                    GRJJThicketsModel *model = [GRJJThicketsModel mj_objectWithKeyValues:thicketDict];
                    [weakSelf.dataArray addObject:model];
                }
                if (array.count) {
                    [weakSelf.tableView.mj_footer endRefreshing];
                }
            }else if ([dict[@"message"] isEqualToString:@"jlmmex"]){
                GRJJLoginViewController *loginVC = [[GRJJLoginViewController alloc] init];
                [self presentViewController:loginVC animated:YES completion:nil];
                [GRUserDefault removeJJLogin];
            } else{
                [SVProgressHUD dismiss];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
            });
        }];
    }else{
        //查询用户所有的赢家券信息
//        NSDictionary *dict = @{@"r":@"baibei/user/queryCustomerCoupon",
//                               @"couponType":[NSString stringWithFormat:@"%zd",index],
//                               @"startNo":@"10",
//                               @"endNo":@"20"};
//        WS(weakSelf)
//        [GRNetWorking postWithURLString:@"?r=baibei/user/queryCustomerCoupon" parameters:dict callBack:^(NSDictionary *dict) {
//            NSNumber *code = dict[@"status"];
//            if ([code isEqualToNumber:@(HttpSuccess)]) {
//                NSArray *array = dict[@"recordset"];
//                for (NSDictionary *thicketDict in array) {
//                    GRHDThicketsModel *model = [GRHDThicketsModel mj_objectWithKeyValues:thicketDict];
//                    [weakSelf.dataArray addObject:model];
//                }
//                if (array.count) {
//                    [weakSelf.tableView.mj_footer endRefreshing];
//                }else{
//                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
//                }
//            }else if([dict[@"message"] isEqualToString:@"baibei"]){
//                [GRUserDefault removeHDLogin];
//                GRHDLoginViewController *loginHD = [[GRHDLoginViewController alloc] init];
//                [self presentViewController:loginHD animated:YES completion:nil];
//                [weakSelf.tableView.mj_footer endRefreshing];
//            }else{
//                [SVProgressHUD showInfoWithStatus:dict[@"message"]];
//                [weakSelf.tableView.mj_footer endRefreshing];
//            }
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [weakSelf.tableView reloadData];
//            });
//        }];
        [self.tableView.mj_footer endRefreshing];
    }
}

///恒大赢家券信息
- (void)requestHDCouponsWithIndex:(NSInteger)index{
    //查询用户所有的赢家券信息
    NSDictionary *dict = @{@"r":@"baibei/user/queryCustomerCoupon",
                           @"couponType":[NSString stringWithFormat:@"%zd",index],
                           @"startNo":@"0",
                           @"endNo":@"10"};
    WS(weakSelf)
    [GRNetWorking postWithURLString:@"?r=baibei/user/queryCustomerCoupon" parameters:dict callBack:^(NSDictionary *dict) {
        NSNumber *code = dict[@"status"];
        if ([code isEqualToNumber:@(HttpSuccess)]) {
            NSArray *array = dict[@"recordset"];
            [weakSelf.dataArray removeAllObjects];
            for (NSDictionary *thicketDict in array) {
                GRHDThicketsModel *model = [GRHDThicketsModel mj_objectWithKeyValues:thicketDict];
                [weakSelf.dataArray addObject:model];
            }
            [weakSelf.tableView.mj_header endRefreshing];
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

///吉交所赢家券信息
- (void)requestJJCouponsWithIndex:(NSInteger)index{
    //查询用户所有的赢家券信息
    NSDictionary *dict = @{@"r":@"jlmmex/user/getWinnerTicket",
                           @"type":[NSString stringWithFormat:@"%zd",index],
                           @"pageno":[NSString stringWithFormat:@"%zd",self.page],
                           @"pagesize":@"50"};
    WS(weakSelf)
    [SVProgressHUD show];
    [GRNetWorking postWithURLString:@"?r=jlmmex/user/getWinnerTicket" parameters:dict callBack:^(NSDictionary *dict) {
        NSNumber *code = dict[@"status"];
        if ([code isEqualToNumber:@(HttpSuccess)]) {
            [SVProgressHUD dismiss];
            NSArray *array = dict[@"recordset"][@"tickets"];
            [weakSelf.dataArray removeAllObjects];
            for (NSDictionary *thicketDict in array) {
                GRJJThicketsModel *model = [GRJJThicketsModel mj_objectWithKeyValues:thicketDict];
                [weakSelf.dataArray addObject:model];
            }
        }else if ([dict[@"message"] isEqualToString:@"jlmmex"]){
            GRJJLoginViewController *loginVC = [[GRJJLoginViewController alloc] init];
            [self presentViewController:loginVC animated:YES completion:nil];
            [GRUserDefault removeJJLogin];
        } else{
            [SVProgressHUD dismiss];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_header endRefreshing];
        });
    }];
}

#pragma mark - private method
- (void)createTopButton{
    self.view.backgroundColor = defaultBackGroundColor;
    
    for (int i = 0; i < self.titleArray.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:btn];
        btn.tag = i;
        [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(ButtonWidth * i, 0, ButtonWidth, 50);
        [btn setTitleColor:mainColor forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(thicketClick:) forControlEvents:UIControlEventTouchUpInside];
        if (0 == i) {
            [self thicketClick:btn];
        }
    }
}

- (void)initTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, K_Screen_Width, K_Screen_Height - 50 - 64) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArray.count) {
        return self.dataArray.count;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count) {
        if (self.index == 3) {
            GROutOfDateCell *cell = [GROutOfDateCell cellWithTableView:tableView];
            if ([[self.title substringToIndex:2] isEqualToString:@"吉交"]) {
                cell.jjModel = self.dataArray[indexPath.row];
            }else{
                cell.hdModel = self.dataArray[indexPath.row];
            }
            return cell;
        }else{
            GRUnexpiredThicketCell *cell = [GRUnexpiredThicketCell cellWithTableView:tableView];
            if ([[self.title substringToIndex:2] isEqualToString:@"吉交"]) {
                cell.jjModel = self.dataArray[indexPath.row];
            }else{
                cell.hdModel = self.dataArray[indexPath.row];
            }
            return cell;
        }
    }else{
        GRThicketNoDataCell *cell = [GRThicketNoDataCell cellWithTableView:tableView];
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

#pragma mark - event response
//点击顶部按钮
- (void)thicketClick:(UIButton *)btn{
    self.selectedBtn.selected = NO;
    self.selectedBtn.titleLabel.font = [UIFont fontWithName:@"Heiti SC Light" size:17];
    btn.selected = YES;
    btn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    self.selectedBtn = btn;
    self.index = btn.tag + 1;
    if ([[self.title substringToIndex:2] isEqualToString:@"吉交"]) {
        [self requestJJCouponsWithIndex:btn.tag + 1];
    }else{
        [self requestHDCouponsWithIndex:btn.tag + 1];
    }
}

#pragma mark - setter and getter
- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithArray:@[@"未使用",@"使用",@"已过期"]];
    }
    return _titleArray;
}


- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
