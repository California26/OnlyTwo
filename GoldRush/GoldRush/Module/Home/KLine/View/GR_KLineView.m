//
//  GR_KLineView.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/16.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GR_KLineView.h"
#import "GRKLine_MainView.h"
#import "UIColor+GRChart.h"

#import "GRChartGlobalVariable.h"
#import "GRLongPressRightHView.h"
#import "GRChart_LeftPriceView.h"

@interface GR_KLineView ()<UIScrollViewDelegate,GRKLine_MainDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) GRChart_LeftPriceView *priceView;
//主K线图
@property (nonatomic,strong) GRKLine_MainView *kLineMainView;
//旧的scrollView的准确位移
@property (nonatomic,assign) CGFloat oldExactOffset;
//长按后显示垂直View
@property (nonatomic,strong) UIView *verticalView;
//长按后显示水平View
@property (nonatomic,strong) UIView *horizontalView;
//长按后显示垂直Label
@property (nonatomic,strong) UILabel *labelV;
//长按后显示水平左边Label
@property (nonatomic,strong) UILabel *labelHLeft;
//长按后显示水平👉View
@property (nonatomic,strong) GRLongPressRightHView *viewHRight;

@end
@implementation GR_KLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.mainViewHeight = [GRChartGlobalVariable kLineMainViewRadio];
        [self addSubview:_priceView];
        [self bringSubviewToFront:_priceView];
    }
    return self;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.minimumZoomScale = 1.0f;
        _scrollView.maximumZoomScale = 1.0f;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(event_pinchMethod:)];
        
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(event_longPressMethod:)];

        //缩放手势
        [_scrollView addGestureRecognizer:pinchGesture];
        
        //长按手势
        [_scrollView addGestureRecognizer:longPressGesture];
        [self addSubview:_scrollView];
        _scrollView.frame = CGRectMake(0, 0, K_Screen_Width, self.frame.size.height);
        [self layoutIfNeeded];
    }
    return _scrollView;
}

- (GRKLine_MainView *)kLineMainView
{
    if (!_kLineMainView && self) {
        _kLineMainView = [GRKLine_MainView new];
        _kLineMainView.backgroundColor = [UIColor clearColor];
        _kLineMainView.delegate = self;
        [self.scrollView addSubview:_kLineMainView];
        [_kLineMainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollView);
            make.left.equalTo(self.scrollView);
            make.height.equalTo(self.scrollView);
            make.width.equalTo(@0);
        }];
    }
    return _kLineMainView;
}


- (GRChart_LeftPriceView *)priceView
{
    if (!_priceView) {
        _priceView = [[GRChart_LeftPriceView alloc] initWithFrame:CGRectMake(0, 0, 60, self.scrollView.bounds.size.height-20)];
        [self addSubview:self.priceView];
        [self bringSubviewToFront:self.priceView];
    }
    return _priceView;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    //如果数组为空，则不进行绘制，直接设置本view为背景
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //设置view的背景颜色
    CGContextClearRect(context, rect);
    CGContextSetFillColorWithColor(context, [UIColor backgroundColor].CGColor);
    CGContextFillRect(context, rect);
    
    [[UIColor colorWithHexString:@"#4c4c56"] setStroke];
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1.0);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(1, 1, rect.size.width-2, rect.size.height-2-15));
    CGContextAddPath(context, path);
    CGPathRelease(path);
    CGContextStrokePath(context);
    
    //第一条线
    CGContextSetLineWidth(context, 1);
//    [[UIColor colorWithHexString:@"#b1b2b6"] setStroke];
    CGContextMoveToPoint(context, 1, rect.size.height/4);
    CGContextAddLineToPoint(context, rect.size.width-2, rect.size.height/4);
