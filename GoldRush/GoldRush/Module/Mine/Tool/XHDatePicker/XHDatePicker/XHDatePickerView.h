//
//  XHDatePickerView.h
//  GoldRush
//
//  Created by Jack on 2017/2/18.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    DateStyleShowYearMonthDayHourMinute  = 0,
    DateStyleShowMonthDayHourMinute,
    DateStyleShowYearMonthDay,
    DateStyleShowMonthDay,
    DateStyleShowHourMinute
    
}XHDateStyle;

typedef enum{
    DateTypeStartDate,
    DateTypeEndDate
    
}XHDateType;

@interface XHDatePickerView : UIView

@property (nonatomic,assign)XHDateStyle datePickerStyle;
@property (nonatomic,assign)XHDateType dateType;
@property (nonatomic,strong)UIColor *themeColor;

@property (nonatomic, retain) NSDate *maxLimitDate;//限制最大时间（没有设置默认2049）
@property (nonatomic, retain) NSDate *minLimitDate;//限制最小时间（没有设置默认1970）

-(instancetype)initWithCompleteBlock:(void(^)(NSDate *,NSDate *))completeBlock;

-(void)show;


@end
