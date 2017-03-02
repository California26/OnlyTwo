//
//  GRPieProfitView.h
//  GoldRush
//
//  Created by Jack on 2017/1/7.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRPieProfitView : UIView

- (instancetype)initWithFrame:(CGRect)frame andPercent:(float)percent andColor:(UIColor *)color;

- (void)reloadViewWithPercent:(float)percent;

@end
