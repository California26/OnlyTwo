//
//  GRAnalystViewController.m
//  GoldRush
//
//  Created by Jack on 2017/1/5.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRAnalystViewController.h"

#import "GRAnalystCell.h"                   ///分析师 cell
#import "GRChippedAnalystPlanCell.h"        ///分析师计划 cell
#import "GRChippedJoinPlanCell.h"           ///加入计划 cell
#import "PopView.h"                         ///弹出 view
#import "GRChippedPlanView.h"               ///分析师计划如何玩
#import "GRAnalystDetailViewController.h"   ///分析师详情

#import "GRScrollViewController.h"

@interface GRAnalystViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (assign, nonatomic) CGFloat scrollOffsetY;  ///Y轴偏移量
@property(nonatomic, weak) UITableView *tableView;    ///tableview

@end

@implementation GRAnalystViewController


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height - 115) style:UITableViewStyleGrouped];
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
        return 120;
    }else if(indexPath.section == 1){
        return 70;
    }else{
        return 90;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
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
    if (section == 1) {
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

#pragma mark - UIScrollViewDelegate
// 监控内部的滚动视图的位置
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset_y = scrollView.contentOffset.y;
    CGFloat offset_x = scrollView.contentOffset.x;
    if (!self.parentViewController) return;
    if (![self.parentViewController isKindOfClass:[GRScrollViewController class]]) return;
    
    GRScrollViewController *scroll = (GRScrollViewController *)self.parentViewController;
    if (scroll.scrollDistance <= 0)     return;     // 父视图不能滚动
    
    if (scroll.canScrollUp) {  // 父控制器 scroll 可以向上滚动
        if (_scrollOffsetY < scroll.scrollDistance) {   // 累计偏移量
            _scrollOffsetY += offset_y;
            if (offset_y > 0) {     // scrollView 不能滚动, 父视图可以滚动
                scrollView.contentOffset = CGPointMake(offset_x, 0);
            }
        } else {
            _scrollOffsetY = offset_y + scroll.scrollDistance;
        }
        // 父视图滚动, 把子视图 scrollView 的累计偏移量传递到 scroll 中
        [scroll scrollWithOffset:_scrollOffsetY];
    } else {    // 父控制器 scroll 不能向上滚动
        if (offset_y < 0) {     // scroll 已经滚动到顶部, 不能再继续向上滚动了
            // 此时如果 scrollView 下拉, 偏移量小于0, scroll 向下偏移;
            [scroll scrollWithOffset:offset_y];
        }
        // 偏移量大于0, 就是 scrollView 自己下拉, 不影响 scroll.
    }
    
    if (_scrollOffsetY <= 0) {
        _scrollOffsetY = 0;
    }
}

@end
