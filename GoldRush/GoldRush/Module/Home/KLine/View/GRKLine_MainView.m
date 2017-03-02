//
//  GRKLine_MainView.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRKLine_MainView.h"
#import "UIColor+GRChart.h"

#import "GR_KLine.h"
#import "GR_KBrokenLine.h"
#import "GRChartGlobalVariable.h"
#import "GRChart_KLinePositionModel.h"

@interface GRKLine_MainView ()

/**
 需要绘制的Model数组
 */
@property (nonatomic,strong) NSMutableArray <GRChart_KLineModel *> *needDrawKLineModels;

/**
 需要绘制的model位置数组
 */
@property (nonatomic,strong) NSMutableArray *needDrawKLinePositionModels;

/**
 Index开始X的值
 */
@property (nonatomic,assign) NSInteger startXPosition;

/**
 旧的contextOffset值
 */
@property (nonatomic,assign) CGFloat oldContentOffsetX;
///最大的Y值
@property (nonatomic,assign) CGFloat maxAssetY;
///最小的Y值
@property (nonatomic,assign) CGFloat minAssetY;


@end

@implementation GRKLine_MainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.needDrawKLineModels = @[].mutableCopy;
        self.needDrawKLinePositionModels = @[].mutableCopy;
        _needDrawStartIndex = 0;
        _oldContentOffsetX = 0;
    }
    return self;
}

#pragma mark ----绘制相关方法

#pragma mark drawRect方法

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    //如果数组为空，则不进行绘制，直接设置本view为背景
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!self.kLineModels) {
        CGContextClearRect(context, rect);
        CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
        CGContextFillRect(context, rect);
        return;
    }
    //设置view的背景颜色
    CGContextClearRect(context, rect);
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //设置显示日期的区域背景颜色
    CGContextSetFillColorWithColor(context, [UIColor assistBackgroundColor].CGColor);
    CGContextFillRect(context, CGRectMake(kLineLeftX, Y_StockChartKLineMainViewMaxY, self.frame.size.width-10, self.frame.size.height-Y_StockChartKLineMainViewMaxY));
    GR_KBrokenLine *brokenLine = [[GR_KBrokenLine alloc] initWithContext:context];
    
    if (self.MainViewType == Y_StockChartcenterViewTypeKline) {
        GR_KLine *kline = [[GR_KLine alloc] initWithContext:context];
        kline.maxY = Y_StockChartKLineMainViewMaxY;
        __block CGPoint lastDrawDatePoint = CGPointZero;
        [self.needDrawKLinePositionModels enumerateObjectsUsingBlock:^(GRChart_KLinePositionModel * _Nonnull klinePositionModel, NSUInteger idx, BOOL * _Nonnull stop) {
            kline.kLinePositionModel = klinePositionModel;
            kline.kLineModel = self.needDrawKLineModels[idx];
            [kline draw];

            CGPoint drawDatePoint = CGPointMake(klinePositionModel.LowPoint.x + 1, kline.maxY + 1.5);
            if (CGPointEqualToPoint(lastDrawDatePoint, CGPointZero) || drawDatePoint.x - lastDrawDatePoint.x > K_Screen_Width/2-30)  {
                [kline.kLineModel.date drawAtPoint:drawDatePoint withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11],NSForegroundColorAttributeName : [UIColor assistTextColor]}];
                lastDrawDatePoint = drawDatePoint;
            }
        }];
    }else{
        __block NSMutableArray *positions = @[].mutableCopy;
        [self.needDrawKLinePositionModels enumerateObjectsUsingBlock:^(GRChart_KLinePositionModel * _Nonnull klinePositionModel, NSUInteger idx, BOOL * _Nonnull stop) {
            klinePositionModel.OpenPoint.y < klinePositionModel.ClosePoint.y ? [UIColor increaseColor] : [UIColor decreaseColor];
            [positions addObject:[NSValue valueWithCGPoint:klinePositionModel.currentPoint]];
        }];
        brokenLine.maxAssetY = self.maxAssetY;
        brokenLine.minAssetY = self.minAssetY;
        brokenLine.MAPositions = positions;
        [brokenLine drawWithRect:rect];
    }


}

