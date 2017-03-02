//
//  GRChart_LeftPriceView.h
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/16.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRChart_LeftPriceView : UIView

@property(nonatomic,assign) CGFloat maxValue;

@property(nonatomic,assign) CGFloat middleValue;

@property(nonatomic,assign) CGFloat minValue;

@property(nonatomic,copy) NSString *minLabelText;

@end
