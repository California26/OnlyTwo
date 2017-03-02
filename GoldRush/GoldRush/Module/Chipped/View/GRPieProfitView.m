//
//  GRPieProfitView.m
//  GoldRush
//
//  Created by Jack on 2017/1/7.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRPieProfitView.h"

#define LINE_WIDTH 2//环形宽度
#define DURATION 1.0//动画时间
#define TEXT_FONT 8.f

@interface GRPieProfitView()

@property (nonatomic,assign) float      percent;
@property (nonatomic,assign) float      radius;
@property (nonatomic,assign) CGPoint    centerPoint;
@property (nonatomic,strong) UIColor    *lineColor;

@property (nonatomic,strong) CAShapeLayer *lineLayer;
@property (nonatomic,strong) CATextLayer  *textLayer;
@property (nonatomic,strong) CATextLayer  *tipLayer;
@property (nonatomic,strong) CAShapeLayer *pointLayer;
@end

@implementation GRPieProfitView

- (instancetype)initWithFrame:(CGRect)frame andPercent:(float)percent andColor:(UIColor *)color{
    if(self = [super initWithFrame:frame]) {
        self.percent = percent;
        self.radius = CGRectGetWidth(frame) / 2.0 - LINE_WIDTH / 2.0;
        self.lineColor = color;
        self.centerPoint = CGPointMake(CGRectGetWidth(frame) / 2.0, CGRectGetWidth(frame) / 2.0);
        [self createBackLine];
        [self commonInit];
    }
    return self;
}

- (void)setPercent:(float)percent {
    if (percent >= 1) {
        _percent = 1;
    }else {
        _percent = percent;
    }
}

- (void)reloadViewWithPercent:(float)percent {
    self.percent = percent;
    [self.layer removeAllAnimations];
    [self.lineLayer removeFromSuperlayer];
    [self.pointLayer removeFromSuperlayer];
    [self.textLayer removeFromSuperlayer];
    [self.tipLayer removeFromSuperlayer];
    [self commonInit];
}

- (void)commonInit {
    [self createPercentLayer];
//    [self createPointLayer];
    [self setPercentTextLayer];
}

- (void)createBackLine {
    //绘制背景
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = LINE_WIDTH;
    shapeLayer.strokeColor = [self.lineColor CGColor];
    shapeLayer.opacity = 0.2;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    UIBezierPath *path = [UIBezierPath new];
    [path addArcWithCenter:self.centerPoint radius:self.radius startAngle:-M_PI / 2.0 endAngle:M_PI / 2 * 3 clockwise:YES];
    shapeLayer.path = path.CGPath;
    [self.layer addSublayer:shapeLayer];
}

- (void)createPercentLayer {
    //绘制环形
    self.lineLayer = [CAShapeLayer layer];
    self.lineLayer.lineWidth = LINE_WIDTH;
    self.lineLayer.lineCap = kCALineCapRound;
    self.lineLayer.strokeColor = [self.lineColor CGColor];
    self.lineLayer.fillColor = [[UIColor clearColor] CGColor];
    UIBezierPath *path = [UIBezierPath new];
    [path addArcWithCenter:self.centerPoint radius:self.radius startAngle:-M_PI / 2.0 endAngle:M_PI * 2 * self.percent - M_PI / 2.0 clockwise:YES];
    self.lineLayer.path = path.CGPath;
    CABasicAnimation *showAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    showAnimation.fromValue = @0;
    showAnimation.toValue = @1;
    showAnimation.duration = DURATION;
    showAnimation.removedOnCompletion = YES;
    showAnimation.fillMode = kCAFillModeForwards;
    [self.layer addSublayer:self.lineLayer];
    [self.lineLayer addAnimation:showAnimation forKey:@"kClockAnimation"];
}


- (void)createPointLayer {
    //头部小白点
    self.pointLayer = [CAShapeLayer layer];
    self.pointLayer.lineWidth = 1;
    self.pointLayer.strokeColor = [[UIColor whiteColor] CGColor];
    self.pointLayer.fillColor = [[UIColor whiteColor] CGColor];
    UIBezierPath *path = [UIBezierPath new];
    [path addArcWithCenter:CGPointMake(CGRectGetWidth(self.bounds) / 2.0, LINE_WIDTH / 2.0) radius:1 startAngle:- M_PI / 2.0 endAngle:M_PI / 2.0 * 3 clockwise:YES];
    self.pointLayer.path = path.CGPath;
    [self.layer addSublayer:self.pointLayer];
}

- (void)setPercentTextLayer {
    self.textLayer = [CATextLayer layer];
    self.textLayer.contentsScale = [[UIScreen mainScreen] scale];
    self.textLayer.string = [NSString stringWithFormat:@"%.1f%%",self.percent * 100];
    self.textLayer.bounds = self.bounds;
    self.textLayer.font = (__bridge CFTypeRef _Nullable)(@"HiraKakuProN-W3");
    self.textLayer.fontSize = 10;
    self.textLayer.alignmentMode = kCAAlignmentCenter;
    self.textLayer.position = CGPointMake(self.centerPoint.x, self.centerPoint.y - 8 + self.radius);
    self.textLayer.foregroundColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:self.textLayer];
    
    self.tipLayer = [CATextLayer layer];
    self.tipLayer.contentsScale = [[UIScreen mainScreen] scale];
    self.tipLayer.string = @"盈利指数";
    self.tipLayer.bounds = self.bounds;
    self.tipLayer.font = (__bridge CFTypeRef _Nullable)(@"HiraKakuProN-W3");
    self.tipLayer.fontSize = TEXT_FONT;
    self.tipLayer.alignmentMode = kCAAlignmentCenter;
    self.tipLayer.position = CGPointMake(self.centerPoint.x, self.centerPoint.y + 8 + self.radius);
    self.tipLayer.foregroundColor = [UIColor lightGrayColor].CGColor;
    [self.layer addSublayer:self.tipLayer];
}

@end
