//
//  GRScrollViewController.m
//  GoldRush
//
//  Created by Jack on 2017/1/7.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRScrollViewController.h"
//#import "GRContentViewController.h"     // contentView 上添加的子控制器的父类, 测试, 可以直接使用 UIViewController

@interface GRScrollViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) UIScrollView *contentView;

/// 当 scrollHeaderH == headerH 时, scrollView 不能上下滚动
@property (assign, nonatomic, getter=isScrollDisable) BOOL scrollDisable;
/// 顶部视图的高度, 高度设置优先级 headerView > navigationView
@property (assign, nonatomic) CGFloat headerH;
/// 当前显示的第几个子控制器
@property (assign, nonatomic) NSInteger index;

/// 字典缓存添加控制器的 view
@property (strong, nonatomic) NSMutableDictionary<NSString *, __kindof UIView *> *views;
@end

@implementation GRScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.views = [NSMutableDictionary dictionary];
    
    [self updateConfig];
    [self setupScrollView];
    self.scrollView.contentOffset = CGPointMake(0, 0);
}

- (void)setupScrollView {
    CGFloat scrollH = (self.navigationController.childViewControllers.count > 1 ? K_Screen_Height : K_Screen_Height - 49) - self.contentY;
    CGRect frame = CGRectMake(0, self.contentY, CGRectGetWidth(self.view.frame), scrollH);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    CGFloat contentH = scrollH + self.headerH;
    scrollView.contentSize = CGSizeMake(0, contentH);
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    scrollView.backgroundColor = GRColor(240, 240, 240);
    
    if (self.headerView) {
        CGFloat width = CGRectGetWidth(self.headerView.frame);
        CGFloat height = CGRectGetHeight(self.headerView.frame);
        CGFloat x = (K_Screen_Width - width) * 0.5;
        self.headerView.frame = CGRectMake(x, 64, width, height);    // 重设 frame
        [self.scrollView addSubview:self.headerView];
    }
    
    if (self.navigationView) {
        CGFloat width = CGRectGetWidth(self.navigationView.frame);
        CGFloat height = CGRectGetHeight(self.navigationView.frame);
        CGFloat x = (K_Screen_Width - width) * 0.5;
        self.navigationView.frame = CGRectMake(x, 0, width, height);    // 重设 frame
        [self.view addSubview:self.navigationView];
        if (self.isScrollDisable) {
            self.navigationView.alpha = 1.0;
        } else {
            self.navigationView.alpha = 0.0;    // 导航初始隐藏
        }
    }
    
    UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.headerH, K_Screen_Width, scrollH - self.scrollNavH)];
    contentView.pagingEnabled = YES;
    contentView.delegate = self;
    contentView.showsHorizontalScrollIndicator = NO;
    [self.scrollView addSubview:contentView];
    self.contentView = contentView;
}

/// 更新初值, self.headerH, self.scrollNavH, self.scrollDisable, _scrollDistance
- (void)updateConfig {
    if (self.headerView && self.navigationView) {   // headerView , navigationView 都存在
        self.headerH = CGRectGetHeight(self.headerView.frame);
        if (self.scrollNavH >= self.headerH) {  // 导航高度 > headerH, 不能滚动
            self.scrollNavH = self.headerH;
            self.scrollDisable = YES;
            _scrollDistance = 0;
        } else {    // 导航高度 < headerH, 可以滚动
            CGFloat navH = CGRectGetHeight(self.navigationView.frame);
            if (self.scrollNavH <= navH) {     // 导航高度没有设置或者比导航视图高度小
                self.scrollNavH = navH;
            }
            if (self.scrollNavH > self.headerH) {
                _scrollDistance = 0;
                self.scrollDisable = YES;
            } else {
                _scrollDistance = self.headerH - self.scrollNavH;
            }
        }
    } else if (self.headerView && !self.navigationView) {   // headerView 存在, navigationView 不存在
        self.headerH = CGRectGetHeight(self.headerView.frame);
        if (self.scrollNavH >= 0) {     // 导航高度设置
            if (self.scrollNavH > self.headerH) {
                _scrollDistance = 0;
                self.scrollDisable = YES;
            } else {
                _scrollDistance = self.headerH - self.scrollNavH;
            }
        } else {
            _scrollDistance = self.headerH;
        }
    } else if (!self.headerView && self.navigationView) {   // headerView 不存在, navigationView 存在
        self.headerH = CGRectGetHeight(self.navigationView.frame);
        if (self.scrollNavH >= self.headerH) {
            self.scrollNavH = self.headerH;
            self.scrollDisable = YES;
            _scrollDistance = 0;
        } else {
            _scrollDistance = self.headerH - self.scrollNavH;
        }
    } else if (!self.headerView && !self.navigationView) {  // headerView , navigationView 都不存在
        self.headerH = 0;
        self.scrollNavH = 0;
        self.scrollDisable = YES;
        _scrollDistance = 0;
    }
}

