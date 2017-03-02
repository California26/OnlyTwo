//
//  GRAttentionViewController.m
//  GoldRush
//
//  Created by Jack on 2017/1/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRAttentionViewController.h"
#import "GRDynamicStateCell.h"          //动态 cell
#import "GRDynamicStateCellFrame.h"     //frame 模型
#import "GRDynamicStateModel.h"         //数据模型

@interface GRAttentionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;             ///tableView
@property (nonatomic, strong) NSMutableArray *dataArray;         ///数组

@end

@implementation GRAttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //初始化 tableview
    [self initTableView];
    
    //模拟数据
    NSArray *array = [self creatModelsWithCount:10];
    for (GRDynamicStateModel *model  in array) {
        GRDynamicStateCellFrame *frameModel = [[GRDynamicStateCellFrame alloc] init];
        frameModel.dynamicModel = model;
        [self.dataArray addObject:frameModel];
    }
}

//初始化 tableview
- (void)initTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height - 115 - 64 - 40) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (NSArray *)creatModelsWithCount:(NSInteger)count{
    NSArray *iconImageNamesArray = @[@"Suggestion",
                                     @"Suggestion",
                                     @"Suggestion",
                                     @"Suggestion",
                                     @"Suggestion",
                                     ];
    
    NSArray *namesArray = @[@"OneWang_iOS",
                            @"风芊语芊寻上的猪",
                            @"芊语芊寻",
                            @"我叫芊语芊寻",
                            @"Hel芊语芊寻tty"];
    
    NSArray *time = @[@"12:30",@"4:30",@"6:30",@"8:30",@"9:30",@"3:30",@"2:37",@"2:39"];
    
    NSArray *phone = @[@"小米",@"苹果",@"三星",@"诺基亚",@"华为"];
    
    NSArray *textArray = @[@"作为应届毕业生的我和老板mage 时屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期出差两天，学到了这些大屏幕一切按照 320 宽度渲染，屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"然后等比例拉伸到大屏。这种情况下对界面不会产生任芊语芊度返回 320这种模式下对界面不会产寻把小屏完全拉伸。",
                           @"当你的 app 没有提供 3x 的 LaunchImage 时屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 32拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。",
                           @"但是建议不要长期处于这种模式mage 时屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
                           @"屏幕宽度返回 32比例拉伸到mage 时屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。"
                           ];
    
    
    NSArray *picImageNamesArray = @[ @"HPME_Exchange",
                                     @"2",
                                     @"1",
                                     @"HPME_Exchange"
                                     ];
    NSMutableArray *resArr = [NSMutableArray new];
    
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(5);
        int nameRandomIndex = arc4random_uniform(5);
        int contentRandomIndex = arc4random_uniform(5);
        int timeRandomIndex = arc4random_uniform(8);
        int phoneRandomIndex = arc4random_uniform(5);
        
        GRDynamicStateModel *model = [GRDynamicStateModel new];
        model.iconName = iconImageNamesArray[iconRandomIndex];
        model.name = namesArray[nameRandomIndex];
        model.msgContent = textArray[contentRandomIndex];
        model.time = time[timeRandomIndex];
        model.phone = phone[phoneRandomIndex];
        
        // 模拟“随机图片”
        int random = arc4random_uniform(4);
        
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < random; i++) {
            int randomIndex = arc4random_uniform(4);
            [temp addObject:picImageNamesArray[randomIndex]];
        }
        if (temp.count) {
            model.picNamesArray = [temp copy];
        }
        
        [resArr addObject:model];
    }
    return [resArr copy];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GRDynamicStateCell *cell = [GRDynamicStateCell cellWithTableView:tableView];
    cell.cellFrame = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    GRDynamicStateCellFrame *frame = self.dataArray[indexPath.row];
    return frame.rowHeight;
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
