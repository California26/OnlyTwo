//
//  GRPriceView.h
//  GoldRush
//
//  Created by Jack on 2016/12/28.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRPriceView : UIView

///价钱
@property (nonatomic, copy) NSString *price;
///是涨或跌
@property (nonatomic, assign) BOOL isRise;

@end
