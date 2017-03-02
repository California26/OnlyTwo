//
//  GRTakePartInChippedViewController.m
//  GoldRush
//
//  Created by Jack on 2017/1/7.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRTakePartInChippedViewController.h"

#import "GRParticipateChippedHeader.h"          ///参加合买的头部按钮
#import "GRChippedChildViewController.h"        ///参与合买子控制器
#import "GRReleaseViewController.h"             ///发布控制器

/** 标题栏的高度 */
CGFloat const TitlesH = 50;
/** 导航栏的高度 */
CGFloat const NavH = 64;

@interface GRTakePartInChippedViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *contentScrollView;
@property (nonatomic, weak) GRParticipateChippedHeader *titleHeader;


@end

@implementation GRTakePartInChippedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加头部按钮
    GRParticipateChippedHeader *header = [[GRParticipateChippedHeader alloc] initWithFrame:CGRectMake(13, NavH, K_Screen_Width - 26, TitlesH)];
    self.titleHeader = header;
    [self.view addSubview:header];
    self.view.backgroundColor = GRColor(240, 240, 240);
    
    //设置 scrollview
    [self setupScrollview];
    
    header.btnBlock = ^(UIButton *btn){
        WS(weakSelf)
        if ([btn.titleLabel.text isEqualToString:@"合买"]) {
            [UIView animateWithDuration:0.5 animations:^{
                //滚动 scrollview 的移动
                weakSelf.contentScrollView.contentOffset = CGPointMake(0, 0);
            } completion:^(BOOL finished) {
                //添加子控制器的 view
                [weakSelf addChildVcViewIntoScrollView:0];
            }];
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                //滚动 scrollview 的移动
                weakSelf.contentScrollView.contentOffset = CGPointMake(K_Screen_Width, 0);
            } completion:^(BOOL finished) {
                //添加子控制器的 view
                [weakSelf addChildVcViewIntoScrollView:1];
            }];
        }
    };
    
    [self addChildViewController:[[GRChippedChildViewController alloc] init]];
    [self addChildViewController:[[GRReleaseViewController alloc] init]];
    
    //添加子控制器的 view
    [self addChildVcViewIntoScrollView:0];
}

- (void)setupScrollview{
    //不允许自动修改 scrollview 的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NavH + TitlesH, K_Screen_Width, K_Screen_Height - NavH - TitlesH)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    // 点击状态栏的时候，这个scrollView不会滚动到最顶部
    scrollView.scrollsToTop = NO;
    [self.view insertSubview:scrollView belowSubview:self.titleHeader];
    self.contentScrollView = scrollView;
    
    // 添加子控制器的view
    NSUInteger count = self.childViewControllers.count;
    CGFloat scrollViewW = scrollView.width;
    
    scrollView.contentSize = CGSizeMake(count * scrollViewW, 0);
}

/**
 *  添加第index个子控制器的view到scrollView中
 */
- (void)addChildVcViewIntoScrollView:(NSUInteger)index
{
    UIViewController *childVc = self.childViewControllers[index];
    // 如果view已经被加载过，就直接返回
    if (childVc.isViewLoaded) return;
    
    // 取出index位置对应的子控制器view
    UIView *childVcView = childVc.view;
    
    // 设置子控制器view的frame
    CGFloat scrollViewW = self.contentScrollView.frame.size.width;
    childVcView.frame = CGRectMake(index * scrollViewW, 0, scrollViewW, self.contentScrollView.height);
    // 添加子控制器的view到scrollView中
    [self.contentScrollView addSubview:childVcView];
}

#pragma mark - UIScrollViewDelegate





@end