#pragma mark --- 公有方法
#pragma mark 重新设置相关数据 ，然后重绘
- (void)drawMainView
{
//    NSAssert(self.kLineModels, @"klineModels不能为空");
    if (_kLineModels.count == 0) {
        return;
    }
    
    //提取需要的klineModel
    [self private_extractNeedDrawModels];
    //转换model为坐标model
    [self private_convertToKlinePositionModelWithKLineModels];
    
    //间接调用drawRect
    [self setNeedsDisplay];
}


#pragma mark 更新MainView的宽度
- (void)updateMainViewWidth
{
    __block CGFloat kLineWidth;
    if (self.MainViewType == Y_StockChartcenterViewTypeTimeLine || self.MainViewType == Y_StockChartcenterViewTypeOther) {
        kLineWidth = K_Screen_Width;
    }else if (self.MainViewType == Y_StockChartcenterViewTypeKline)
    {
        //根据stockModels的个数和间隔和K线的宽度计算出self的宽度，并设置contentsize
        kLineWidth = self.kLineModels.count * [GRChartGlobalVariable kLineWidth] + (self.kLineModels.count + 1) * [GRChartGlobalVariable kLineGap] + 10;
        if (kLineWidth < self.parentScrollView.bounds.size.width) {
            kLineWidth = self.parentScrollView.bounds.size.width;
        }
    }
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kLineWidth));
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self layoutIfNeeded];
    });
    
    //更新scrollview的contentsize
    self.parentScrollView.contentSize = CGSizeMake(kLineWidth, self.parentScrollView.contentSize.height);
    
//    CGFloat offset = self.parentScrollView.contentSize.width - self.parentScrollView.bounds.size.width;
//    if (offset > 0) {
//        [self.parentScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
//    }else{
//        [self.parentScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//    }
}

/**
    长按的时候根据原始的x位置获得精确的x的位置
 */
- (NSArray *)getExactXPositionWithOriginXPosition:(CGFloat)originXPosition
{
    CGFloat xPositionInMainView = originXPosition;
//    GRLog(@"xPositionInMainView === %f",xPositionInMainView);
    if (self.MainViewType == Y_StockChartcenterViewTypeTimeLine || self.MainViewType == Y_StockChartcenterViewTypeOther) {
        
        NSInteger startIndex = (NSInteger)((xPositionInMainView - self.startXPosition)/[GRChartGlobalVariable kLineGapMinute]);
        NSInteger arrcount = (int)(self.needDrawKLinePositionModels.count);
        
        for (NSInteger index = startIndex > 0 ? startIndex - 1 : 0 ; index < arrcount; ++ index) {
            
        }
        
        for (NSInteger index = startIndex > 0 ? startIndex - 1 : 0 ; index < arrcount; ++ index) {
            GRChart_KLinePositionModel *klinePositionModel = self.needDrawKLinePositionModels[index];
            GRChart_KLineModel *klineModel = self.needDrawKLineModels[index];
            NSArray *ary = [NSArray arrayWithObjects:klinePositionModel,klineModel, nil];
            return ary;
        }
        NSArray *ary = [NSArray arrayWithObjects:self.needDrawKLinePositionModels.lastObject,self.needDrawKLineModels.lastObject, nil];
        return ary;
    }
    
    NSInteger startIndex = (NSInteger)((xPositionInMainView - self.startXPosition) / ([GRChartGlobalVariable kLineGap] + [GRChartGlobalVariable kLineWidth]));
    NSInteger arrcount = self.needDrawKLinePositionModels.count;
    for (NSInteger index = startIndex > 0 ? startIndex - 1 : 0; index < arrcount; ++index) {
        GRChart_KLinePositionModel *klinePositionModel = self.needDrawKLinePositionModels[index];
        CGFloat minx = klinePositionModel.HighPoint.x - ([GRChartGlobalVariable kLineGap] + [GRChartGlobalVariable kLineWidth]/2);
        CGFloat maxX = klinePositionModel.HighPoint.x + ([GRChartGlobalVariable kLineGap] + [GRChartGlobalVariable kLineWidth]/2);
        if (xPositionInMainView > minx && xPositionInMainView < maxX) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(kLineMainViewLongPressKLinePositionModel:kLineModel:)]) {
                [self.delegate kLineMainViewLongPressKLinePositionModel:self.needDrawKLinePositionModels[index] kLineModel:self.needDrawKLineModels[index]];
            }
            GRChart_KLineModel *kLineModel = self.needDrawKLineModels[index];
            NSArray *ary = [NSArray arrayWithObjects:klinePositionModel,kLineModel, nil];
