//
//  GRAnalystDetailViewController.m
//  GoldRush
//
//  Created by Jack on 2017/1/5.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRAnalystDetailViewController.h"
#import "GRMyPlanViewController.h"
#import "GRHistoryListViewController.h"
#import "GRHistoryOpinionViewController.h"

#import "UIBarButtonItem+GRItem.h"

#import "GRAnalystDetailCell.h"
#import "GRPlanIntroduceCell.h"
#import "GRTradeRiskCell.h"
#import "GRTheNewestOpinionCell.h"

#import "GRMyPlanHeaderView.h"
#import "GRJoinPlanView.h"

#import "GRTheNewestOpinion.h"
#import "GRTheNewestOpinionFrame.h"

@interface GRAnalystDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *mainTableView;

@property(nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation GRAnalystDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化 tableview
    [self initTableView];
    
    //设置子控件
    [self setupUI];
    
    //模拟数据
    NSArray *array = [self creatModelsWithCount:10];
    for (GRTheNewestOpinion *model  in array) {
        GRTheNewestOpinionFrame *frameModel = [[GRTheNewestOpinionFrame alloc] init];
        frameModel.opinionModel = model;
        [self.dataArray addObject:frameModel];
    }
    
}

#pragma mark - private method

- (NSArray *)creatModelsWithCount:(NSInteger)count{
    NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     ];
    
    NSArray *namesArray = @[@"OneWang_iOS",
                            @"风芊语芊寻上的猪",
                            @"芊语芊寻",
                            @"我叫芊语芊寻",
                            @"Hel芊语芊寻tty"];
    
    NSArray *time = @[@"12:30",@"4:350",@"6:30",@"8:30",@"9:30",@"3:30",@"2:37",@"2:39"];
    
    NSArray *phone = @[@"白银多头梦碎",@"要长期出差两",@"要长期出差两",@"不要长期处于这种",@"于这种模式"];
    
    NSArray *textArray = @[@"作为应届毕业生的我和老板mage 时屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期出差两天，学到了这些大屏幕一切按照 320 宽度渲染，屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"然后等比例拉伸到大屏。这种情况下对界面不会产生任芊语芊度返回 320这种模式下对界面不会产寻把小屏完全拉伸。",
                           @"当你的 app 没有提供 3x 的 LaunchImage 时屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 32拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。",
                           @"但是建议不要长期处于这种模式mage 时屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
                           @"屏幕宽度返回 32比例拉伸到mage 时屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。"
                           ];
    
    
    NSArray *picImageNamesArray = @[ @"0.jpg",
                                     @"1.jpg",
                                     @"2.jpg",
                                     ];
    NSMutableArray *resArr = [NSMutableArray new];
    
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(5);
        int nameRandomIndex = arc4random_uniform(5);
        int contentRandomIndex = arc4random_uniform(5);
        int timeRandomIndex = arc4random_uniform(8);
        int phoneRandomIndex = arc4random_uniform(5);
        
        GRTheNewestOpinion *model = [GRTheNewestOpinion new];
        model.iconName = iconImageNamesArray[iconRandomIndex];
        model.name = namesArray[nameRandomIndex];
        model.desc = textArray[contentRandomIndex];
        model.time = time[timeRandomIndex];
        model.title = phone[phoneRandomIndex];
        
        // 模拟“随机图片”
        int random = arc4random_uniform(3);
        
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < random; i++) {
            int randomIndex = arc4random_uniform(3);
            [temp addObject:picImageNamesArray[randomIndex]];
        }
        if (temp.count) {
            model.picNamesArray = [temp copy];
        }
        [resArr addObject:model];
    }
    return [resArr copy];
}

//设置子控件
- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"我的计划" target:self action:@selector(myPlanClick)];
    //创建底部加入计划按钮
    GRJoinPlanView *bottomView = [[GRJoinPlanView alloc] initWithFrame:CGRectMake(0, K_Screen_Height - 64, K_Screen_Width, 64)];
    bottomView.backgroundColor = [UIColor redColor];
    [self.view addSubview:bottomView];
    [self.view bringSubviewToFront:bottomView];
}

//初始化 tableview
- (void)initTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height - 64) style:UITableViewStyleGrouped];
    self.mainTableView = tableView;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
}

#pragma mark - event response
- (void)myPlanClick{
    GRMyPlanViewController *planVC = [[GRMyPlanViewController alloc] init];
    planVC.title = @"我的计划";
    [self.navigationController pushViewController:planVC animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        GRAnalystDetailCell *cell = [GRAnalystDetailCell cellWithTableView:tableView];
        return cell;
    }else if(indexPath.section == 1){
        GRPlanIntroduceCell *cell = [GRPlanIntroduceCell cellWithTableView:tableView];
        return cell;
    }else if (indexPath.section == 2){
        static NSString *cellID = @"doing";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        }
        cell.textLabel.text = @"加入计划后才能看到实时做单";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    }else if (indexPath.section == 3){
        GRTheNewestOpinionCell *cell = [GRTheNewestOpinionCell cellWithTableView:tableView];
        GRTheNewestOpinionFrame *frame = self.dataArray[indexPath.row];
        cell.opinionFrame = frame;
        cell.isShowArrow = YES;
        return cell;
    } else{
        GRTradeRiskCell *cell = [GRTradeRiskCell cellWithTableView:tableView];
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 90;
    }else if(indexPath.section == 1){
        return 200;
    }else if (indexPath.section == 2){
        return 100;
    }else if (indexPath.section == 4){
        return 32;
    } else{
        GRTheNewestOpinionFrame *frame = self.dataArray[indexPath.row];
        return frame.rowHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2 || section == 3) {
        return 30;
    }else{
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1 || section == 2) {
        return 10;
    }else{
        return 0.0001;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        GRMyPlanHeaderView *view = [[GRMyPlanHeaderView alloc] initWithFrame:CGRectMake(0, 10, K_Screen_Width, 30)];
        view.title = @"正在做单";
        view.btnTitle = @"历史做单";
        WS(weakSelf)
        view.btnClick = ^(NSString *type){
            GRHistoryListViewController *historyVC = [[GRHistoryListViewController alloc] init];
            historyVC.title = @"历史做单";
            [weakSelf.navigationController pushViewController:historyVC animated:YES];
        };
        return view;
    }else if (section == 3){
        GRMyPlanHeaderView *header = [[GRMyPlanHeaderView alloc] initWithFrame:CGRectMake(0, 10, K_Screen_Width, 30)];
        header.title = @"最新观点";
        header.btnTitle = @"历史观点";
        WS(weakSelf)
        header.btnClick = ^(NSString *type){
            GRHistoryOpinionViewController *historyVC = [[GRHistoryOpinionViewController alloc] init];
            historyVC.title = @"分析师观点";
            [weakSelf.navigationController pushViewController:historyVC animated:YES];
        };
        return header;
    }else{
        return nil;
    }
}

#pragma mark - setter and getter 
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
