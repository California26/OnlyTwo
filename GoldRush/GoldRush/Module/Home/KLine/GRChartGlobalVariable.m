//
//  GRChartGlobalVariable.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/13.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRChartGlobalVariable.h"
#import <AVKit/AVKit.h>

/**
 *  K线图的宽度，默认4
 */
static CGFloat Y_StockChartKLineWidth = 1;

/**
 *  K线图的间隔，默认1
 */
static CGFloat Y_StockChartKLineGap = 1;


/**
 *  MainView的高度占比,默认为1.0
 */
static CGFloat Y_StockChartKLineMainViewRadio = 1.0;


@implementation GRChartGlobalVariable

/**
 *  K线图的宽度，默认4
 */
+(CGFloat)kLineWidth
{
//    return ;
    return Y_StockChartKLineWidth*((K_Screen_Width - 49)/50);
}
+(void)setkLineWith:(CGFloat)kLineWidth
{
    if (kLineWidth > Y_StockChartKLineMaxWidth) {
        kLineWidth = Y_StockChartKLineMaxWidth;
    }else if (kLineWidth < Y_StockChartKLineMinWidth){
        kLineWidth = Y_StockChartKLineMinWidth;
    }
    Y_StockChartKLineWidth = kLineWidth/((K_Screen_Width - 49)/50);
}


/**
 *  K线图的间隔，默认1
 */
+(CGFloat)kLineGap
{
    return Y_StockChartKLineGap;
}

+(void)setkLineGap:(CGFloat)kLineGap
{
    Y_StockChartKLineGap = kLineGap;
}

+(CGFloat)kLineGapMinute
{
    return K_Screen_Width/1200;
}

/**
 *  MainView的高度占比,默认为1.0
 */
+ (CGFloat)kLineMainViewRadio
{
    return Y_StockChartKLineMainViewRadio;
}
+ (void)setkLineMainViewRadio:(CGFloat)radio
{
    Y_StockChartKLineMainViewRadio = radio;
}

@end