//            return klinePositionModel.HighPoint.x;
            return ary;
        }
            GRChart_KLineModel *kLineModel = self.needDrawKLineModels[index];
            NSArray *ary = [NSArray arrayWithObjects:klinePositionModel,kLineModel, nil];
            //            return klinePositionModel.HighPoint.x;
            return ary;
        
    }
    
    return nil;
}





#pragma mark --私有方法

- (NSArray *)private_extractNeedDrawModels
{
    CGFloat lineGap1 = [GRChartGlobalVariable kLineGap];
    CGFloat lineWidth = [GRChartGlobalVariable kLineWidth];
    //数组个数
    CGFloat scrollViewWidth = self.parentScrollView.frame.size.width;
    NSInteger needDrawKLineCount;
    //起始位置
    NSInteger needDrawKLineStartIndex;
    
    if (self.MainViewType == Y_StockChartcenterViewTypeOther || self.MainViewType == Y_StockChartcenterViewTypeTimeLine) {
        needDrawKLineCount = self.kLineModels.count;
        needDrawKLineStartIndex = 0;
    }else{
        needDrawKLineCount = (scrollViewWidth - lineGap1) / (lineGap1 + lineWidth);
        if (self.pinchStartIndex > 0) {
            needDrawKLineStartIndex = self.pinchStartIndex;
            _needDrawStartIndex = self.pinchStartIndex;
            self.pinchStartIndex = -1;
        }else{
            needDrawKLineStartIndex = self.needDrawStartIndex;
        }
    }
    
//    GRLog(@"这是模型开始的index ------ %lu",needDrawKLineStartIndex);
    [self.needDrawKLineModels removeAllObjects];
    
    //赋值数组
    if (needDrawKLineStartIndex < self.kLineModels.count) {
        if (needDrawKLineStartIndex + needDrawKLineCount < self.kLineModels.count) {
            [self.needDrawKLineModels addObjectsFromArray:[self.kLineModels subarrayWithRange:NSMakeRange(needDrawKLineStartIndex, needDrawKLineCount)]];
        }else{
            [self.needDrawKLineModels addObjectsFromArray:[self.kLineModels subarrayWithRange:NSMakeRange(needDrawKLineStartIndex, self.kLineModels.count - needDrawKLineStartIndex)]];
        }
    }
    
    return self.needDrawKLineModels;
}

#pragma mark 将model转化为position模型
- (NSArray *)private_convertToKlinePositionModelWithKLineModels
{
    if (!self.needDrawKLineModels) {
        return nil;
    }
    
    NSArray *kLineModels = self.needDrawKLineModels;
    
    //计算最小单位
    GRChart_KLineModel *firstModel = kLineModels.firstObject;
    __block CGFloat minAssert;
    __block CGFloat maxAssert;
    if (self.MainViewType == Y_StockChartcenterViewTypeTimeLine || self.MainViewType == Y_StockChartcenterViewTypeOther) {
        minAssert = firstModel.minuteNumber.floatValue;
        maxAssert = firstModel.minuteNumber.floatValue;
    }else{
        
        minAssert = firstModel.low.floatValue;
        maxAssert = firstModel.hight.floatValue;
    }
    [kLineModels enumerateObjectsUsingBlock:^(GRChart_KLineModel * _Nonnull klineModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.MainViewType == Y_StockChartcenterViewTypeTimeLine || self.MainViewType == Y_StockChartcenterViewTypeOther) {
            if (klineModel.minuteNumber.floatValue > maxAssert) {
                maxAssert = klineModel.minuteNumber.floatValue;
            }
            if (klineModel.minuteNumber.floatValue < minAssert) {
                minAssert = klineModel.minuteNumber.floatValue;
            }
        }else
        {
            if(klineModel.hight.floatValue > maxAssert) {
                maxAssert = klineModel.hight.floatValue;
            }
            if ((klineModel.low.floatValue < minAssert)) {
                minAssert = klineModel.low.floatValue;
            }
            
        }
    }];
    
