//
//  GRChippedAnalystViewController.m
//  GoldRush
//
//  Created by Jack on 2017/1/11.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRChippedAnalystViewController.h"

#import "GRAnalystCell.h"                   ///分析师 cell
#import "GRChippedAnalystPlanCell.h"        ///分析师计划 cell
#import "GRChippedJoinPlanCell.h"           ///加入计划 cell
#import "PopView.h"                         ///弹出 view
#import "GRChippedPlanView.h"               ///分析师计划怎么玩的头部
#import "GRAnalystDetailViewController.h"   ///分析师详情
#import "GRChippedCarouselView.h"           ///头部轮播
#import "GRCarouselViewController.h"        ///头部轮播详情

@interface GRChippedAnalystViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, weak) UITableView *tableView;    ///tableview

@end

@implementation GRChippedAnalystViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化tableview
    [self initTableView];
}

- (void)initTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    } else{
        return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        GRAnalystCell *cell = [GRAnalystCell cellWithTableView:tableView];
        return cell;
    }else if (indexPath.section == 1){
        GRChippedAnalystPlanCell *planCell = [GRChippedAnalystPlanCell cellWithTableView:tableView];
        return planCell;
    }else{
        GRChippedJoinPlanCell *joinCell = [GRChippedJoinPlanCell cellWithTableView:tableView];
        WS(weakSelf)
        joinCell.joinPlanBlock = ^{
            PopView *view = [[PopView alloc] initWithFrame:[UIScreen mainScreen].bounds withTitle:@"很遗憾"];
            [weakSelf.view addSubview:view];
            [weakSelf.view bringSubviewToFront:view];
        };
        return joinCell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 150;
    }else if(indexPath.section == 1){
        return 100;
    }else{
        return 100;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 168;
    } else if (section == 1) {
        return 28;
    }else if (section == 2){
        return 10;
    } else{
        return 0.0001;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 150)];
        //创建轮播图
        GRChippedCarouselView *carousel = [[GRChippedCarouselView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 127)];
        carousel.messageArray = [NSMutableArray arrayWithArray:@[@"a用户全民小刀刚刚加入了郑成功计划!",@"b用户全民小刀刚刚加入了郑成功计划!",@"c用户全民小刀刚刚加入了郑成功计划!",@"d用户全民小刀刚刚加入了郑成功计划!",@"e用户全民小刀刚刚加入了郑成功计划!"]];
        WS(weakSelf);
        carousel.carouselClick = ^(NSInteger index){
            GRCarouselViewController *carouselVC = [[GRCarouselViewController alloc] init];
            [weakSelf.navigationController pushViewController:carouselVC animated:YES];
        };
        [view addSubview:carousel];
        //标题
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 145, K_Screen_Width, 25)];
        title.backgroundColor = [UIColor whiteColor];
        title.text = @"    分析师";
        [view addSubview:title];
        return view;
    }else if (section == 1) {
        GRChippedPlanView *header = [[GRChippedPlanView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 28)];
        return header;
    }else{
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        GRAnalystDetailViewController *detailVC = [[GRAnalystDetailViewController alloc] init];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}


@end
