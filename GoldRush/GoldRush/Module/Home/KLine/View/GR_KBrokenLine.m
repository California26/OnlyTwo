//
//  GR_KBrokenLine.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GR_KBrokenLine.h"
#import "UIColor+GRChart.h"
#import "KLineConstant.h"

@interface GR_KBrokenLine ()

@property (nonatomic,assign) CGContextRef context;

/**
 最后一个绘制日期点
 */
@property (nonatomic,assign) CGPoint lastDrawDatePoint;

@end


@implementation GR_KBrokenLine


/**
根据context初始化画线
 */
- (instancetype)initWithContext:(CGContextRef)context
{
    self = [super init];
    if (self) {
        self.context = context;
    }
    return self;
}

- (void)drawWithRect:(CGRect)rect{
    if (!self.context) {
        return;
    }
    //Y_StockChartKLineMainViewMaxY
    UIColor *lineColor = GRColor(48, 137, 234);
//    UIColor *lineColorBack = GRColor(34, 49, 73);
    UIColor *lineColorBack = [UIColor colorWithRed:34/255.0 green:49/255.0 blue:73/255.0 alpha:0.4];
//    UIColor *lineColorBack = [UIColor colorWithWhite:0.8 alpha:0.4];
    
    CGContextSetStrokeColorWithColor(self.context, lineColor.CGColor);
    
    CGContextSetLineWidth(self.context, Y_StockChartMALineWidth);
    
    CGPoint firstPoint = [self.MAPositions.firstObject CGPointValue];
    
    CGContextMoveToPoint(self.context, 0, firstPoint.y);
    GRLog(@"self.MAPositions.count == %lu",(unsigned long)self.MAPositions.count);
    for (NSInteger idx = 0; idx < self.MAPositions.count; idx++) {
        CGPoint point = [self.MAPositions[idx] CGPointValue];
        CGContextAddLineToPoint(self.context, point.x, point.y);
    }
    CGContextStrokePath(self.context);
    CGContextSetStrokeColorWithColor(self.context,[UIColor clearColor].CGColor);
    
    CGContextMoveToPoint(self.context,0, firstPoint.y);
    
    for (NSInteger idx = 0; idx < self.MAPositions.count; idx++) {
        CGPoint point = [self.MAPositions[idx] CGPointValue];
        CGContextAddLineToPoint(self.context, point.x, point.y);
    }
    CGPoint lastPoint = [self.MAPositions.lastObject CGPointValue];
    CGContextAddLineToPoint(self.context, lastPoint.x, rect.size.height-15);
    CGContextAddLineToPoint(self.context, 0, rect.size.height-15);
    CGContextSetFillColorWithColor(self.context, lineColorBack.CGColor);
    CGContextDrawPath(self.context, kCGPathFillStroke);
    CGContextStrokePath(self.context);
    [@"06:00" drawAtPoint:CGPointMake(0, rect.size.height-15) withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11],NSForegroundColorAttributeName : [UIColor assistTextColor]}];
    [@"17:00" drawAtPoint:CGPointMake(K_Screen_Width/2-15-10, rect.size.height-15) withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11],NSForegroundColorAttributeName : [UIColor assistTextColor]}];
    [@"04:00" drawAtPoint:CGPointMake(K_Screen_Width-15*2, rect.size.height-15) withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11],NSForegroundColorAttributeName : [UIColor assistTextColor]}];
    NSString *stringMax = [NSString stringWithFormat:@"%.2f",self.maxAssetY];
    NSString *stringMin = [NSString stringWithFormat:@"%.2f",self.minAssetY];
    NSString *stringMid = [NSString stringWithFormat:@"%.2f",self.maxAssetY -(self.maxAssetY- self.minAssetY)/2];
    [stringMax drawAtPoint:CGPointMake(5, 0) withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11],NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#f1496c"]}];
    [stringMid drawAtPoint:CGPointMake(5, rect.size.height/4*2) withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11],NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [stringMin drawAtPoint:CGPointMake(5, rect.size.height-15-15) withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11],NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#09cb67"]}];
}


@end
