//
//  GRChartCandleScrollView.m
//  GoldRush
//
//  Created by 徐孟林 on 2016/12/27.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRChartCandleScrollView.h"

@implementation GRChartCandleScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
//        self.alwaysBounceHorizontal = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    for (int i = 0; i<_pointLineAry.count; i++) {
        CGPoint pointline = [_pointLineAry[i] CGPointValue];
        CGPoint pointRangle = [_pointRangleAry[i] CGPointValue];
        _heightLine = [_heightLineAry[i] intValue];
        _heightRangle = [_heightRangleAry[i] intValue];
        _isRiseOrDrop = [_aryBool[i] boolValue];
        [self creatCandlewithpoint1:pointline withPoint2:pointRangle withRiseOrDrop:_isRiseOrDrop withHeight:_heightLine withHeight2:_heightRangle withScale:_scale];
    }
    
}


- (void)creatCandlewithpoint1:(CGPoint)point1 withPoint2:(CGPoint)point2 withRiseOrDrop:(BOOL)colorStroke withHeight:(double)height1 withHeight2:(double)height2 withScale:(double)scale
{
    //第一条线
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 0.5);
    if (colorStroke) {
        [[UIColor colorWithHexString:@"#f45484"] setStroke];
    }else{
        [[UIColor colorWithHexString:@"#84dd45"] setStroke];
    }
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
    if (colorStroke) {
        CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"#f45484"].CGColor);
    }else{
        CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"#84dd45"].CGColor);
    }
    CGContextDrawPath(context, kCGPathFillStroke);
    CGPathRelease(path);
    CGContextStrokePath(context);
}


@end
