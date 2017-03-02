//
//  GRDocumentaryIntroduceViewController.m
//  GoldRush
//
//  Created by Jack on 2017/1/9.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRDocumentaryIntroduceViewController.h"
#import "GRIntroduceUserCell.h"                     ///显示用户信息的 cell
#import "GRIntroduceHeaderView.h"                   ///显示当前组头标题
#import "GRHistoryProfitCell.h"                     ///历史盈利统计
#import "GRIntroduceTotalProfitCell.h"              ///累计盈利 cell
#import "GRUserProfitCell.h"                        ///用户盈利 cell
#import "GRBottomFellowView.h"                      ///悬浮关注按钮
#import "GRProfitStatusCell.h"                      ///盈利状况 cell

@interface GRDocumentaryIntroduceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *mainTableView;

@end

@implementation GRDocumentaryIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化 tableview
    [self initTableView];

}

//初始化 tableview
- (void)initTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height - 46) style:UITableViewStyleGrouped];
    self.mainTableView = tableView;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    tableView.backgroundColor = GRColor(240, 240, 240);
    
    GRBottomFellowView *btnView = [[GRBottomFellowView alloc] initWithFrame:CGRectMake(0, K_Screen_Height - 46, K_Screen_Width, 46)];
    [self.view addSubview:btnView];
    [self.view bringSubviewToFront:btnView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 1 || section == 2) {
        return 1;
    }else{
        return 11;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        GRIntroduceUserCell *cell = [GRIntroduceUserCell cellWithTableView:tableView];
        return cell;
    }else if (indexPath.section == 1){
        GRProfitStatusCell *cell = [GRProfitStatusCell cellWithTableView:tableView];
        return cell;
    } else if (indexPath.section == 2){
        GRHistoryProfitCell *cell = [GRHistoryProfitCell cellWithTableView:tableView];
        return cell;
    }else if (indexPath.row == 0 && indexPath.section == 3){
        GRIntroduceTotalProfitCell *cell = [GRIntroduceTotalProfitCell cellWithTableView:tableView];
        cell.totalProfit = @"累计帮大家赚了2343243元";
        return cell;
    } else{
        GRUserProfitCell *cell = [GRUserProfitCell cellWithTableView:tableView];
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 45;
    }else if(indexPath.section == 1){
        return 231;
    }else if (indexPath.section == 2){
        return 59;
    }else if (indexPath.section == 3 && indexPath.row == 0){
        return 37;
    } else{
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 30;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    GRIntroduceHeaderView *header = [[GRIntroduceHeaderView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 30)];
    if (section == 1) {
        header.title = @"最近10单盈利状况";
        return header;
    }else if (section == 2){
        header.title = @"历史盈利统计";
        return header;
    }else if(section == 3){
        header.title = @"跟单盈利表";
        return header;
    }else{
        return nil;
    }
}

@end
