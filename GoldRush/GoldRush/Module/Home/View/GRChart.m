//
//  GRChart.m
//  GoldRush
//
//  Created by 徐孟林 on 2016/12/21.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRChart.h"
#import "GRPathRangle.h"
#import "GRChartCandleScrollView.h"
#define kRectRangleLeft 5
#define kRectRangleGroupS 4
#define kRectRangleUp     10
#define kRectRangleSpaceX K_Screen_Width-kRectRangleLeft*2 //横轴之间的宽度
#define defaultSmallChartWidth (K_Screen_Width-40*2)/41 //柱形图的默认宽度
#define defaultSmallChartMag 2
@interface GRChart ()<UIGestureRecognizerDelegate,UIScrollViewDelegate>
{
    CGFloat heightY;//矩形距离下面的距离
    CGFloat heightGroup;//矩形Y之间的距离
    CGFloat heightCroupY;//矩形X之间的距离
    double xStart;
    CGContextRef currentContext;
    CGRect rectRangle;
    
    //字体颜色组成的字典
    NSDictionary *dictRed;
    NSDictionary *dictBlack;
    NSDictionary *dictBlue;
    CGFloat xPoint;
    NSMutableDictionary *dicPoint;
    CGFloat defaultZoomScale ;
}

@property (nonatomic,strong) NSArray *aryDashLinePoint;//虚线
@property (nonatomic,strong) NSMutableArray *aryValues;
@property (nonatomic,strong) NSMutableArray *aryBrokenPoint;//需要不断添加的数据

@property (nonatomic,strong) GRPathRangle *rangle;
//长按视图需要显示的View
@property (nonatomic,strong) UIView *viewYLine;
@property (nonatomic,strong) UIView *viewXLine;
@property (nonatomic,strong) UILabel *labelYLine;
@property (nonatomic,strong) UILabel *labelXLineLeft;
@property (nonatomic,strong) UILabel *labelXLineRight;


@property (nonatomic,strong) NSMutableArray *aryPoint1;
@property (nonatomic,strong) NSMutableArray *aryPoint2;
@property (nonatomic,strong) NSMutableArray *aryLineHeight;
@property (nonatomic,strong) NSMutableArray *aryRangleHeight;
@property (nonatomic,strong) NSMutableArray *aryChartBool;

//蜡烛图
@property (nonatomic,strong) GRChartCandleScrollView *candleScrollView;
@property (nonatomic,strong) NSMutableArray *aryShowInCSView;

@end

@implementation GRChart
const CGFloat   kXScale = 1;
const CGFloat   kYScale = 50.0;


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _aryValues = [NSMutableArray array];
        _aryBrokenPoint = [NSMutableArray array];
        _aryPoint1 = [NSMutableArray array];
        _aryPoint2 = [NSMutableArray array];
        _aryLineHeight = [NSMutableArray array];
        _aryRangleHeight = [NSMutableArray array];
        dicPoint = [NSMutableDictionary dictionary];
        _aryChartBool = [NSMutableArray array];
        _aryShowInCSView = [NSMutableArray array];
        defaultZoomScale = 1;
        _rangle = [[GRPathRangle alloc] init];
        dictRed = @{NSFontAttributeName : [UIFont systemFontOfSize:10],
                                  NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#f1496c"],
                                  };
        dictBlack = @{NSFontAttributeName:[UIFont systemFontOfSize:10],
                                    NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#666666"]};
        dictBlue = @{NSFontAttributeName :[UIFont systemFontOfSize:10],
                                   NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#09cb67"]};
        heightY = frame.size.height-20;
        heightGroup = (frame.size.height-30)/kRectRangleGroupS;
        heightCroupY = (frame.size.width-kRectRangleLeft*2)/kRectRangleGroupS;
        _aryDashLinePoint = @[
  @[[NSValue valueWithCGPoint:CGPointMake(kRectRangleLeft, kRectRangleUp+heightGroup)],[NSValue valueWithCGPoint:CGPointMake(K_Screen_Width-kRectRangleLeft, kRectRangleUp+heightGroup)]],
  @[[NSValue valueWithCGPoint:CGPointMake(kRectRangleLeft, kRectRangleUp+heightGroup*2)],[NSValue valueWithCGPoint:CGPointMake(K_Screen_Width-kRectRangleLeft, kRectRangleUp+heightGroup*2)]],
  @[[NSValue valueWithCGPoint:CGPointMake(kRectRangleLeft, kRectRangleUp+heightGroup*3)],[NSValue valueWithCGPoint:CGPointMake(K_Screen_Width-kRectRangleLeft, kRectRangleUp+heightGroup*3)]],
  @[[NSValue valueWithCGPoint:CGPointMake(heightCroupY+kRectRangleLeft, kRectRangleUp)],[NSValue valueWithCGPoint:CGPointMake(heightCroupY+kRectRangleLeft, heightY)]],
  @[[NSValue valueWithCGPoint:CGPointMake(heightCroupY*2+kRectRangleLeft, kRectRangleUp)],[NSValue valueWithCGPoint:CGPointMake(heightCroupY*2+kRectRangleLeft, heightY)]],
  @[[NSValue valueWithCGPoint:CGPointMake(heightCroupY*3+kRectRangleLeft, kRectRangleUp)],[NSValue valueWithCGPoint:CGPointMake(heightCroupY*3+kRectRangleLeft, heightY)]]];
        _candleScrollView = [[GRChartCandleScrollView alloc] initWithFrame:CGRectMake(kRectRangleLeft, kRectRangleUp, K_Screen_Width-kRectRangleLeft*2, self.frame.size.height-kRectRangleUp-20)];
        _candleScrollView.delegate = self;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        view.backgroundColor = [UIColor clearColor];
        [_candleScrollView addSubview:view];
        _candleScrollView.bouncesZoom = NO;
        _candleScrollView.maximumZoomScale = 3;
        _candleScrollView.minimumZoomScale = 0.3;
        [self addSubview:self.candleScrollView];
        
        //长按手势
        [self addLongGesture];
        [self creatCrossView];
    }
    return self;
}

