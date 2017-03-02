//
//  GRSupplementAssetsViewController.m
//  GoldRush
//
//  Created by Jack on 2017/1/10.
//  Copyright © 2017年 Jack. All rights reserved.
//

#define TitleName @"恒大资产明细"

#import "GRSupplementAssetsViewController.h"
#import "GRPropertyAssetsCell.h"                   ///资产明细充值/提现
#import "GRPropertyAssetsHeaderView.h"             ///头部标题
#import "GRRechargeViewController.h"               ///充值页面
#import "GRPropertyHoldPositionDetailCell.h"       ///持仓详情
#import "GRPropertyDealDetailCell.h"               ///交易详情明细
#import "GRPropertyDealDetail.h"                   ///交易详情数据模型
#import "GRPropertyNOHoldPositionCell.h"           ///未持仓 cell

#import "GRStopAlterView.h"                        ///止盈止损
#import "GRCloseAlterView.h"                       ///平仓
#import "GRBlurEffect.h"                           ///模糊背景 view
#import "GRNetAssetsModel.h"                       ///资产详情模型
#import "GRPropertyDealDetailNoDataCell.h"         ///交易明细无数据
#import "GRPropertyHoldPositionDetailNoDataCell.h" ///持仓无数据

#import "GRJJHoldPositionModel.h"                  ///吉交所持仓数据模型
#import "GRJJPropertyHoldPositionDetailCell.h"     ///吉交所持仓详情 cell
#import "GRJJPropertyDealDetail.h"                 ///吉交所交易明细模型
#import "GRTabBarController.h"                     ///根控制器
#import "GRPropertyViewController.h"               ///交易控制器
#import "GRThicketsViewController.h"               ///抵金券控制器
#import "XHDatePickerView.h"
#import "GRDateFormatter.h"
#import "NSDate+Extension.h"

#import "GRCalculateProfitLoss.h"                  ///计算盈亏

@interface GRSupplementAssetsViewController ()<UITableViewDelegate,
                                               UITableViewDataSource,
                                               GRPropertyDealDetailCellDelegate,
                                               stopAlterDelegate,
                                               CloseAlterDelegate,
                                               GRPropertyAssetsHeaderViewDelegate,
                                               GRPropertyHoldPositionDetailNoDataCellDelegate>{
   CGFloat profit;
}
@property (nonatomic, weak) UITableView *mainTableView;

@property (nonatomic, assign) BOOL isUnfold;                        ///交易明细是否展开
@property (nonatomic, strong) NSIndexPath *selectedIndex;           ///记录当前选择的 cell
@property(nonatomic, strong) NSMutableArray *dataArray;             ///数据源数组

@property(nonatomic, strong) GRBlurEffect *blurEffect;              ///弹框平仓
@property (nonatomic, strong) NSMutableArray *holdArray;            ///持仓情况数组
@property (nonatomic, strong) NSString *toplimit;                   ///止盈比例
@property (nonatomic,strong) NSString *bottomLimit;                 ///止损比例
@property (nonatomic, copy) NSString *profitLoss;                   ///总的持仓盈亏
@property (nonatomic, copy) NSString *buildCost;                    ///建仓成本
@property (nonatomic, copy) NSString *available;                    ///可用资金

@property (nonatomic, strong) GRNetAssetsModel *netAssetModel;      ///资产明细模型

@property (nonatomic, copy) NSString *startTime;                    ///选择开始时间
@property (nonatomic, copy) NSString *endTime;                      ///选择结束时间

@property (nonatomic, assign) NSInteger selectedTag;                ///当前选中行

@end

@implementation GRSupplementAssetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化 tableview
    [self initTableView];
    
    //最新价通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushTheNewestPrice:) name:GRPositionNew_PriceSNotification object:nil];
    
}