//    CGFloat midAssert =  self.stringYesterDay.floatValue;
//    CGFloat max = fabs(maxAssert-midAssert);
//    CGFloat min = fabs(midAssert - minAssert);
//    if (max > min) {
//        minAssert = midAssert - max;
//    }else{
//        maxAssert = midAssert + min;
//    }
    maxAssert *= 1.0001;
    minAssert *= 0.9991;
    
    CGFloat minY = Y_StockChartKLineMainViewMinY;
    CGFloat maxY = self.parentScrollView.frame.size.height * [GRChartGlobalVariable kLineMainViewRadio];
    
    CGFloat unitValue = (maxAssert - minAssert) / (maxY - minY);
    
    [self.needDrawKLinePositionModels removeAllObjects];
    
    NSInteger kLineModelsCount = kLineModels.count;
    GRChart_KLinePositionModel *kLinePositionModel;
    for (NSInteger idx = 0; idx < kLineModelsCount; idx ++) {
        
        //k线坐标转换
        GRChart_KLineModel *klineModel = kLineModels[idx];
        if (self.MainViewType == Y_StockChartcenterViewTypeTimeLine || self.MainViewType == Y_StockChartcenterViewTypeOther) {
            CGFloat xPosition = self.startXPosition + idx*([GRChartGlobalVariable kLineGapMinute]);
            CGFloat closePointY = ABS(maxY - (klineModel.minuteNumber.floatValue - minAssert)/unitValue);
            CGPoint minutePoint = CGPointMake(xPosition, closePointY);
            kLinePositionModel = [GRChart_KLinePositionModel modelWithCurrent:minutePoint];
            
        }else{
            CGFloat xposition = self.startXPosition + idx * ([GRChartGlobalVariable kLineWidth] +[GRChartGlobalVariable kLineGap]);
            CGPoint openPoint = CGPointMake(xposition, ABS((klineModel.open.floatValue - minAssert)/unitValue));
            CGFloat closePointY = ABS((klineModel.close.floatValue - minAssert)/unitValue);
            
            if (ABS(closePointY - openPoint.y) < Y_StockChartKLineMinWidth) {
                if (openPoint.y > closePointY) {
                    openPoint.y = closePointY + Y_StockChartKLineMinWidth;
                }else if (openPoint.y < closePointY)
                {
                    closePointY = openPoint.y + Y_StockChartKLineMinWidth;
                }else{
                    if (idx > 0) {
                        GRChart_KLineModel *preKLineModel = kLineModels[idx - 1];
                        if (klineModel.open.floatValue > preKLineModel.close.floatValue) {
                            openPoint.y = closePointY + Y_StockChartKLineMinWidth;
                        }else{
                            closePointY = openPoint.y + Y_StockChartKLineMinWidth;
                        }
                    }else if (idx + 1 < kLineModelsCount)
                    {
                        
                        //idx == 0即第一个时
                        GRChart_KLineModel *subKlineModel = kLineModels[idx + 1];
                        if (klineModel.close.floatValue < subKlineModel.open.floatValue) {
                            openPoint.y = closePointY + Y_StockChartKLineMinWidth;
                        }else{
                            closePointY = openPoint.y + Y_StockChartKLineMinWidth;
                        }
                    }
                }
            }
            
            CGPoint closePoint = CGPointMake(xposition, closePointY);
            CGPoint hightPoint = CGPointMake(xposition, ABS((klineModel.hight.floatValue - minAssert)/unitValue));
            CGPoint lowPoint = CGPointMake(xposition, ABS((klineModel.low.floatValue - minAssert)/unitValue));
            kLinePositionModel = [GRChart_KLinePositionModel modelWithOpen:openPoint close:closePoint high:hightPoint low:lowPoint];
        }
        
        [self.needDrawKLinePositionModels addObject:kLinePositionModel];
    }
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(kLineMainViewCurrentMaxPrice:minPrice:)]) {
            [self.delegate kLineMainViewCurrentMaxPrice:maxAssert minPrice:minAssert];
        }
    }
    self.maxAssetY = maxAssert;
    self.minAssetY = minAssert;
    return self.needDrawKLinePositionModels;
}