- (void)setDicSource60:(NSDictionary *)dicSource60
{
    _dicSource60 = dicSource60;
    xStart = kRectRangleLeft;
    [self updateRangleValues];
}

- (void)setDicSource:(NSDictionary *)dicSource
{
    _dicSource = dicSource;
    xPoint = 1;
    [self upDateValues];
}

- (void)updateRangleValues
{
    [_aryBrokenPoint removeAllObjects];
    NSArray *aryTemp = _dicSource60[@"dataList"];
    int max = [[self getBreakLineMaxNumberWith:aryTemp][0] intValue];
    int min = [[self getBreakLineMaxNumberWith:aryTemp][1] intValue];
    float averageY = (self.frame.size.height-30)/(max-min);
    for (int i = 0; i<aryTemp.count; i++) {
        int nextPointy = [aryTemp[i] intValue];
        [_aryBrokenPoint addObject:[NSValue valueWithCGPoint:CGPointMake(xStart,(max - nextPointy)*averageY+10)]];
        xStart = xStart + 2;
        double nextValue = sin(CFAbsoluteTimeGetCurrent()) + ((double)rand() / (double)RAND_MAX);
        [_aryValues addObject:[NSNumber numberWithDouble:nextValue]];
    }

    CGSize size = self.bounds.size;
    CGFloat maxDimension = size.width;
    NSUInteger maxValues = (NSUInteger)floorl(maxDimension/kXScale);
    if ([self.aryValues count] > maxValues) {
        [self.aryValues removeObjectsInRange:NSMakeRange(0, [self.aryValues count] - maxValues)];
    }
    [self setNeedsDisplay];
}
- (void)upDateValues
{
    [_aryPoint1 removeAllObjects];
    [_aryPoint2 removeAllObjects];
    [_aryLineHeight removeAllObjects];
    [_aryRangleHeight removeAllObjects];
    NSArray *tempAry = [self getMaxNumberWithAry:self.dicSource[@"dataList"]];
    int max = [tempAry[0] intValue];
    int min = [tempAry[1] intValue];
    float averageY = (self.frame.size.height-30)/(max-min);
    NSLog(@"%f",defaultSmallChartWidth);
    for (NSArray *smallAry in self.dicSource[@"dataList"]) {
        [_aryPoint1 addObject:[NSValue valueWithCGPoint:CGPointMake(xPoint+defaultSmallChartWidth/2, (max-[smallAry[3] intValue])*averageY+10)]];
        [_aryPoint2 addObject:[NSValue valueWithCGPoint:CGPointMake(xPoint+0, (max-[smallAry[1] intValue])*averageY+10)]];
        [_aryLineHeight addObject:@(([smallAry[3] intValue]-[smallAry[2] intValue])*averageY)];
        [_aryRangleHeight addObject:@(abs([smallAry[1] intValue]-[smallAry[0] intValue])*averageY)];
        xPoint = xPoint + defaultSmallChartWidth + 2;
    }
    if (xPoint+40>kRectRangleSpaceX) {
        [_candleScrollView setContentSize:CGSizeMake(xPoint+10, self.candleScrollView.frame.size.height)];
        [_candleScrollView setContentOffset:CGPointMake(xPoint-100, 0) animated:YES];
    }else{

    }
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect
{
    if (_aryValues.count == 0) {
        return;
    }
    currentContext = UIGraphicsGetCurrentContext();
    rectRangle = CGRectMake(kRectRangleLeft, 10, kRectRangleSpaceX, self.frame.size.height-30);
    CGRect dashRect = CGRectMake(0, 0, kRectRangleLeft, rect.size.height-30);
    CGRect avgRect = CGRectMake(kRectRangleLeft, 0, kRectRangleLeft, rect.size.height-20);
    for (NSArray<NSValue *> *smallAry in _aryDashLinePoint) {
        [_rangle creatDashLineWith:smallAry withFrame:dashRect withContext:currentContext];
    }
    [_rangle creatBigRangleWithContext:currentContext withFrame:rectRangle];
    //不同的时间段
    if (!_timeQuantum) {
        self.candleScrollView.hidden = YES;
        [_rangle creatBrokenLineWith:currentContext withFrame:avgRect withArray:_aryBrokenPoint];
        [_rangle creatAvgLineWithContext:currentContext withAry:_aryValues withFrame:avgRect];
    }else{
        self.candleScrollView.hidden = NO;
        [self.candleScrollView setNeedsDisplay];
        _candleScrollView.pointLineAry = [_aryPoint1 mutableCopy];
        _candleScrollView.heightLineAry = [_aryLineHeight mutableCopy];
        _candleScrollView.pointRangleAry = [_aryPoint2 mutableCopy];
        _candleScrollView.heightRangleAry = [_aryRangleHeight mutableCopy];
        _candleScrollView.aryBool = [_aryChartBool mutableCopy];
        _candleScrollView.scale = defaultZoomScale*defaultSmallChartWidth;
    }
    [self creatLabelLeftAndRight];

}

- (void)creatLabelLeftAndRight
{
    NSArray *aryLabelText ;
    NSArray *arylabelNumber;
    CGFloat labelRightX = K_Screen_Width-kRectRangleLeft-30;
    CGFloat labelMinY = 7;
    if (!_timeQuantum) {
        aryLabelText = @[@"3600",@"3590",@"3580",@"3570",@"35360",@"0.30%",@"0.30%",@"0.32%",@"0.32%",@"0.32%"];
        arylabelNumber = [NSArray arrayWithObjects:@{@"point":[NSValue valueWithCGPoint:CGPointMake(kRectRangleLeft, kRectRangleUp)], @"text":aryLabelText[0],@"Attribute":dictRed},
                          @{@"point":[NSValue valueWithCGPoint:CGPointMake(kRectRangleLeft, kRectRangleUp+heightGroup-labelMinY)],@"text":aryLabelText[1],@"Attribute":dictRed},
                          @{@"point":[NSValue valueWithCGPoint:CGPointMake(kRectRangleLeft, kRectRangleUp+heightGroup*2-labelMinY)],@"text":aryLabelText[2],@"Attribute":dictBlack},
                          @{@"point":[NSValue valueWithCGPoint:CGPointMake(kRectRangleLeft, kRectRangleUp+heightGroup*3-labelMinY)],@"text":aryLabelText[3],@"Attribute":dictBlue},
                          @{@"point":[NSValue valueWithCGPoint:CGPointMake(kRectRangleLeft, self.frame.size.height-20-12)],@"text":aryLabelText[4],@"Attribute":dictBlue},
                          @{@"point":[NSValue valueWithCGPoint:CGPointMake(labelRightX, kRectRangleUp)],@"text":aryLabelText[5],@"Attribute":dictRed},
                          @{@"point":[NSValue valueWithCGPoint:CGPointMake(labelRightX, kRectRangleUp+heightGroup-labelMinY)],@"text":aryLabelText[6],@"Attribute":dictRed},
                          @{@"point":[NSValue valueWithCGPoint:CGPointMake(labelRightX, kRectRangleUp+heightGroup*2-labelMinY)],@"text":aryLabelText[7],@"Attribute":dictBlack},
                          @{@"point":[NSValue valueWithCGPoint:CGPointMake(labelRightX, kRectRangleUp+heightGroup*3-labelMinY)],@"text":aryLabelText[8],@"Attribute":dictBlue},
                          @{@"point":[NSValue valueWithCGPoint:CGPointMake(labelRightX, kRectRangleUp+self.frame.size.height-42)],@"text":aryLabelText[9],@"Attribute":dictBlue}, nil];
    }else
    {
        aryLabelText = @[@"3600",@"3590",@"3580",@"3570",@"35360"];
        arylabelNumber = [NSArray arrayWithObjects:@{@"point":[NSValue valueWithCGPoint:CGPointMake(kRectRangleLeft, kRectRangleUp)], @"text":aryLabelText[0],@"Attribute":dictRed},
                          @{@"point":[NSValue valueWithCGPoint:CGPointMake(kRectRangleLeft, kRectRangleUp+heightGroup-labelMinY)],@"text":aryLabelText[1],@"Attribute":dictRed},
                          @{@"point":[NSValue valueWithCGPoint:CGPointMake(kRectRangleLeft, kRectRangleUp+heightGroup*2-labelMinY)],@"text":aryLabelText[2],@"Attribute":dictBlack},
                          @{@"point":[NSValue valueWithCGPoint:CGPointMake(kRectRangleLeft, kRectRangleUp+heightGroup*3-labelMinY)],@"text":aryLabelText[3],@"Attribute":dictBlue},
                          @{@"point":[NSValue valueWithCGPoint:CGPointMake(kRectRangleLeft, self.frame.size.height-20-12)],@"text":aryLabelText[4],@"Attribute":dictBlue}, nil];
    }
    for (int i = 0; i<arylabelNumber.count; i++) {
        CGPoint point = [arylabelNumber[i][@"point"] CGPointValue];
        NSString *text = arylabelNumber[i][@"text"];
        NSDictionary *dict = arylabelNumber[i][@"Attribute"];
        [self drawStringWith:text point:point withDict:dict];
    }
}

- (void)drawStringWith:(NSString *)text
                 point:(CGPoint)point
              withDict:(NSDictionary *)dict
{
    [text drawInRect:CGRectMake(point.x, point.y, 80, 15) withAttributes:dict];
}

#pragma mark 添加长按手势
- (void)addLongGesture
{
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    gesture.delegate = self;
    [self addGestureRecognizer:gesture];
}

- (void)tapAction:(UILongPressGestureRecognizer *)sender
{
    CGPoint point  = [sender locationInView:self];
    if (sender.state == UIGestureRecognizerStateBegan) {
        _viewYLine.frame = CGRectMake(point.x, kRectRangleUp, 0.5, self.frame.size.height-30);
        _viewXLine.frame = CGRectMake(kRectRangleLeft, point.y, kRectRangleSpaceX, 0.5);
        _labelYLine.frame = CGRectMake(CGRectGetMaxX(_viewYLine.frame), CGRectGetMinY(_viewYLine.frame), 40, 20);
        _labelXLineLeft.frame = CGRectMake(CGRectGetMinX(_viewXLine.frame), CGRectGetMinY(_viewXLine.frame)-10, 40, 20);
        _labelXLineRight.frame = CGRectMake(K_Screen_Width-kRectRangleLeft-40, CGRectGetMinY(_viewXLine.frame)-10, CGRectGetWidth(_labelXLineLeft.frame), CGRectGetHeight(_labelXLineLeft.frame));
        _viewXLine.hidden = NO;
        _viewYLine.hidden = NO;
        _labelXLineLeft.hidden = NO;
        _labelYLine.hidden = NO;
        if (!_timeQuantum) {
            _labelXLineRight.hidden = NO;
        }else{
            _labelXLineRight.hidden = YES;
        }
    }else if(sender.state == UIGestureRecognizerStateEnded){
        _viewXLine.hidden = YES;
        _viewYLine.hidden = YES;
        _labelXLineLeft.hidden = YES;
        _labelXLineRight.hidden = YES;
        _labelYLine.hidden = YES;
    }else if (sender.state == UIGestureRecognizerStateChanged)
    {
        _viewYLine.frame = CGRectMake(point.x, kRectRangleUp, 0.5, self.frame.size.height-30);
        _viewXLine.frame = CGRectMake(kRectRangleLeft, point.y, kRectRangleSpaceX, 0.5);
        _labelYLine.frame = CGRectMake(CGRectGetMaxX(_viewYLine.frame), CGRectGetMinY(_viewYLine.frame), 40, 20);
        _labelXLineLeft.frame = CGRectMake(CGRectGetMinX(_viewXLine.frame), CGRectGetMinY(_viewXLine.frame)-10, 40, 20);
        _labelXLineRight.frame = CGRectMake(K_Screen_Width-kRectRangleLeft-40, CGRectGetMinY(_viewXLine.frame)-10, CGRectGetWidth(_labelXLineLeft.frame), CGRectGetHeight(_labelXLineLeft.frame));
  
    }
    
}
- (void)creatCrossView
{
    _viewYLine = [[UIView alloc] init];
    _viewYLine.backgroundColor = [UIColor blackColor];
    _viewXLine = [[UIView alloc] init];
    _viewXLine.backgroundColor = _viewYLine.backgroundColor;
    _labelYLine = [[UILabel alloc] init];
    _labelYLine.backgroundColor = GRColor(82, 82, 82);
    _labelYLine.textColor = [UIColor whiteColor];
    _labelXLineLeft = [[UILabel alloc] init];
    _labelXLineLeft.backgroundColor = _labelYLine.backgroundColor;
    _labelXLineLeft.textColor = _labelYLine.textColor;
    _labelXLineRight = [[UILabel alloc] init];
    _labelXLineRight.backgroundColor = _labelYLine.backgroundColor;
    _labelXLineRight.textColor = _labelYLine.textColor;
    NSArray *ary = @[_viewYLine,_viewXLine,_labelYLine,_labelXLineLeft,_labelXLineRight];
    for (UIView *view in ary) {
        view.hidden = YES;
        [self addSubview:view];
    }
}
#pragma mark scrollDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    dispatch_async(dispatch_get_main_queue(), ^{
        [scrollView setContentOffset:CGPointMake(offsetX, 0)];
    });
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return scrollView.subviews[0];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    UIView *subview = scrollView.subviews[0];
    subview.frame = CGRectMake(0, 0, scrollView.frame.size.width*scrollView.zoomScale, scrollView.frame.size.height);
    CGFloat xzoom = 1;
    _candleScrollView.scale = scrollView.zoomScale*defaultSmallChartWidth;
    NSMutableArray *zoomAryPoint1 = [NSMutableArray array];
    NSMutableArray *zoomAryPoint2 = [NSMutableArray array];
    for (int i = 0; i<_aryPoint1.count; i++) {
        CGPoint point1 = [self.aryPoint1[i] CGPointValue];
        CGPoint point2 = [_aryPoint2[i] CGPointValue];
        if (scrollView.zoomScale>1) {
            [zoomAryPoint1 addObject:[NSValue valueWithCGPoint:CGPointMake(xzoom+(scrollView.zoomScale*defaultSmallChartWidth/2),point1.y*(scrollView.zoomScale))]];
            [zoomAryPoint2 addObject:[NSValue valueWithCGPoint:CGPointMake(xzoom, point2.y*(scrollView.zoomScale))]];
        }else{
            [zoomAryPoint1 addObject:[NSValue valueWithCGPoint:CGPointMake(xzoom+(scrollView.zoomScale*defaultSmallChartWidth/2),point1.y)]];
            [zoomAryPoint2 addObject:[NSValue valueWithCGPoint:CGPointMake(xzoom, point2.y)]];
        }
        xzoom = xzoom + scrollView.zoomScale*defaultSmallChartWidth + 1.5;
    }
    _candleScrollView.pointLineAry = [zoomAryPoint1 mutableCopy];
    _candleScrollView.pointRangleAry = [zoomAryPoint2 mutableCopy];
    [_candleScrollView setNeedsDisplay];
}

- (NSArray *)getMaxNumberWithAry:(NSArray *)smallAry
{
    int max = 0 ;
    int min = [smallAry[0][3] intValue];
    int open = [smallAry[0][0] intValue];
    for (int i = 0; i<smallAry.count; i++) {
        int temp = [smallAry[i][3] intValue];
        int openTemp = [smallAry[i][0] intValue];
        if (temp > max) {
            max = temp;
        }
        if (temp < min) {
            min = temp;
        }
        if (openTemp>open) {
            [_aryChartBool addObject:@(YES)];
        }else{
            [_aryChartBool addObject:@(NO)];
        }
        open = openTemp;
    }
    NSArray *ary = [NSArray arrayWithObjects:@(max),@(min), nil];
    return ary;
}

- (NSArray *)getBreakLineMaxNumberWith:(NSArray *)smallAry
{
    int max = 0 ;
    int min = [smallAry[0] intValue];
    for (int i = 0; i<smallAry.count; i++) {
        int temp = [smallAry[i] intValue];
        if (temp > max) {
            max = temp;
        }
        if (temp < min) {
            min = temp;
        }
    }
    NSArray *ary = [NSArray arrayWithObjects:@(max),@(min), nil];
    return ary;
}


- (void)dealloc
{
    
}


@end
