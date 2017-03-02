//
//  GRMessageCenterViewController.m
//  GoldRush
//
//  Created by Jack on 2017/1/17.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRMessageCenterViewController.h"
#import "GRSettingItem.h"                       ///设置模型
#import "GRSystemMessageViewController.h"       ///系统
#import "GRCommentMessageViewController.h"      ///朋友圈消息
#import "GRSettingViewController.h"             ///设置控制器
#import "GRMineCell.h"                          ///我的 cell

#import "GRMessageCell.h"                       ///消息 cell
#import "GRMessageCenterModel.h"                ///消息模型

@interface GRMessageCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *messageArray;

@end

@implementation GRMessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //初始化 tableview
    [self initTableView];
    
    //初始化数据
    [self initData];
}

- (void)initTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
}

- (void)initData{
    GRSettingItem *system = [GRSettingItem itemWithIcon:@"Mine_System_Message" title:@"系统" destVcClass:[GRSystemMessageViewController class]];
    GRSettingItem *setting = [GRSettingItem itemWithIcon:@"Mine_Message_Setting" title:@"设置" destVcClass:[GRSettingViewController class]];

    self.dataArray = @[system,setting];
    
    self.messageArray = [GRMessageCenterModel mj_objectArrayWithKeyValuesArray:@[
  @{@"message":@"fadafsd 打多少发士大夫撒地方的沙发沙发上的发fadafsd 打多少发士大夫撒地方的沙发沙发上的发生的发生发的",@"time":@"2017-01 12:23"},
  @{@"message":@"fadafsd 打多少发士大夫撒地方fa撒地方fadafsd 打多少发士大夫撒地方的沙发沙发上的发的沙发沙发上的发生的发生发的",@"time":@"2017-01 12:23"},
  @{@"message":@"fadafsd 打多少发士大夫撒地方的沙发沙发上的发生的发生发的",@"time":@"2017-01 12:23"}]];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.messageArray.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.dataArray.count;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        GRMineCell *cell = [GRMineCell cellWithTableView:tableView];
        cell.item = self.dataArray[indexPath.row];
        return cell;
    }else{
        GRMessageCell *cell = [GRMessageCell cellWithTableView:tableView];
        cell.messageModel = self.messageArray[indexPath.section - 1];
        WS(weakSelf)
        cell.detailBlock = ^(BOOL isUnfold){
            if (!indexPath) return ;
            [weakSelf.tableView beginUpdates];
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [weakSelf.tableView endUpdates];
        };
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44;
    }else{
        GRMessageCenterModel *model = self.messageArray[indexPath.section - 1];
        if (model.isUnFold) {
            return model.cellHeight;
        }else{
            return 80;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.001;
    }else{
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        GRSettingItem *item = self.dataArray[indexPath.row];
        if (item.destVcClass) {
            UIViewController *vc = [[item.destVcClass alloc] init];
            vc.title = item.title;
            [self.navigationController pushViewController:vc  animated:YES];
        }
    }
}

#pragma mark - setter and getter


@end
