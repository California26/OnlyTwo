//
//  GRKLine_MainView.h
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRChart_KLinePositionModel.h"
#import "GRChart_KLineModel.h"
#import "KLineConstant.h"

@protocol GRKLine_MainDelegate <NSObject>

@optional
/**
 *  长按显示手指按着的Y_KLinePosition和KLineModel
 */
- (void)kLineMainViewLongPressKLinePositionModel:(GRChart_KLinePositionModel *)kLinePositionModel kLineModel:(GRChart_KLineModel *)kLineModel;

/**
 *  当前MainView的最大值和最小值
 */
- (void)kLineMainViewCurrentMaxPrice:(CGFloat)maxPrice minPrice:(CGFloat)minPrice;

@end
@interface GRKLine_MainView : UIView

/**
 模型数组
 */
@property (nonatomic,strong) NSArray *kLineModels;

/**
 父ScrollView
 */
@property (nonatomic,weak,readonly) UIScrollView *parentScrollView;

/**
 代理
 */
@property (nonatomic,weak) id<GRKLine_MainDelegate>  delegate;

/**
 *  是否为图表类型
 */
@property (nonatomic, assign) Y_StockChartCenterViewType MainViewType;

/**
 *  需要绘制Index开始值
 */
@property (nonatomic, assign) NSInteger needDrawStartIndex;

/**
 *  捏合点
 */
@property (nonatomic, assign) NSInteger pinchStartIndex;
#pragma event

/**
 *  画MainView的所有线
 */
- (void)drawMainView;

/**
 *  更新MainView的宽度
 */
- (void)updateMainViewWidth;

/**
 *  长按的时候根据原始的x位置获得精确的x的位置
 */
- (NSArray *)getExactXPositionWithOriginXPosition:(CGFloat)originXPosition;

/**
 *  移除所有的监听事件
 */
- (void)removeAllObserver;

@property (nonatomic,strong) NSString *stringYesterDay;


@end
