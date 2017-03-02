//
//  GRMyPlanViewController.m
//  GoldRush
//
//  Created by Jack on 2017/1/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRMyPlanViewController.h"

#import "GRMyPlanHeader.h"
#import "GRMyPlanFooter.h"

#import "GRUnderWayCell.h"
#import "GRHistoryListCell.h"

@interface GRMyPlanViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *mainTableView;

@end

@implementation GRMyPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置 UI
    [self setupUI];
    //初始化 tableview
    [self initTableView];
}

- (void)setupUI{
    
}

//初始化 tableview
- (void)initTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height) style:UITableViewStyleGrouped];
    self.mainTableView = tableView;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellID = @"myplan";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        }
        cell.textLabel.text = @"跟单信息表";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    }else if(indexPath.section == 1){
        GRUnderWayCell *cell = [GRUnderWayCell cellWithTableView:tableView];
        return cell;
    }else{
        GRHistoryListCell *cell = [GRHistoryListCell cellWithTableView:tableView];
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44;
    }else if(indexPath.section == 1){
        return 70;
    }else{
        return 90;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1 || section == 2) {
        return 30;
    }else{
        return 0.0001;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0 || section == 1) {
        return 10;
    }else if (section == 2){
        return 57;
    } else{
        return 0.0001;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        GRMyPlanHeader *header = [[GRMyPlanHeader alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 30)];
        header.title = @"正在进行";
        return header;
    }else if (section == 2){
        GRMyPlanHeader *header = [[GRMyPlanHeader alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 30)];
        header.title = @"历史做单";
        return header;
    } else{
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 2) {
        GRMyPlanFooter *footer = [[GRMyPlanFooter alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 57)];
        return footer;
    }else{
        return nil;
    }
}


@end