#pragma mark - 通知方法
- (void)pushTheNewestPrice:(NSNotification *)notification{
    WS(weakSelf)
    self.netAssetModel.netAsset = [NSString stringWithFormat:@"%.2f",self.netAssetModel.netAsset.floatValue - self.netAssetModel.profitLoss.floatValue];
    NSDictionary *dict = notification.userInfo;;
    if ([self.title containsString:@"恒大"]) {
        self.holdArray = [GRCalculateProfitLoss calculateHDProfitLossWithArray:self.holdArray withNotificationDict:dict];
        CGFloat loss = 0.0f;
        for (GRPropertyDealDetail *model in self.holdArray) {
            loss += model.plAmount.floatValue;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.netAssetModel.profitLoss = [NSString stringWithFormat:@"%.2f",loss];
            weakSelf.netAssetModel.netAsset = [NSString stringWithFormat:@"%.2f",weakSelf.netAssetModel.available.floatValue + loss + weakSelf.netAssetModel.buildCost.floatValue];
            [weakSelf.mainTableView reloadData];
        });
    }else{
        self.holdArray = [GRCalculateProfitLoss calculateJJProfitLossWithArray:self.holdArray withNotificationDict:dict];
        CGFloat loss = 0.0f;
        for (GRJJHoldPositionModel *model in self.holdArray) {
            loss += model.profitOrLoss.floatValue;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.netAssetModel.profitLoss = [NSString stringWithFormat:@"%.2f",loss];
            weakSelf.netAssetModel.netAsset = [NSString stringWithFormat:@"%.2f",weakSelf.netAssetModel.available.floatValue + loss + weakSelf.netAssetModel.buildCost.floatValue];
            [weakSelf.mainTableView reloadData];
        });
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //初始化参数
    [self initData];
    
    //请求数据
    if ([self.title isEqualToString:TitleName]) {
        [self requestHttpData];
    }else{
        [self requestHttpJJ];
    }
}

//初始化参数
- (void)initData{
    //获取当前时间，日期
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [GRDateFormatter sharedInstance];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    self.startTime = dateString;
    self.endTime = dateString;
}

///吉交所数据
- (void)requestHttpJJ{
    WS(weakSelf)
    ///交易明细
    NSDictionary *paramDict = @{@"r":@"jlmmex/user/historyOrder",
                                @"pageno":@"1",
                                @"pagesize":@"50",
                                @"startTime":self.startTime,
                                @"endTime":self.endTime};
    [SVProgressHUD show];
    [GRNetWorking postWithURLString:@"?r=jlmmex/user/historyOrder" parameters:paramDict callBack:^(NSDictionary *dict) {
        NSString *code = dict[@"status"];
        if (code.integerValue == HttpSuccess) {
            [weakSelf.dataArray removeAllObjects];
            weakSelf.dataArray = [GRJJPropertyDealDetail mj_objectArrayWithKeyValuesArray:dict[@"recordset"][@"list"]];
            [SVProgressHUD dismiss];
        }else if ([dict[@"message"] isEqualToString:@"jlmmex"]){
            GRJJLoginViewController *loginVC = [[GRJJLoginViewController alloc] init];
            [self presentViewController:loginVC animated:YES completion:nil];
            [GRUserDefault removeJJLogin];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.mainTableView reloadData];
        });
    }];
    
    ///用户资产统计
    NSDictionary *paramaDict = @{@"r":@"jlmmex/user/property"};
    [SVProgressHUD show];
    [GRNetWorking postWithURLString:@"?r=jlmmex/user/property" parameters:paramaDict callBack:^(NSDictionary *dict) {
        NSString *code = dict[@"status"];
        if (code.integerValue == HttpSuccess) {
            NSNumber *balance = dict[@"recordset"][@"balance"];
            NSNumber *profitLoss = dict[@"recordset"][@"profitLoss"];
            NSNumber *tradeDeposit = dict[@"recordset"][@"tradeDeposit"];
            NSString *totalJJ = [NSString stringWithFormat:@"%.2f",profitLoss.floatValue + balance.floatValue + tradeDeposit.floatValue];
            weakSelf.netAssetModel = [GRNetAssetsModel mj_objectWithKeyValues:@{@"netAsset":totalJJ,
                                                                                @"profitLoss":[NSString stringWithFormat:@"%.2f",profitLoss.floatValue],
                                                                                @"buildCost":[NSString stringWithFormat:@"%.2f",tradeDeposit.floatValue],
                                                                                @"available":[NSString stringWithFormat:@"%.2f",balance.floatValue]}];
            [SVProgressHUD dismiss];
        }else if ([dict[@"message"] isEqualToString:@"jlmmex"]){
            GRJJLoginViewController *loginVC = [[GRJJLoginViewController alloc] init];
            [self presentViewController:loginVC animated:YES completion:nil];
            [GRUserDefault removeJJLogin];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.mainTableView reloadData];
        });
    }];
    
    //获取用户持仓单列表
    NSDictionary *parDict = @{@"r":@"jlmmex/order/getNotLiquidateOrder"};
    [SVProgressHUD show];
    [GRNetWorking postWithURLString:@"?r=jlmmex/order/getNotLiquidateOrder" parameters:parDict callBack:^(NSDictionary *dict) {
        NSString *code = dict[@"status"];
        if (code.integerValue == HttpSuccess) {
            [self.holdArray removeAllObjects];
            NSArray *array = dict[@"recordset"][@"list"];
            if (array.count) {
                for (NSDictionary *dictModel in array) {
                    GRJJHoldPositionModel *model = [GRJJHoldPositionModel mj_objectWithKeyValues:dictModel];
                    [self.holdArray addObject:model];
                }
            }
            [SVProgressHUD dismiss];
        }else if ([dict[@"message"] isEqualToString:@"jlmmex"]){
            GRJJLoginViewController *loginVC = [[GRJJLoginViewController alloc] init];
            [self presentViewController:loginVC animated:YES completion:nil];
            [GRUserDefault removeJJLogin];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.mainTableView reloadData];
        });
    }];
    
}

