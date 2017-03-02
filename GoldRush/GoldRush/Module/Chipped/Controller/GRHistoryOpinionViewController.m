//
//  GRHistoryOpinionViewController.m
//  GoldRush
//
//  Created by Jack on 2017/1/7.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRHistoryOpinionViewController.h"
#import "GRTheNewestOpinionCell.h"
#import "GRTheNewestOpinion.h"
#import "GRTheNewestOpinionFrame.h"
#import "GRCommentOpinionViewController.h"

@interface GRHistoryOpinionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *mainTableView;

///数据源数组
@property(nonatomic, strong) NSMutableArray *sectionArray;

@end

@implementation GRHistoryOpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置 UI
    [self setupUI];
    //初始化 tableview
    [self initTableView];
    //模拟数据
    NSArray *array = [self creatModelsWithCount:10];
    for (GRTheNewestOpinion *model  in array) {
        GRTheNewestOpinionFrame *frameModel = [[GRTheNewestOpinionFrame alloc] init];
        frameModel.opinionModel = model;
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:frameModel];
        [self.sectionArray addObject:array];
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

- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
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
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray *array = self.sectionArray[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GRTheNewestOpinionCell *cell = [GRTheNewestOpinionCell cellWithTableView:tableView];
    NSMutableArray *array = self.sectionArray[indexPath.section];
    GRTheNewestOpinionFrame *frame = array[indexPath.row];
    cell.isShowArrow = NO;
    WS(weakSelf)
    cell.commentBlock = ^{
        GRCommentOpinionViewController *commentVC = [[GRCommentOpinionViewController alloc] init];
        commentVC.indexPath = indexPath;
        commentVC.title = @"分析师观点";
        [weakSelf.navigationController pushViewController:commentVC animated:YES];
    };
    cell.opinionFrame = frame;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *array = self.sectionArray[indexPath.section];
    GRTheNewestOpinionFrame *frame = array[indexPath.row];
    return frame.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

#pragma mark - setter and getter

- (NSMutableArray *)sectionArray{
    if (!_sectionArray) {
        _sectionArray = [NSMutableArray array];
    }
    return _sectionArray;
}

@end