static char *observerContext = NULL;
#pragma mark 添加所有事件监听的方法
- (void)private_addAllEventListener
{
    //kvo监听scrollview的状态变化
    if (self.MainViewType == Y_StockChartcenterViewTypeOther || self.MainViewType == Y_StockChartcenterViewTypeTimeLine) {
        
    }else{
        [_parentScrollView addObserver:self forKeyPath:Y_StockChartContentOffsetKey options:NSKeyValueObservingOptionNew context:observerContext];
        
    }
    
}

#pragma mark - setter,getter方法
- (NSInteger)startXPosition
{
    NSInteger leftArrcount = self.needDrawStartIndex;
    CGFloat startXPosition;
    if (self.MainViewType == Y_StockChartcenterViewTypeOther || self.MainViewType == Y_StockChartcenterViewTypeTimeLine) {
        startXPosition = (leftArrcount + 1)* [GRChartGlobalVariable kLineGapMinute] +leftArrcount * [GRChartGlobalVariable kLineGapMinute];
    }else{
       startXPosition = (leftArrcount + 1) * [GRChartGlobalVariable kLineGap] + leftArrcount * [GRChartGlobalVariable kLineWidth] + [GRChartGlobalVariable kLineWidth]/2;
        
    }
    return startXPosition;
}

- (NSInteger)needDrawStartIndex
{
    if (self.MainViewType == Y_StockChartcenterViewTypeTimeLine || self.MainViewType == Y_StockChartcenterViewTypeOther) {
        NSString *stringDate = ((GRChart_KLineModel *)self.kLineModels.firstObject).date;
        NSString *first = [stringDate substringWithRange:NSMakeRange(12, 1)];
        switch (first.intValue) {
            case 9:
                return [GRChartGlobalVariable kLineGapMinute]*180;
                break;
            case 8:
                return [GRChartGlobalVariable kLineGapMinute]*120;
                break;
            case 7:
                return [GRChartGlobalVariable kLineGapMinute]*60;
                break;
            default:
                break;
        }
    }
    if (self.MainViewType == 0) {
        return 0;
    }
    CGFloat scrollViewOffsetX = self.parentScrollView.contentOffset.x < 0 ? 0 : self.parentScrollView.contentOffset.x;
    NSUInteger leftArrcount = ABS(scrollViewOffsetX - [GRChartGlobalVariable kLineGap]) / ([GRChartGlobalVariable kLineGap] + [GRChartGlobalVariable kLineWidth]);
    _needDrawStartIndex = leftArrcount;
    return _needDrawStartIndex;
}

- (void)setKLineModels:(NSArray *)kLineModels
{
    _kLineModels = kLineModels;
    [self updateMainViewWidth];
}

#pragma mark - 系统方法
#pragma mark 已经添加到父View的方法，设置父scrollView
- (void)didMoveToSuperview
{
    _parentScrollView = (UIScrollView *)self.superview;
    [self private_addAllEventListener];
    [super didMoveToSuperview];
}

#pragma mark kvo监听实现
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (self.MainViewType == Y_StockChartcenterViewTypeOther || self.MainViewType == Y_StockChartcenterViewTypeTimeLine) {
        
    }else{
        if ([keyPath isEqualToString:Y_StockChartContentOffsetKey]) {
            CGFloat difValue = ABS(self.parentScrollView.contentOffset.x - self.oldContentOffsetX);
            if(difValue >= [GRChartGlobalVariable kLineGap] + [GRChartGlobalVariable kLineWidth]) {
                self.oldContentOffsetX = self.parentScrollView.contentOffset.x;
                [self drawMainView];
            }
        }
    }
}

- (void)setStringYesterDay:(NSString *)stringYesterDay
{
    _stringYesterDay = stringYesterDay;
}

#pragma mark - dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 移除所有监听
- (void)removeAllObserver
{
    [_parentScrollView removeObserver:self forKeyPath:Y_StockChartContentOffsetKey context:observerContext];
}

@end
