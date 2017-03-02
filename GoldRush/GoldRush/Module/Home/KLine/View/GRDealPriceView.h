//
//  GRDealPriceView.h
//  GoldRush
//
//  Created by Jack on 2016/12/26.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRDealPriceView : UIView
///最高
@property (nonatomic, copy) NSString *maxValue;
///最低
@property (nonatomic, copy) NSString *minValue;
///今开值
@property (nonatomic, copy) NSString *todayValue;
///左收值
@property (nonatomic, copy) NSString *yesterdayValue;
@end