///恒大的数据
- (void)requestHttpData{
    //交易流水
    NSDictionary *paramDict = @{@"r":@"baibei/trade/queryOrderLogList",
                                @"type":@"all",
                                @"startNo":@"0",
                                @"endNo":@"500",
                                @"st":self.startTime,
                                @"et":self.endTime};
    WS(weakSelf)
    [SVProgressHUD show];
    [GRNetWorking postWithURLString:@"?r=baibei/trade/queryOrderLogList" parameters:paramDict callBack:^(NSDictionary *dict) {
        NSString *code = dict[@"status"];
        if (code.integerValue == HttpSuccess) {
            NSArray *array = dict[@"recordset"][@"list"];
            [weakSelf.dataArray removeAllObjects];
            weakSelf.dataArray = [GRPropertyDealDetail mj_objectArrayWithKeyValuesArray:array];
            [SVProgressHUD dismiss];
        }else if([dict[@"message"] isEqualToString:@"baibei"]){
            [GRUserDefault removeHDLogin];
            GRHDLoginViewController *loginHD = [[GRHDLoginViewController alloc] init];
            [self presentViewController:loginHD animated:YES completion:nil];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.mainTableView reloadData];
        });
    }];
    
    //获取用户的持仓信息列表
    [SVProgressHUD show];
    [GRNetWorking postWithURLString:@"?r=baibei/user/queryMyBuyList" parameters:@{@"r":@"baibei/user/queryMyBuyList"} callBack:^(NSDictionary *dict) {
        NSString *code = dict[@"status"];
        if (code.integerValue == HttpSuccess) {
            [weakSelf.holdArray removeAllObjects];
            NSArray *array = dict[@"recordset"];
            if (array.count) {
                for (NSDictionary *detailDict in dict[@"recordset"]) {
                    GRPropertyDealDetail *model = [GRPropertyDealDetail mj_objectWithKeyValues:detailDict];
                    [weakSelf.holdArray addObject:model];
                }
            }
            [SVProgressHUD dismiss];
        }else if([dict[@"message"] isEqualToString:@"baibei"]){
            [GRUserDefault removeHDLogin];
            GRHDLoginViewController *loginHD = [[GRHDLoginViewController alloc] init];
            [self presentViewController:loginHD animated:YES completion:nil];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.mainTableView reloadData];
        });
    }];
    
    ///用户资产统计
    NSDictionary *paramaDict = @{@"r":@"baibei/user/property"};
    [SVProgressHUD show];
    [GRNetWorking postWithURLString:@"?r=baibei/user/property" parameters:paramaDict callBack:^(NSDictionary *dict) {
        NSNumber *code = dict[@"status"];
        if ([code isEqualToNumber:@(HttpSuccess)]) {
            
            NSString *balance = dict[@"recordset"][@"balance"];
            NSString *profitLoss = dict[@"recordset"][@"profitLoss"];
            NSString *tradeDeposit = dict[@"recordset"][@"tradeDeposit"];
            NSString *totalHD = [NSString stringWithFormat:@"%.2f",profitLoss.floatValue + balance.floatValue + tradeDeposit.floatValue];
            weakSelf.netAssetModel = [GRNetAssetsModel mj_objectWithKeyValues:@{@"netAsset":totalHD,
                                                                                @"profitLoss":profitLoss,
                                                                                @"buildCost":tradeDeposit,
                                                                                @"available":balance}];
            [SVProgressHUD dismiss];
        }else if([dict[@"message"] isEqualToString:@"baibei"]){
            [GRUserDefault removeHDLogin];
            GRHDLoginViewController *loginHD = [[GRHDLoginViewController alloc] init];
            [self presentViewController:loginHD animated:YES completion:nil];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.mainTableView reloadData];
        });
    }];
    
}

