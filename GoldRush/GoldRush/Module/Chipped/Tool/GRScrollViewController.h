//
//  GRScrollViewController.h
//  GoldRush
//
//  Created by Jack on 2017/1/7.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class GRContentViewController;
NS_ASSUME_NONNULL_BEGIN
/// 系统的导航条隐藏
@interface GRScrollViewController : UIViewController
/// 顶部视图, 默认 nil, set this property before call [super viewDidLoad]
@property (strong, nonatomic, nullable) __kindof UIView *headerView;

/**
 *  导航视图, 默认为 nil, 如果有值, scrollView 滑动到最高点时显示, 否则显示 headerView 的一部分
 *  高度一般为 64
 *  set this property before call [super viewDidLoad]
 */
@property (strong, nonatomic, nullable) __kindof UIView *navigationView;

/**
 *  导航显示的高度, headerView 优先级高于 navigationView
 *  导航视图的几种显示情况: 具体见 -updateConfig 方法:
 *  1. headerView和navigationView都存在:
 *      1)如果scrollNavH > headerView.height, 不能滚动;
 *      2)如果navigationView.height > headerView.height, 不能滚动
 *  2. headerView 存在, navigationView 不存在:
 *      1)self.scrollNavH > headerView.height, 不能滚动
 *  3. headerView 不存在, navigationView 存在:
 *      1)self.scrollNavH >= navigationView.height, 不能滚动
 *  4. navigationView|headerView 都不存在时, 该属性被忽略, 导航不显示
 *  所有可滚动范围计算: _scrollDistance = headerView.height - self.scrollNavH
 */
@property (assign, nonatomic) CGFloat scrollNavH;

/// 所有内容显示的位置, 一般情况下不设置.
@property (assign, nonatomic) CGFloat contentY;

/// 当前 scrollView 滚动的范围决定是否还可以向上滚动
@property (assign, nonatomic) BOOL canScrollUp;

/// 内容视图可以向上滚动的高度
@property (assign, nonatomic, readonly) CGFloat scrollDistance;

/// 子控制器数组
@property (strong, nonatomic) NSArray<__kindof UIViewController *> *childVcs;

/// 子控制器滚动时调用 enable 表示 GRScrollViewController 不能再进行滚动了
- (void)scrollWithOffset:(CGFloat)offset_y;

#pragma mark - method
/// contentView 上添加子控制器的 view, 父类实现
- (void)addChildViewAtIndex:(NSInteger)index;

/// contentView 滚动翻页后子类需要进行的其他操作
- (void)afterPagingIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END

