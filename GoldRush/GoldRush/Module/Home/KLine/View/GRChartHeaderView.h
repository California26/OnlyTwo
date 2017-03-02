//
//  GRChartHeaderView.h
//  GoldRush
//
//  Created by 徐孟林 on 2016/12/26.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChartHeaderDelegate <NSObject>

@optional
- (void)buttonChartTypeAction:(UIButton *)chartType;
- (void)buttonChartTypeImageAction;

@end

@interface GRChartHeaderView : UIView

@property (nonatomic,assign) id<ChartHeaderDelegate> delegate;

@end
