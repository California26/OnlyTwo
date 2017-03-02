//
//  GRPathRangle.h
//  GoldRush
//
//  Created by 徐孟林 on 2016/12/23.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRPathRangle : NSObject

- (void)creatBigRangleWithContext:(CGContextRef)context withFrame:(CGRect)rect;
- (void)creatDashLineWith:(NSArray *)aryPoint withFrame:(CGRect)rect withContext:(CGContextRef)context;
- (void)creatAvgLineWithContext:(CGContextRef)context withAry:(NSArray *)ary withFrame:(CGRect)rect;
- (void)creatBrokenLineWith:(CGContextRef)context withFrame:(CGRect)rect withArray:(NSArray *)ary;
- (void)creatCandleWith:(CGContextRef)context withpoint1:(CGPoint)point1 withPoint2:(CGPoint)point2 withColor:(UIColor *)colorStroke withHeight:(CGFloat)height1 withHeight2:(CGFloat)height2 withScale:(CGFloat)scale;


@end
