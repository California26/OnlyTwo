//
//  GRChippedViewController.m
//  GoldRush
//
//  Created by Jack on 2016/12/18.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRChippedViewController.h"
#import "GRCarouselViewController.h"

/** 轮播 */
#import "GRChippedCarouselView.h"
/** 按钮 view */
#import "GRChippedAnalystBtnView.h"

/** 分析师控制器 */
#import "GRAnalystViewController.h"
/** 全民跟单 */
#import "GRDocumentaryViewController.h"

@interface GRChippedViewController ()

@property (nonatomic, weak) GRChippedAnalystBtnView *btnView;   ///顶部按钮 view

@end


@implementation GRChippedViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    
    //设置 UI
    [self setupUI];
    
    [super viewDidLoad];
    
    GRAnalystViewController *analystVC = [[GRAnalystViewController alloc] init];
    GRDocumentaryViewController *documentaryVC = [[GRDocumentaryViewController alloc] init];
    self.childVcs = @[analystVC,documentaryVC];
}

- (void)setupUI{
    self.navigationItem.title = @"合买";
    
    self.scrollNavH = 64;

    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 233)];
    header.backgroundColor = GRColor(240, 240, 240);
    
    //创建轮播图
    GRChippedCarouselView *carousel = [[GRChippedCarouselView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 127)];
    carousel.messageArray = [NSMutableArray arrayWithArray:@[@"a用户全民小刀刚刚加入了郑成功计划!",@"b用户全民小刀刚刚加入了郑成功计划!",@"c用户全民小刀刚刚加入了郑成功计划!",@"d用户全民小刀刚刚加入了郑成功计划!",@"e用户全民小刀刚刚加入了郑成功计划!"]];
    WS(weakSelf);
    carousel.carouselClick = ^(NSInteger index){
        GRCarouselViewController *carouselVC = [[GRCarouselViewController alloc] init];
        [weakSelf.navigationController pushViewController:carouselVC animated:YES];
    };
    [header addSubview:carousel];
    
    //创建按钮(分析师/全民跟单)
    GRChippedAnalystBtnView *btnView = [[GRChippedAnalystBtnView alloc] initWithFrame:CGRectMake(0, 142, K_Screen_Width, 28)];
    btnView.analstBlock = ^(UIButton *btn){
        [self addChildViewAtIndex:0];
    };
    btnView.documentaryBlock = ^(UIButton *btn){
        [self addChildViewAtIndex:1];
    };
    self.btnView = btnView;
    [header addSubview:btnView];
    
    self.headerView = header;
}

- (void)afterPagingIndex:(NSInteger)index{
    if (index == 0) {
        self.btnView.isSecond = NO;
    }else{
        self.btnView.isSecond = YES;
    }
}

@end
