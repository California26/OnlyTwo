//
//  GRPathRangle.m
//  GoldRush
//
//  Created by 徐孟林 on 2016/12/23.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRPathRangle.h"
const CGFloat k_X_Scale = 2;
const CGFloat k_Y_scale = 50;

typedef NS_OPTIONS(NSUInteger, diretion) {
    DiretionUp = 1,
    DiretionLeft = 2,
    DiretionRight = 3,
};

@implementation GRPathRangle


- (void)creatBigRangleWithContext:(CGContextRef)context withFrame:(CGRect)rect
{
    [[UIColor whiteColor] setFill];
    [GRColor(218, 218, 218) setStroke];
//    CGFloat arr[] = {5,5};
//    CGContextSetLineDash(context, 0, arr, 0);//防止被虚化
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 0.5);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, rect);
    CGContextAddPath(context, path);
    CGPathRelease(path);
    CGContextStrokePath(context);
}
- (void)creatDashLineWith:(NSArray *)aryPoint withFrame:(CGRect)rect withContext:(CGContextRef)context
{
    CGPoint point1 = [aryPoint.firstObject CGPointValue];
    CGPoint point2 = [aryPoint.lastObject CGPointValue];
    
    //设置虚线颜色
//    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"e6e6e6"].CGColor);
    [[UIColor colorWithHexString:@"e6e6e6"] setStroke];
    //设置虚线宽度
    CGContextSetLineWidth(context, 1);
    //设置虚线绘制起点
    CGContextMoveToPoint(context, point1.x, point1.y);
    //设置虚线绘制终点
    CGContextAddLineToPoint(context, point2.x, point2.y);
//    下面的arr中的数字表示先绘制3个点再绘制1个点
//    CGFloat arr[] = {5,5};
//    //下面最后一个参数“1”代表排列的个数。
//    CGContextSetLineDash(context, 0, arr, 1);
//    CGContextStrokePath(context);
    CGContextDrawPath(context, kCGPathStroke);
    //Draws the current path using the provided drawing mode.
//    The current path is cleared as a side effect of calling this function.
    //绘制当前路径使用提供的绘图模式。清除当前路径作为一个调用这个函数的副作用。

    
}

- (void)creatAvgLineWithContext:(CGContextRef)context withAry:(NSArray *)ary withFrame:(CGRect)rect
{
    if (ary.count == 0 || !ary) {
        return;
    }

    [GRColor(253, 189, 65) setStroke];
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat yOffset = rect.size.height/2;
    CGAffineTransform transorm = CGAffineTransformMake(k_X_Scale, 0, 0, k_Y_scale, 0, yOffset);
    CGFloat y = [ary.firstObject floatValue];
    CGFloat x = rect.origin.x;
    CGPathMoveToPoint(path, &transorm, x, y);
    for (int i = 1; i < ary.count; i++) {
        x = x + k_X_Scale;
        CGPathAddLineToPoint(path, &transorm, x, y);
        y = [ary[i] floatValue];
        CGPathAddLineToPoint(path, &transorm, x, y);
    }
    CGContextAddPath(context, path);
    CGPathRelease(path);
    CGContextStrokePath(context);
}

- (void)creatBrokenLineWith:(CGContextRef)context withFrame:(CGRect)rect withArray:(NSArray *)ary
{
    if (ary.count == 0 || !ary) {
        return;
    }
    [[UIColor blackColor] setStroke];
    CGMutablePathRef path = CGPathCreateMutable();
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGPoint point = [ary.firstObject CGPointValue];
    CGContextMoveToPoint(context, point.x, point.y);
    for (int i = 1; i < ary.count; i++) {
        CGPoint point1 = [ary[i] CGPointValue];
        CGContextAddLineToPoint(context, point1.x, point1.y);
    }
    CGContextAddPath(context, path);
    CGPathRelease(path);
    CGContextStrokePath(context);
    [self creatShadowWith:context withFrame:rect withArray:ary];
}

- (void)creatShadowWith:(CGContextRef)context withFrame:(CGRect)rect withArray:(NSArray *)ary
{
//    先用CGContextStrokePath来描线,即形状
//    后用CGContextFillPath来填充形状内的颜色.
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGPoint point = [ary.firstObject CGPointValue];
    CGContextMoveToPoint(context, point.x, point.y);
    for (int i = 1; i < ary.count; i++) {
        CGPoint point1 = [ary[i] CGPointValue];
        CGContextAddLineToPoint(context, point1.x, point1.y);
    }
    CGPoint lastPoint = [ary.lastObject CGPointValue];
    CGContextAddLineToPoint(context,lastPoint.x , rect.size.height);
    CGContextAddLineToPoint(context, rect.origin.x, rect.size.height);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:239.0/255.0 green:241.0/255.0 blue:251.0/255.0 alpha:0.4].CGColor);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextStrokePath(context);
}

- (void)creatCandleWith:(CGContextRef)context withpoint1:(CGPoint)point1 withPoint2:(CGPoint)point2 withColor:(UIColor *)colorStroke withHeight:(CGFloat)height1 withHeight2:(CGFloat)height2 withScale:(CGFloat)scale
{
    //第一条线
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);
    [colorStroke setStroke];
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, point1.x, point1.y);
    CGContextAddLineToPoint(context, point1.x, point1.y+height1);
    CGContextStrokePath(context);
    
    //第二条矩形
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextDrawPath(context, kCGPathFill);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(point2.x, point2.y, scale, height2));
    CGContextAddPath(context, path);
    CGContextSetFillColorWithColor(context, colorStroke.CGColor);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGPathRelease(path);
    CGContextStrokePath(context);
}


@end
