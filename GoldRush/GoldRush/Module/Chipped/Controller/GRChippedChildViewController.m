//
//  GRChippedChildViewController.m
//  GoldRush
//
//  Created by Jack on 2017/1/9.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRChippedChildViewController.h"
#import "GRNoParticipateChippedCell.h"          ///未参与合买
#import "GRFellowTarentoView.h"                 ///我的关注达人
#import "GRNoHoldPositionCell.h"                ///未持仓
#import "GRHoldPositionCell.h"                  ///已持仓

@interface GRChippedChildViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *mainTableView;
@end

@implementation GRChippedChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //初始化 tableview
    [self initTableView];
}


//初始化 tableview
- (void)initTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height - 114) style:UITableViewStyleGrouped];
    self.mainTableView = tableView;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    tableView.backgroundColor = GRColor(240, 240, 240);
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        GRNoParticipateChippedCell *cell = [GRNoParticipateChippedCell cellWithTableView:tableView];
        return cell;
    }else if (indexPath.section == 1){
        GRHoldPositionCell *cell = [GRHoldPositionCell cellWithTableView:tableView];
        return cell;
    }else{
        GRNoHoldPositionCell *cell = [GRNoHoldPositionCell cellWithTableView:tableView];
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 50;
    }else if (indexPath.section == 1){
        return 274;
    }else{
        return 85;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 34;
    }else if (section == 2){
        return 0.0001;
    } else{
        return 10;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        GRFellowTarentoView *header = [[GRFellowTarentoView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 34)];
        return header;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

@end
