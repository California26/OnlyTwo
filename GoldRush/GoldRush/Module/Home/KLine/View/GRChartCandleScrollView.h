//
//  GRChartCandleScrollView.h
//  GoldRush
//
//  Created by 徐孟林 on 2016/12/27.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRChartCandleScrollView : UIScrollView

@property (nonatomic,strong) NSArray *pointLineAry;
@property (nonatomic,strong) NSArray *pointRangleAry;
//@property (nonatomic)CGPoint pointline;
//@property (nonatomic)CGPoint pointRangle;
@property (nonatomic)BOOL isRiseOrDrop; //yes 为涨。no 为跌
@property (nonatomic)int heightLine;
@property (nonatomic)int heightRangle;
@property (nonatomic)double scale;//扩大或者缩小多少倍
@property (nonatomic,strong) NSArray *heightLineAry;
@property (nonatomic,strong) NSArray *heightRangleAry;
@property (nonatomic,strong) NSArray *aryBool;

@property (nonatomic,strong) NSDictionary *dicSource;


@end
