//
//  GR_KBrokenLine.h
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GRChart_KLineModel.h"

@interface GR_KBrokenLine : NSObject

@property (nonatomic, strong) NSArray *MAPositions;

/**
 *  k线的model
 */
@property (nonatomic, strong) GRChart_KLineModel *kLineModel;

/**
 *  最大的Y
 */
@property (nonatomic, assign) CGFloat maxY;


///最大的Y值
@property (nonatomic,assign) CGFloat maxAssetY;
///最小的Y值
@property (nonatomic,assign) CGFloat minAssetY;

/**
 *  根据context初始化折线画笔
 */
- (instancetype)initWithContext:(CGContextRef)context;

- (void)drawWithRect:(CGRect)rect;



@end
