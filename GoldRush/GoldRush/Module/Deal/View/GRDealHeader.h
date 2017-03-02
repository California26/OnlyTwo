//
//  GRDealHeader.h
//  GoldRush
//
//  Created by Jack on 2017/1/4.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRDealHeader;
@protocol GRDealHeaderDelegate <NSObject>

@optional
- (void)gr_dealHeaderView:(GRDealHeader *)view didProductBtn:(UIButton *)btn;

@end

@interface GRDealHeader : UIView

///
@property (nonatomic, weak) id<GRDealHeaderDelegate> delegate;

///涨/跌
@property (nonatomic, assign) BOOL isRise;
///是否显示用券信息
@property (nonatomic, assign) BOOL isUseTicket;

///产品数组
@property (nonatomic, strong) NSMutableArray *productArray;

///产品名称
@property (nonatomic, copy) NSString *productName;
///产品价格
@property (nonatomic, copy) NSString *productPrice;

///默认选中第一个按钮
@property (nonatomic, copy) NSString *defaultSelected;

@end
