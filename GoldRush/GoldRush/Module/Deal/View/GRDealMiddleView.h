//
//  GRDealMiddleView.h
//  GoldRush
//
//  Created by Jack on 2017/1/4.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRDealMiddleView;
@protocol GRDealMiddleViewDelegate <NSObject>

@optional
- (void)gr_dealMiddleView:(GRDealMiddleView *)view didClickSwitch:(UISwitch *)switchBtn;

@end

@interface GRDealMiddleView : UIView

///数字按钮被点击
@property (nonatomic, copy) void(^numberBlock)(NSInteger count);

///止盈
@property (nonatomic, copy) void(^stopProfit)(NSInteger count);

///止损
@property (nonatomic, copy) void(^stopLoss)(NSInteger count);

///产品类型
@property (nonatomic, copy) NSString *type;

///恒大/吉交所
@property (nonatomic, assign,getter=isHDOrJJ) BOOL HDOrJJ;

///赢家券数量
@property (nonatomic, assign) NSInteger thicketCount;

@property (nonatomic, weak) id<GRDealMiddleViewDelegate> delegate;

@end
