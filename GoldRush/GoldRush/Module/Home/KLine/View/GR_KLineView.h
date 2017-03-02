//
//  GR_KLineView.h
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/16.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRChart_KLineModel.h"
#import "KLineConstant.h"

@interface GR_KLineView : UIView

@property (nonatomic,assign) CGFloat mainViewHeight;

//数据
@property (nonatomic, copy) NSArray <GRChart_KLineModel *> *kLineModels;
//重绘
- (void)reDraw;

//K线类型
@property (nonatomic,assign) Y_StockChartCenterViewType MainViewType;

@property (nonatomic,strong) NSString *stringYesterDay;
/**
 *  Accessory指标种类
 */
//@property (nonatomic, assign) Y_StockChartTargetLineStatus targetLineStatus;

@end
