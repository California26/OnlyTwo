//
//  GRChart_EndView.h
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/16.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLineConstant.h"
#import "GRTimeTypeView.h"

@class GRChart_KLineModel;
//种类
typedef NS_ENUM(NSInteger, Y_KLineType) {
    KLineTypeTimeShare = 1,
    KLineType1Min,
    KLineType3MIn,
    KLineType5Min,
    KLineType10Min,
    KLineType15Min,
    KLineType30Min,
    KLineType1Hour,
    KLineType2Hour,
    KLineType4Hour,
    KLineType6Hour,
    KLineType12Hour,
    KLineType1Day,
    KLineType3Day,
    KLineType1Week
};

@protocol GRChart_EndViewDelegate <NSObject>

@end

@protocol GRChart_EndViewDatasource <NSObject>

- (id)stockDatasWithIndex:(NSInteger)index;

@end

@interface GRChart_EndView : UIView

@property (nonatomic,strong) NSArray *itemModels;
//数据源
@property (nonatomic,weak) id<GRChart_EndViewDatasource> dataSource;
//当前选中的索引
@property (nonatomic,assign,readonly) Y_KLineType currentLineType;

@property (nonatomic,strong) GRTimeTypeView *segmentView;

@property (nonatomic,strong) NSString *stringYesterDayData;///  昨日收盘价

//数据
@property (nonatomic, copy) NSArray <GRChart_KLineModel *> *kLineModels;

- (void)reloadData;

/************************ItemModel类************************/
@end
@interface Y_StockChartViewItemModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) Y_StockChartCenterViewType centerViewType;

+ (instancetype)itemModelWithTitle:(NSString *)title type:(Y_StockChartCenterViewType)type;
@end