/// contentView 上添加子控制器的 view
- (void)addChildViewAtIndex:(NSInteger)index {
    if (index >= self.childVcs.count)   return;
    NSString *key = [NSString stringWithFormat:@"%zd", index];
    self.index = index;
    
    CGFloat width = CGRectGetWidth(self.contentView.frame);
    self.contentView.contentOffset = CGPointMake(index * width, 0);
    if (self.views[key])    return;
    
    UIViewController *vc = self.childVcs[index];
    CGFloat viewW = CGRectGetWidth(self.contentView.frame);
    CGFloat viewH = CGRectGetHeight(self.contentView.frame);
    vc.view.frame = CGRectMake(viewW * index, 0, viewW, viewH);
    [self addChildViewController:vc];
    [self.contentView addSubview:vc.view];
    self.views[key] = vc.view;
}

- (void)setChildVcs:(NSArray<__kindof UIViewController *> *)childVcs {
    if (!childVcs || childVcs.count == 0)   return;
    _childVcs = childVcs;
    
    // 设置内容的滚动范围
    CGFloat contentW = CGRectGetWidth(self.contentView.frame);
    self.contentView.contentSize = CGSizeMake(contentW * childVcs.count, 0);
    
    // 添加第一个控制器的 view
    [self addChildViewAtIndex:0];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scroll_offset_y = scrollView.contentOffset.y;
    // 拖拽 contentView 滑动到下一页, 避免每次滑动, scrollView都会回到原始位置
    if (scrollView == self.contentView) return;
    // 设置 self.scrollView 不能下拉滚动
    if (scroll_offset_y <= 0) {     // 修复导航视图的显示和隐藏
        self.navigationView.alpha = 0.0;
        self.scrollView.contentOffset = CGPointZero;
    } else {    // 修复自身滚动范围出错
        if (scroll_offset_y >= self.scrollDistance) {   // 不能再向上滚动了
            self.scrollView.contentOffset = CGPointMake(0, self.scrollDistance);
            self.navigationView.alpha = 1.0;
        } else {
            self.navigationView.alpha = 0.0;
        }
    }
}

// 滑动翻页
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (scrollView == self.scrollView)  return;
    CGFloat width = CGRectGetWidth(self.contentView.frame);
    NSInteger index = (*targetContentOffset).x / width;
    if (index != self.index) {
        self.index = index;
        [self addChildViewAtIndex:index];
        [self afterPagingIndex:index];
    }
}

#pragma mark - method
// 子控制器调用, 使 scrollView 产生偏移
- (void)scrollWithOffset:(CGFloat)offset_y {
    if (self.isScrollDisable)   return;
    // scrollView 可以滚动的距离为 self.scrollDistance
    CGFloat scroll_offsetY = self.scrollView.contentOffset.y;
    if (self.navigationView) {
        self.navigationView.alpha = (offset_y)/self.scrollDistance;
    }
    
    if (offset_y <= 0) {    // 子控制器的视图下拉
        if (scroll_offsetY == 0)    return;    // 子控制器 下拉刷新
        //        self.scrollView.contentOffset = CGPointMake(0, scroll_offsetY + offset_y);
        if (scroll_offsetY < 0) {
            self.scrollView.contentOffset = CGPointMake(0, scroll_offsetY - offset_y);
        } else {
            self.scrollView.contentOffset = CGPointMake(0, scroll_offsetY + offset_y);
        }
    } else {    // 子控制器的视图上推
        if (offset_y >= self.scrollDistance) {
            // scrollView 向下偏移距离超过 headerView的高度, 动画恢复
            [UIView animateWithDuration:0.25f animations:^{
                self.scrollView.contentOffset = CGPointMake(0, self.scrollDistance);
            }];
        } else {
            self.scrollView.contentOffset = CGPointMake(0, offset_y);
        }
    }
}

#pragma mark - getter
- (BOOL)canScrollUp {
    if (self.isScrollDisable) return NO;
    return self.scrollView.contentOffset.y < self.scrollDistance;
}

#pragma mark -
- (void)afterPagingIndex:(NSInteger)index {}
@end