//   下面的arr中的数字表示先绘制3个点再绘制1个点
    CGFloat arr[] = {3,1};
    //下面最后一个参数“1”代表排列的个数。
    CGContextSetLineDash(context, 0, arr, 1);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, 1, rect.size.height/4*2);
    CGContextAddLineToPoint(context, rect.size.width-2, rect.size.height/4*2);
    CGContextSetLineDash(context, 0, arr, 1);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, 1, rect.size.height/4*3);
    CGContextAddLineToPoint(context, rect.size.width-2, rect.size.height/4*3);
    CGContextSetLineDash(context, 0, arr, 1);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, rect.size.width/4, 1);
    CGContextAddLineToPoint(context, rect.size.width/4,rect.size.height-2);
    CGContextSetLineDash(context, 0, arr, 1);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, rect.size.width/4*2, 1);
    CGContextAddLineToPoint(context, rect.size.width/4*2, rect.size.height-2);
    CGContextSetLineDash(context, 0, arr, 1);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, rect.size.width/4*3, 1);
    CGContextAddLineToPoint(context, rect.size.width/4*3, rect.size.height-2);
    CGContextSetLineDash(context, 0, arr, 1);
    CGContextStrokePath(context);
    
    
    
    
}
#pragma mark - event事件处理方法
#pragma mark 缩放执行方法
- (void)event_pinchMethod:(UIPinchGestureRecognizer *)pinch
{
    static CGFloat oldScale = 1.0f;
    CGFloat difValue = pinch.scale - oldScale;
    if (ABS(difValue) > Y_StockChartScaleBound) {
        CGFloat oldKLineWidth = [GRChartGlobalVariable kLineWidth];
        NSInteger oldNeedDrawStartindex = self.kLineMainView.needDrawStartIndex;
        GRLog(@"原来的index%ld",self.kLineMainView.needDrawStartIndex);
        [GRChartGlobalVariable setkLineWith:oldKLineWidth * (difValue > 0 ? (1+ Y_StockChartScaleFactor) : (1 - Y_StockChartScaleFactor))];
        oldScale = pinch.scale;
        //更新MainView的宽度
        [self.kLineMainView updateMainViewWidth];
        
        if (pinch.numberOfTouches == 2) {
            CGPoint p1 = [pinch locationOfTouch:0 inView:self.scrollView];
            CGPoint p2 = [pinch locationOfTouch:1 inView:self.scrollView];
            CGPoint centerPoint = CGPointMake((p1.x+p2.x)/2, (p1.y + p2.y)/2);
            NSUInteger oldLeftArrcount = ABS((centerPoint.x - self.scrollView.contentOffset.x) - [GRChartGlobalVariable kLineGap]) / ([GRChartGlobalVariable kLineGap] + oldKLineWidth);
            NSUInteger newLeftArrcount = ABS((centerPoint.x - self.scrollView.contentOffset.x) - [GRChartGlobalVariable kLineGap]) / ([GRChartGlobalVariable kLineGap] + [GRChartGlobalVariable kLineWidth]);
            self.kLineMainView.pinchStartIndex = oldNeedDrawStartindex + oldLeftArrcount - newLeftArrcount;
            GRLog(@"计算得出的index%lu",self.kLineMainView.pinchStartIndex);
        }
        [self.kLineMainView drawMainView];
    }
}
//长按手势
- (void)event_longPressMethod:(UILongPressGestureRecognizer *)longPress
{
    static CGFloat oldPositionX = 0;
    if (UIGestureRecognizerStateChanged == longPress.state || UIGestureRecognizerStateBegan == longPress.state) {
        CGPoint location = [longPress locationInView:self.scrollView];
        if (self.MainViewType == Y_StockChartcenterViewTypeTimeLine || self.MainViewType == Y_StockChartcenterViewTypeOther) {
            
        }else{
            if (ABS(oldPositionX - location.x) < ([GRChartGlobalVariable kLineWidth] + [GRChartGlobalVariable kLineGap])/2) {
                
                
                return;
            }
        }
        
        //暂停滑动
        self.scrollView.scrollEnabled = NO;
        oldPositionX = location.x;
        //初始化竖线
        if (!_verticalView) {
            self.verticalView = [UIView new];
            self.verticalView.clipsToBounds = YES;
            [self.scrollView addSubview:self.verticalView];
            self.verticalView.backgroundColor = [UIColor longPressLineColor];
            [self.verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(15);
                make.width.equalTo(@(Y_StockChartLongPressVerticalViewWidth));
                make.height.equalTo(self.scrollView.mas_height);
                make.left.equalTo(@(-10));
            }];
        }
        
        //初始化横线
        if (!_horizontalView) {
            _horizontalView = [UIView new];
            self.horizontalView.clipsToBounds = YES;
            [self addSubview:self.horizontalView];
            self.horizontalView.backgroundColor = [UIColor longPressLineColor];
            [self.horizontalView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@(0));
                make.top.equalTo(@(0));
                make.width.equalTo(self.scrollView.mas_width);
                make.height.equalTo(@(Y_StockChartLongPressVerticalViewWidth));
            }];
        }
        
        if (!_labelV) {
            _labelV = [UILabel new];
            self.labelV.clipsToBounds = YES;
            [self.scrollView addSubview:self.labelV];
            self.labelV.font = [UIFont systemFontOfSize:12];
            self.labelV.backgroundColor = [UIColor assistTextColor];
            self.labelV.textColor = [UIColor whiteColor];
            self.labelV.backgroundColor = [UIColor longPressLineColor];
            [self.labelV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.verticalView).offset(-15);
                make.width.equalTo(@(Y_StockChartLongPressVerticalLabelWidth));
                make.height.equalTo(@(18));
                make.left.equalTo(self.verticalView).offset(0);
            }];
        }
        
        if (!_labelHLeft) {
            _labelHLeft = [UILabel new];
            self.labelHLeft.clipsToBounds = YES;
            [self addSubview:self.labelHLeft];
            self.labelHLeft.font = [UIFont systemFontOfSize:12];
            self.labelHLeft.backgroundColor = [UIColor assistTextColor];
            self.labelHLeft.textColor = [UIColor whiteColor];
            self.labelHLeft.backgroundColor = [UIColor longPressLineColor];
            [self.labelHLeft sizeToFit];
            [self.labelHLeft mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.horizontalView).offset(-15);
                make.width.equalTo(@(Y_StockChartLongPressHorizontalLabelWidth));
                make.height.equalTo(@(18));
                make.left.equalTo(@(0));
            }];
        }
        if (self.MainViewType == Y_StockChartcenterViewTypeKline) {
            if (!_viewHRight) {
                _viewHRight = [[GRLongPressRightHView alloc] initWithFrame:CGRectMake(K_Screen_Width-80, self.frame.origin.x, 80, 20*5)];
                _viewHRight.clipsToBounds = YES;
                [self addSubview:self.viewHRight];
            }
        }else{
            [_viewHRight removeFromSuperview];
        }
        
        //更新竖线位置
        NSArray *aryModels = [self.kLineMainView getExactXPositionWithOriginXPosition:location.x];
        GRChart_KLinePositionModel *positionModel = (GRChart_KLinePositionModel *)aryModels.firstObject;
        GRChart_KLineModel *kLineModel = ((GRChart_KLineModel *)aryModels.lastObject);
        [self.verticalView mas_updateConstraints:^(MASConstraintMaker *make) {
            if (positionModel.currentPoint.y > 0) {
                make.left.equalTo(@(positionModel.currentPoint.x));
            }else{
                make.left.equalTo(@(positionModel.HighPoint.x));
            }
        }];
        [self.verticalView layoutIfNeeded];
        self.verticalView.hidden = NO;
        
        [self.labelV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.verticalView).offset(0);
        }];
        self.labelV.text = kLineModel.date;
        [self.labelV layoutIfNeeded];
        self.labelV.hidden = NO;
        //更新横线位置
        [self.horizontalView mas_updateConstraints:^(MASConstraintMaker *make) {
            if (positionModel.currentPoint.y > 0) {
                make.top.equalTo(@(positionModel.currentPoint.y));
            }else{
                make.top.equalTo(@(positionModel.OpenPoint.y));
            }
        }];
        [self.horizontalView layoutIfNeeded];
        self.horizontalView.hidden = NO;
        
        [self.labelHLeft mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.horizontalView).offset(-15);
        }];
        
        if (kLineModel.open.floatValue > 0) {
            self.labelHLeft.text = [NSString stringWithFormat:@"%.2f",kLineModel.open.floatValue < kLineModel.close.floatValue ? kLineModel.close.floatValue : kLineModel.open.floatValue];
        }else{
            self.labelHLeft.text = [NSString stringWithFormat:@"%.2f",((GRChart_KLineModel *)aryModels.lastObject).minuteNumber.floatValue];
        }
        [self.labelHLeft layoutIfNeeded];
        self.labelHLeft.hidden = NO;
        
        self.viewHRight.hidden = NO;
