//
//  GRRingViewController.m
//  GoldRush
//
//  Created by Jack on 2017/1/13.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRDealRingViewController.h"
#import "GRDealRingHeader.h"                ///用户信息头像
#import "GRDealRingHeaderModel.h"           ///用户模型数据
#import "GRHeaderBtnView.h"                 ///按钮 view
#import "GRTheNewestViewController.h"       ///最新
#import "GRHotTopicViewController.h"        ///热门
#import "GRAttentionViewController.h"       ///关注
#import "GRMineDealRingViewController.h"    ///我的朋友圈
#import "GRDealRingReleaseViewController.h" ///发布控制器

#define TitleHeight 40

@interface GRDealRingViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *contentScrollView;    ///contentScrollView
@property (nonatomic, weak) GRHeaderBtnView *btnView;           ///btnView

@end

@implementation GRDealRingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置 scrollview
    [self setupScrollView];
    
    //创建头部用户信息
    [self createHeader];
    
    //创建发布按钮
    [self createReleaseBtn];
    
    
    [self addChildVcViewIntoScrollView:0];
    
}

//创建发布按钮
- (void)createReleaseBtn{
    UIButton *release = [UIButton buttonWithType:UIButtonTypeCustom];
    [release setTitle:@"发布" forState:UIControlStateNormal];
    release.frame = CGRectMake(K_Screen_Width - 70, K_Screen_Height - 100, 50, 50);
    release.layer.cornerRadius = 25;
    release.layer.masksToBounds = YES;
    release.backgroundColor = mainColor;
    [self.view addSubview:release];
    [self.view bringSubviewToFront:release];
    [release addTarget:self action:@selector(releaseClick:) forControlEvents:UIControlEventTouchUpInside];
}

//创建头部用户信息
- (void)createHeader{
    GRDealRingHeader *deal = [[GRDealRingHeader alloc] initWithFrame:CGRectMake(0, 64, K_Screen_Width, 115)];
    deal.model = [GRDealRingHeaderModel mj_objectWithKeyValues:@{@"backgroundUrl":@"Carousel",@"iconUrl":@"Header_Icon_Default",@"phone":@"1503****217"}];
    WS(weakSelf)
    deal.tapBlock = ^{
        GRMineDealRingViewController *mineDealRingVC = [[GRMineDealRingViewController alloc] init];
        mineDealRingVC.title = @"我的朋友圈";
        [weakSelf.navigationController pushViewController:mineDealRingVC animated:YES];
    };
    [self.view addSubview:deal];
    
    GRHeaderBtnView *btnView = [[GRHeaderBtnView alloc] initWithFrame:CGRectMake(0, 115 + 64, K_Screen_Width, 40)];
    btnView.titleArray = @[@"最新",@"热门",@"关注"];
    btnView.btnClick = ^(UIButton *btn){
        if ([btn.titleLabel.text isEqualToString:@"最新"]) {
            self.contentScrollView.contentOffset = CGPointMake(0, self.contentScrollView.contentOffset.y);
            [self addChildVcViewIntoScrollView:0];
        }else if ([btn.titleLabel.text isEqualToString:@"热门"]){
            self.contentScrollView.contentOffset = CGPointMake(self.contentScrollView.width, self.contentScrollView.contentOffset.y);
            [self addChildVcViewIntoScrollView:1];
        }else if ([btn.titleLabel.text isEqualToString:@"关注"]){
            self.contentScrollView.contentOffset = CGPointMake(self.contentScrollView.width * 2, self.contentScrollView.contentOffset.y);
            [self addChildVcViewIntoScrollView:2];
        }
    };
    [self.view addSubview:btnView];
    self.btnView = btnView;
}

//创建子控制器
- (void)createChildVC{
    [self addChildViewController:[[GRTheNewestViewController alloc] init]];
    [self addChildViewController:[[GRHotTopicViewController alloc] init]];
    [self addChildViewController:[[GRAttentionViewController alloc] init]];
}

//设置 scrollview
- (void)setupScrollView{
    //不允许自动修改 scrollview 的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 115 + 64 + 40, K_Screen_Width, K_Screen_Height - 115 - 64)];
    scrollView.backgroundColor = [UIColor greenColor];
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    // 点击状态栏的时候，这个scrollView不会滚动到最顶部
    scrollView.scrollsToTop = NO;
    [self.view addSubview:scrollView];
    self.contentScrollView = scrollView;
    
    //初始化子控制器
    [self createChildVC];
    // 添加子控制器的view
    NSUInteger count = self.childViewControllers.count;
    CGFloat scrollViewW = scrollView.width;
    
    scrollView.contentSize = CGSizeMake(count * scrollViewW, 0);
}

/**
 *  添加第index个子控制器的view到scrollView中
 */
- (void)addChildVcViewIntoScrollView:(NSUInteger)index{
    UIViewController *childVc = self.childViewControllers[index];
    
    // 如果view已经被加载过，就直接返回
    if (childVc.isViewLoaded) return;
    
    // 取出index位置对应的子控制器view
    UIView *childVcView = childVc.view;
    
    // 设置子控制器view的frame
    CGFloat scrollViewW = self.contentScrollView.width;
    childVcView.frame = CGRectMake(index * scrollViewW, 0, scrollViewW, self.contentScrollView.height - TitleHeight);
    // 添加子控制器的view到scrollView中
    [self.contentScrollView addSubview:childVcView];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    // 求出标题按钮的索引
    NSUInteger index = offsetX / scrollView.width;
    
    // 点击对应的标题按钮
    [UIView animateWithDuration:0.1 animations:^{
        //滚动 scrollview 的移动
        CGFloat offsetX = self.contentScrollView.width * index;
        self.contentScrollView.contentOffset = CGPointMake(offsetX, self.contentScrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        //添加子控制器的 view
        [self addChildVcViewIntoScrollView:index];
    }];
    
    self.btnView.index = index;
}

#pragma mark - event response
- (void)releaseClick:(UIButton *)btn{
    GRDealRingReleaseViewController *releaseVC = [[GRDealRingReleaseViewController alloc] init];
    releaseVC.title = @"状态";
    [self.navigationController pushViewController:releaseVC animated:YES];
}

#pragma mark - setter and getter


@end
