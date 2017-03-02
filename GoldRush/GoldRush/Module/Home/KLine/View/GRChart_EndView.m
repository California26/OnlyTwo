//
//  GRChart_EndView.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/16.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRChart_EndView.h"
#import "GR_KLineView.h"
#import "GRChartGlobalVariable.h"

@interface GRChart_EndView ()<GRTimeTypeViewDelegate>
//K线图View
@property (nonatomic,strong) GR_KLineView *kLineView;
//图表类型
@property (nonatomic,assign) Y_StockChartCenterViewType currentCenterViewType;
//当前索引
@property (nonatomic,assign,readwrite) NSInteger currentIndex;

@end

@implementation GRChart_EndView

- (GR_KLineView *)kLineView
{
    if (!_kLineView) {
        _kLineView = [GR_KLineView new];
        [self addSubview:_kLineView];
        [self addSubview:_segmentView];
        _kLineView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
    return _kLineView;
}


- (GRTimeTypeView *)segmentView
{
    if (!_segmentView) {
        _segmentView = [GRTimeTypeView new];
        _segmentView.delegate = self;
        _segmentView.frame = CGRectMake(K_Screen_Width-5-60, 30, 60, 125);
    }
    return _segmentView;
}
- (void)setItemModels:(NSArray *)itemModels
{
    _itemModels = itemModels;
    if (itemModels) {
        NSMutableArray *items = [NSMutableArray array];
        for (Y_StockChartViewItemModel *item in itemModels) {
            [items addObject:item.title];
        }
        _segmentView.frame = CGRectMake(K_Screen_Width-5-60, 30, 60, items.count * 25);
        self.segmentView.items = items;
        
        Y_StockChartViewItemModel *firstModel = itemModels.firstObject;
        self.currentCenterViewType = firstModel.centerViewType;
        
    }
    if (self.dataSource) {
        self.segmentView.selectedIndex = 0;
    }
}

- (void)setDataSource:(id<GRChart_EndViewDatasource>)dataSource
{
    _dataSource = dataSource;
    if (self.itemModels) {
        self.segmentView.selectedIndex = 0;
    }
}
- (void)reloadData
{
    self.segmentView.selectedIndex = self.segmentView.selectedIndex;
}

- (void)timeTypeClickSegementButtonIndex:(NSInteger)index
{
    self.currentIndex = index;
    if (index >= 100) {
//        [self.kLineView bringSubviewToFront:self.segmentView];
//        [self.kLineView reDraw];
    }else{
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(stockDatasWithIndex:)]) {
            id stockData = [self.dataSource stockDatasWithIndex:index];
            if (!stockData) {
                return;
            }
            Y_StockChartViewItemModel *itemModel = self.itemModels[index];
            Y_StockChartCenterViewType type = itemModel.centerViewType;
            
            if (type == Y_StockChartcenterViewTypeOther) {
                
            }else{
                self.kLineView.MainViewType = type;
                self.kLineView.kLineModels = (NSArray *)stockData;
                [self.kLineView reDraw];
            }
        }
    }
}

- (void)setKLineModels:(NSArray<GRChart_KLineModel *> *)kLineModels
{
    _kLineModels = kLineModels;
    
}

- (void)setStringYesterDayData:(NSString *)stringYesterDayData
{
    _stringYesterDayData = stringYesterDayData;
    self.kLineView.stringYesterDay = stringYesterDayData;
    self.kLineView.kLineModels = self.kLineModels;
    [self.kLineView reDraw];
}
@end
/************************ItemModel类************************/
@implementation Y_StockChartViewItemModel

+ (instancetype)itemModelWithTitle:(NSString *)title type:(Y_StockChartCenterViewType)type
{
    Y_StockChartViewItemModel *itemModel = [Y_StockChartViewItemModel new];
    itemModel.title = title;
    itemModel.centerViewType = type;
    return itemModel;
}
@end