//        if (location.x > K_Screen_Width/2) {
            if (positionModel.OpenPoint.y > self.frame.size.height/2) {
                self.viewHRight.frame = CGRectMake(K_Screen_Width-100, positionModel.OpenPoint.y - self.viewHRight.frame.size.height, self.viewHRight.frame.size.width, self.viewHRight.frame.size.height);
//                [self.viewHRight mas_makeConstraints:^(MASConstraintMaker *make) {
//                   make.top.equalTo(positionModel.OpenPoint.y - )
//                }];
            }else{
                self.viewHRight.frame = CGRectMake(K_Screen_Width-100, self.horizontalView.frame.origin.y, self.viewHRight.frame.size.width, self.viewHRight.frame.size.height);
            }
//        }else{
//            if (positionModel.OpenPoint.y > self.frame.size.height/2) {
//                self.viewHRight.frame = CGRectMake(0, self.horizontalView.frame.origin.y-self.viewHRight.frame.size.height, self.viewHRight.frame.size.width, self.viewHRight.frame.size.height);
//            }else{
//                self.viewHRight.frame = CGRectMake(0, self.horizontalView.frame.origin.y, self.viewHRight.frame.size.width, self.viewHRight.frame.size.height);
//            }
//        }
        self.viewHRight.model = kLineModel;
        
    }
        if (longPress.state == UIGestureRecognizerStateEnded) {
            // 取消竖线
            if (self.verticalView) {
                self.verticalView.hidden = YES;
            }
            if (self.labelV) {
                self.labelV.hidden = YES;
            }
            //取消横线
            if (self.horizontalView) {
                self.horizontalView.hidden = YES;
            }
            if (self.labelHLeft) {
                self.labelHLeft.hidden = YES;
            }
            if (self.viewHRight) {
                self.viewHRight.hidden = YES;
            }
            oldPositionX = 0;
            //取消scrollview的滑动
            self.scrollView.scrollEnabled = YES;
        }
    
}