//初始化 tableview
- (void)initTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height - 64) style:UITableViewStyleGrouped];
    self.mainTableView = tableView;
    self.mainTableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
    [self.mainTableView setSeparatorColor:GRColor(223, 223, 223)];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.mainTableView setSeparatorInset:UIEdgeInsetsZero];
    [self.mainTableView setLayoutMargins:UIEdgeInsetsZero];
    
    [self.view addSubview:self.mainTableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        if (self.holdArray.count) {
            return self.holdArray.count;
        }else{
            return 1;
        }
    }else{
        if (self.dataArray.count) {
            return self.dataArray.count;
        }else{
            return 1;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        GRPropertyAssetsCell *cell = [GRPropertyAssetsCell cellWithTableView:tableView];
        cell.netAssets = self.netAssetModel;
        GRRechargeViewController *rechargeVC = [[GRRechargeViewController alloc] init];
        WS(weakSelf)
        cell.rechargeBlcok = ^{
            rechargeVC.charge = YES;
            rechargeVC.title = [NSString stringWithFormat:@"%@充值",[self.title substringToIndex:2]];
            [weakSelf.navigationController pushViewController:rechargeVC animated:YES];
        };
        cell.withdrawBlock = ^{
            rechargeVC.charge = NO;
            rechargeVC.title = [NSString stringWithFormat:@"%@提现",[self.title substringToIndex:2]];
            [weakSelf.navigationController pushViewController:rechargeVC animated:YES];
        };
        cell.ticketBlock = ^{
            GRThicketsViewController *thicketVC = [[GRThicketsViewController alloc] init];
            if ([self.title isEqualToString:TitleName]) {
                thicketVC.title = @"恒大抵金券";
            }else{
                thicketVC.title = @"吉交抵金券";
            }
            [weakSelf.navigationController pushViewController:thicketVC animated:YES];
        };
        return cell;
    }else if (indexPath.section == 1){
        if ([self.title isEqualToString:TitleName]) {  ///恒大
            GRPropertyHoldPositionDetailCell *cell = [GRPropertyHoldPositionDetailCell cellWithTableView:tableView];
            if (self.holdArray.count) {
                GRPropertyDealDetail *model = self.holdArray[indexPath.row];
                cell.tag = indexPath.row;
                WS(weakSelf)
                cell.stopProfitLoss = ^(UIButton *btn){
                    weakSelf.selectedTag = indexPath.row;
                    GRStopAlterView *stopView = [[GRStopAlterView alloc] initWithFrame:CGRectMake(13, K_Screen_Height * 0.5, K_Screen_Width - 26, 203)];
                    stopView.topLimit = model.topLimit;
                    stopView.bottomLimit = model.bottomLimit;
                    weakSelf.toplimit = [NSString stringWithFormat:@"%.0f",model.topLimit.floatValue * 100];
                    weakSelf.bottomLimit = [NSString stringWithFormat:@"%.0f",model.bottomLimit.floatValue * 100];
                    stopView.delegate = self;
                    GRBlurEffect *blurEffect = [[GRBlurEffect alloc] init];
                    _blurEffect = blurEffect;
                    [blurEffect addEffectiVieAndAlterView:stopView];
                };
                cell.closePosition = ^{
                    weakSelf.selectedTag = indexPath.row;
                    GRCloseAlterView *closeView = [[GRCloseAlterView alloc] initWithFrame:CGRectMake(13, K_Screen_Height * 0.5, K_Screen_Width - 26, 203) stringKinds:model.proDesc stringNew:model.sellPrice stringWin:model.plAmount];
                    closeView.delegate = self;
                    GRBlurEffect *blurEffect = [[GRBlurEffect alloc] init];
                    _blurEffect = blurEffect;
                    [_blurEffect addEffectiVieAndAlterView:closeView];
                };
                cell.holdPositionModel = model;
                return cell;
            }else{
                GRPropertyHoldPositionDetailNoDataCell *cell = [GRPropertyHoldPositionDetailNoDataCell cellWithTableView:tableView];
                cell.delegate = self;
                return cell;
            }
        }else{          ///吉交所
            GRJJPropertyHoldPositionDetailCell *cell = [GRJJPropertyHoldPositionDetailCell cellWithTableView:tableView];
            if (self.holdArray.count) {
                GRJJHoldPositionModel *model = self.holdArray[indexPath.row];
                WS(weakSelf)
                cell.stopProfitLoss = ^(UIButton *btn){
                    weakSelf.selectedTag = indexPath.row;
                    GRStopAlterView *stopView = [[GRStopAlterView alloc] initWithFrame:CGRectMake(13, K_Screen_Height * 0.5, K_Screen_Width - 26, 203)];
                    if (![self.title isEqualToString:TitleName]){
                        stopView.maxTop = 200;
                        stopView.minBottom = 90;
                    }
                    stopView.topLimit = model.targetProfit;
                    stopView.bottomLimit = model.stopLoss;
                    weakSelf.toplimit = [NSString stringWithFormat:@"%.2f",model.targetProfit.floatValue * 100];
                    weakSelf.bottomLimit = [NSString stringWithFormat:@"%.2f",model.stopLoss.floatValue * 100];
                    stopView.delegate = self;
                    GRBlurEffect *blurEffect = [[GRBlurEffect alloc] init];
                    _blurEffect = blurEffect;
                    [blurEffect addEffectiVieAndAlterView:stopView];
                };
                cell.closePosition = ^{
                    weakSelf.selectedTag = indexPath.row;
                    GRCloseAlterView *closeView = [[GRCloseAlterView alloc] initWithFrame:CGRectMake(13, K_Screen_Height * 0.5, K_Screen_Width - 26, 203) stringKinds:model.productName stringNew:[NSString stringWithFormat:@"%.2f",model.currentprice.floatValue] stringWin:[NSString stringWithFormat:@"%.2f",model.profitOrLoss.floatValue]];
                    closeView.delegate = self;
                    GRBlurEffect *blurEffect = [[GRBlurEffect alloc] init];
                    _blurEffect = blurEffect;
                    [_blurEffect addEffectiVieAndAlterView:closeView];
                };
                cell.holdPositionModel = model;
            }else{
                GRPropertyHoldPositionDetailNoDataCell *cell = [GRPropertyHoldPositionDetailNoDataCell cellWithTableView:tableView];
                cell.delegate = self;
                return cell;
            }
            return cell;
        }
    } else{
        GRPropertyDealDetailCell *cell = [GRPropertyDealDetailCell cellWithTableView:tableView];
    //        cell.delegate = self;
        if (self.dataArray.count) {
            if ([self.title isEqualToString:TitleName]){
                cell.dealDetailModel = self.dataArray[indexPath.row];
            }else{
                cell.JJDetailModel = self.dataArray[indexPath.row];
            }
            WS(weakSelf)
            cell.arrowBlock = ^(BOOL isUnfold){
                if (!indexPath) return ;
                weakSelf.isUnfold = isUnfold;
                [weakSelf.mainTableView beginUpdates];
                [weakSelf.mainTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [weakSelf.mainTableView endUpdates];
                [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            };
            return cell;
        }else{
            GRPropertyDealDetailNoDataCell *cell = [GRPropertyDealDetailNoDataCell cellWithTableView:tableView];
            return cell;
        }
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 200;
    }else if (indexPath.section == 1){
        if (self.holdArray.count) {
            if (iPhone5) {
                return 128;
            }else if (iPhone6){
                return 140;
            } else{
                return 145;
            }
        }else{
            return 88;
        }
    } else{
        if (self.dataArray.count) {
            if ([self.title isEqualToString:TitleName]){ ///恒大
                GRPropertyDealDetail *model = self.dataArray[indexPath.row];
                if (model.isUnfold) {
                    return 44 + 105;
                }else{
                    return 44;
                }
            }else{      ///吉交所
                GRJJPropertyDealDetail *model = self.dataArray[indexPath.row];
                if (model.isUnfold) {
                    return 44 + 105;
                }else{
                    return 44;
                }
            }
        }else{
            return 60;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.0001;
    }else{
        return 30;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1 || section == 2) {
        GRPropertyAssetsHeaderView *header = [[GRPropertyAssetsHeaderView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 30)];
        if (section == 1) {
            header.title = @"持仓情况";
        }else{
            header.title = @"交易明细";
            header.startTime = self.startTime;
            header.endTime = self.endTime;
        }
        header.delegate = self;
        return header;
    }else{
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        //将索引加到数组中
        NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        //判断选中不同row状态时候
        if (self.selectedIndex != nil && indexPath.row == self.selectedIndex.row) {
            //将选中的和所有索引都加进数组中
            self.isUnfold = !self.isUnfold;
        }else if (self.selectedIndex != nil && indexPath.row != self.selectedIndex.row) {
            indexPaths = [NSArray arrayWithObjects:indexPath,self.selectedIndex, nil];
            self.isUnfold = !self.isUnfold;
        }else{
            self.isUnfold = YES;
        }
        
        if ([self.title isEqualToString:TitleName]){
            GRPropertyDealDetail *model = self.dataArray[indexPath.row];
            model.unfold = self.isUnfold;
        }else{
            GRJJPropertyDealDetail *model = self.dataArray[indexPath.row];
            model.unfold = self.isUnfold;
        }
        
        //记下选中的索引
        self.selectedIndex = indexPath;
        
        //刷新
        [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

#pragma mark - GRPropertyHoldPositionDetailNoDataCellDelegate
- (void)propertyHoldPositionDetailNoDataCell:(GRPropertyHoldPositionDetailNoDataCell *)cell didClickDealBtn:(UIButton *)btn{
    GRTabBarController *tabbarVC = (GRTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    tabbarVC.selectedIndex = 2;
    UINavigationController *navigationVC = (UINavigationController *)tabbarVC.selectedViewController;
    GRPropertyViewController *propertyVC = (GRPropertyViewController *)navigationVC.topViewController;
    if ([self.title isEqualToString:TitleName]) {
        propertyVC.clickCurrentProductTag = 0;
    }else{
        propertyVC.clickCurrentProductTag = 1;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - GRPropertyAssetsHeaderViewDelegate
- (void)gr_propertyAssetsHeaderView:(GRPropertyAssetsHeaderView *)view didClickSelectedTime:(UIButton *)btn{
    WS(weakSelf)
    XHDatePickerView *datepicker = [[XHDatePickerView alloc] initWithCompleteBlock:^(NSDate *startDate,NSDate *endDate) {
        if ([startDate stringWithFormat:@"yyyy-MM-dd"]) {
            weakSelf.startTime = [startDate stringWithFormat:@"yyyy-MM-dd"];
        }
        if ([endDate stringWithFormat:@"yyyy-MM-dd"]) {
            weakSelf.endTime = [endDate stringWithFormat:@"yyyy-MM-dd"];
        }
        //请求数据
        if ([weakSelf.title isEqualToString:TitleName]) {
            [self requestHttpData];
        }else{
            [self requestHttpJJ];
        }
    }];
    datepicker.datePickerStyle = DateStyleShowYearMonthDay;
    datepicker.dateType = DateTypeStartDate;
    datepicker.minLimitDate = [NSDate date:@"1949-01-01" WithFormat:@"yyyy-MM-dd"];
    datepicker.maxLimitDate = [NSDate date:@"2050-12-12" WithFormat:@"yyyy-MM-dd"];
    [datepicker show];
}

#pragma mark - GRPropertyDealDetailCellDelegate
- (void)propertyDealDetailCell:(GRPropertyDealDetailCell *)cell didClickUnfoldBtn:(BOOL)unfold{
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    if (!indexPath) return ;
    [self.mainTableView beginUpdates];
    [self.mainTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.mainTableView endUpdates];
}

#pragma mark - setter and getter
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)holdArray{
    if (!_holdArray) {
        _holdArray = [NSMutableArray array];
    }
    return _holdArray;
}

///平仓
- (void)closeAlterButton:(UIButton *)sender{
    UIView *viewTemp = sender.superview;
    if ([self.title isEqualToString:TitleName]){
        if (sender.tag == 100) {        //点击取消按钮
            
        }else{
            GRPropertyDealDetail *model = self.holdArray[self.selectedTag];
            NSDictionary *dicParam = @{@"r":@"baibei/trade/closeOrder",
                                       @"orderId":model.orderId,
                                       @"contract":HD_Contact};
            [GRNetWorking postWithURLString:@"?r=baibei/trade/closeOrder" parameters:dicParam callBack:^(NSDictionary *dict) {
                NSNumber *status = dict[@"status"];
                if ([status isEqualToNumber:@(HttpSuccess)]) {
                    [SVProgressHUD showSuccessWithStatus:dict[@"message"]];
                    //请求数据
                    [self requestHttpData];
                    [[NSNotificationCenter defaultCenter] postNotificationName:GRPositionHoldOrStopNotification object:nil];
                }else if([dict[@"message"] isEqualToString:@"baibei"]){
                    [GRUserDefault removeHDLogin];
                    GRHDLoginViewController *loginHD = [[GRHDLoginViewController alloc] init];
                    [self presentViewController:loginHD animated:YES completion:nil];
                }else{
                    [SVProgressHUD showInfoWithStatus:dict[@"message"]];
                }
            }];
        }
    }else{  ///吉交所
        if (sender.tag == 100) {        //点击取消按钮
            
        }else{
            GRJJHoldPositionModel *model = self.holdArray[self.selectedTag];
            NSDictionary *dicParam = @{@"r":@"jlmmex/order/liquidate",
                                       @"orderId":model.orderID};
            [GRNetWorking postWithURLString:@"?r=jlmmex/order/liquidate" parameters:dicParam callBack:^(NSDictionary *dict) {
                NSNumber *status = dict[@"status"];
                if ([status isEqualToNumber:@(HttpSuccess)]) {
                    [SVProgressHUD showSuccessWithStatus:dict[@"message"]];
                    //请求数据
                    [self requestHttpJJ];
                    [[NSNotificationCenter defaultCenter] postNotificationName:GRPositionHoldOrStopNotification object:nil];
                }else if ([dict[@"message"] isEqualToString:@"jlmmex"]){
                    GRJJLoginViewController *loginVC = [[GRJJLoginViewController alloc] init];
                    [self presentViewController:loginVC animated:YES completion:nil];
                    [GRUserDefault removeJJLogin];
                }else{
                    [SVProgressHUD showErrorWithStatus:dict[@"message"]];
                }
            }];
        }
    }
    [viewTemp.superview removeFromSuperview];
}

///止盈止损
- (void)stopAlterButton:(UIButton *)sender{
    [self.mainTableView endEditing:YES];
    UIView *viewTemp = sender.superview;
    
    if ([self.title isEqualToString:TitleName]){
        if (sender.tag == 100) {
            
        }else{
            if (self.toplimit == nil) {
                self.toplimit = @"0";
            }
            
            if (self.bottomLimit == nil) {
                self.bottomLimit = @"0";
            }
            GRPropertyDealDetail *model = self.holdArray[self.selectedTag];
            NSDictionary *dicParam = @{@"r":@"baibei/trade/updateOrder",
                                       @"orderId":model.orderId,
                                       @"contract":HD_Contact,
                                       @"toplimit":self.toplimit,
                                       @"bottomlimit":self.bottomLimit};
            [GRNetWorking postWithURLString:@"?r=baibei/trade/updateOrder" parameters:dicParam callBack:^(NSDictionary *dict) {
                NSNumber *status = dict[@"status"];
                if ([status isEqualToNumber:@(HttpSuccess)]) {
                    [SVProgressHUD showSuccessWithStatus:dict[@"message"]];
                    //请求数据
                    [self requestHttpData];
                }else if([dict[@"message"] isEqualToString:@"baibei"]){
                    [GRUserDefault removeHDLogin];
                    GRHDLoginViewController *loginHD = [[GRHDLoginViewController alloc] init];
                    [self presentViewController:loginHD animated:YES completion:nil];
                }else{
                    [SVProgressHUD showInfoWithStatus:dict[@"message"]];
                }
            }];
        }
    }else{      ///吉交所
        if (sender.tag == 100) {
            
        }else{
            if (self.toplimit == nil) {
                self.toplimit = @"0";
            }
            
            if (self.bottomLimit == nil) {
                self.bottomLimit = @"0";
            }
            GRJJHoldPositionModel *model = self.holdArray[self.selectedTag];
            NSDictionary *dicParam = @{@"r":@"jlmmex/order/setPriceLimit",
                                       @"orderId":model.orderID,
                                       @"targetProfit":self.toplimit,
                                       @"stopLoss":self.bottomLimit};
            [GRNetWorking postWithURLString:@"?r=jlmmex/order/setPriceLimit" parameters:dicParam callBack:^(NSDictionary *dict) {
                NSNumber *status = dict[@"status"];
                if ([status isEqualToNumber:@(HttpSuccess)]) {
                    [SVProgressHUD showSuccessWithStatus:dict[@"message"]];
                    //请求数据
                    [self requestHttpJJ];
                }else if ([dict[@"message"] isEqualToString:@"jlmmex"]){
                    GRJJLoginViewController *loginVC = [[GRJJLoginViewController alloc] init];
                    [self presentViewController:loginVC animated:YES completion:nil];
                    [GRUserDefault removeJJLogin];
                }else{
                    [SVProgressHUD showErrorWithStatus:dict[@"message"]];
                }
            }];
        }
    }
    
    [viewTemp.superview removeFromSuperview];
}

///设置止盈止损数值
- (void)getWinOrLoseNumber:(UIView *)view number:(NSInteger)number{
    if (view.tag == 100) {
        self.toplimit = [NSString stringWithFormat:@"%zd",number];
    }else if (view.tag == 101){
        self.bottomLimit = [NSString stringWithFormat:@"%zd",number];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GRPositionNew_PriceSNotification object:nil];
}

@end
