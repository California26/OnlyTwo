//
//  GRDocumentaryViewController.m
//  GoldRush
//
//  Created by Jack on 2017/1/5.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRDocumentaryViewController.h"
#import "GRTakePartInChippedCell.h"                 //参加合买 cell
#import "GRUserInfomationCell.h"                    //用户信息 cell
#import "GRTakePartInChippedViewController.h"       //参加合买控制器
#import "GRDocumentaryIntroduceViewController.h"    //跟单介绍控制器

#import "GRScrollViewController.h"

@interface GRDocumentaryViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (assign, nonatomic) CGFloat scrollOffsetY;        ///Y 轴偏移量

@property(nonatomic, strong) NSMutableArray *sectionArray;  ///数据源数组

@property(nonatomic, weak) UITableView *tableView;
@end

@implementation GRDocumentaryViewController

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
    return 15;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        GRTakePartInChippedCell *cell = [GRTakePartInChippedCell cellWithTableView:tableView];
        WS(weakSelf)
        cell.participateBlock = ^{
            GRTakePartInChippedViewController *participateVC = [[GRTakePartInChippedViewController alloc] init];
            participateVC.title = @"参与合买";
            [weakSelf.navigationController pushViewController:participateVC animated:YES];
        };
        return cell;
    }else{
        GRUserInfomationCell *cell = [GRUserInfomationCell cellWithTableView:tableView];
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 50;
    }else{
        return 84;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GRDocumentaryIntroduceViewController *introduceVC = [[GRDocumentaryIntroduceViewController alloc] init];
    introduceVC.title = @"介绍";
    [self.navigationController pushViewController:introduceVC animated:YES];
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

#pragma mark - setter and getter

- (NSMutableArray *)sectionArray{
    if (!_sectionArray) {
        _sectionArray = [NSMutableArray array];
    }
    return _sectionArray;
}


@end