- (void)setMainViewType:(Y_StockChartCenterViewType)MainViewType
{
    _MainViewType = MainViewType;
    self.kLineMainView.MainViewType = MainViewType;
}

#pragma mark 重绘
- (void)reDraw
{
    [self.kLineMainView drawMainView];
}

#pragma mark - set方法
- (void)setKLineModels:(NSArray<GRChart_KLineModel *> *)kLineModels
{
    if (!kLineModels) {
        return;
    }
    _kLineModels = kLineModels;
    self.kLineMainView.needDrawStartIndex = 0;
    [GRChartGlobalVariable setkLineWith:4];
    [self private_drawKLineMainView];
    
    //设置contentOffset
    if (self.MainViewType == Y_StockChartcenterViewTypeTimeLine || self.MainViewType == Y_StockChartcenterViewTypeOther) {
        
    }else{
        CGFloat kLineViewWidth = self.kLineModels.count * [GRChartGlobalVariable kLineWidth] + (self.kLineModels.count + 1) * [GRChartGlobalVariable kLineGap] + 10;
        CGFloat offset = kLineViewWidth - self.scrollView.frame.size.width;
        if (offset > 0) {
            self.scrollView.contentOffset = CGPointMake(offset, 0);
        }else{
            self.scrollView.contentOffset = CGPointMake(0, 0);
        }
    }
    
}


#pragma mark - 私有方法
#pragma mark 画KLineMainView
-  (void)private_drawKLineMainView
{
    self.kLineMainView.kLineModels = self.kLineModels;
    [self.kLineMainView drawMainView];
}

- (void)kLineMainViewCurrentMaxPrice:(CGFloat)maxPrice minPrice:(CGFloat)minPrice
{
    if (self.MainViewType == Y_StockChartcenterViewTypeKline) {
        self.priceView.hidden = NO;
        self.priceView.maxValue = maxPrice;
        self.priceView.minValue = minPrice;
        self.priceView.middleValue = maxPrice - (maxPrice - minPrice)/2;
    }else{
        self.priceView.hidden = YES;
    }
    
}

- (void)setStringYesterDay:(NSString *)stringYesterDay
{
    _stringYesterDay = stringYesterDay;
}
#pragma mark MainView 更新时通知下方的view进行相应内容更新

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    static BOOL isNeedPostNotification = YES;
    //    if(scrollView.contentOffset.x < scrollView.frame.size.width * 2)
    //    {
    //        if(isNeedPostNotification)
    //        {
    //            self.oldExactOffset = scrollView.contentSize.width - scrollView.contentOffset.x;
    //            isNeedPostNotification = NO;
    //        }
    //    } else {
    //        isNeedPostNotification = YES;
    //    }
    
//    GRLog(@"这是  %f-----%f=====%f",scrollView.contentSize.width,scrollView.contentOffset.x,self.kLineMainView.frame.size.width);
}

- (void)dealloc
{
    [_kLineMainView removeAllObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
