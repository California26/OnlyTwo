//
//  GRChartGlobalVariable.h
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/13.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLineConstant.h"

@interface GRChartGlobalVariable : NSObject

/**
 *  K线图的宽度，默认
 */
+(CGFloat)kLineWidth;

+(void)setkLineWith:(CGFloat)kLineWidth;

/**
 *  K线图的间隔，默认1
 */
+(CGFloat)kLineGap;

+(void)setkLineGap:(CGFloat)kLineGap;
/**
 *  分时图线图的间隔，默认(K_Screen_Width-30)/1200
 */
+(CGFloat)kLineGapMinute;

/**
 *  MainView的高度占比,默认为0.5
 */
+ (CGFloat)kLineMainViewRadio;
+ (void)setkLineMainViewRadio:(CGFloat)radio;

@end
