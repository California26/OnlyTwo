//
//  GRRechargeHeaderView.h
//  GoldRush
//
//  Created by Jack on 2017/2/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRRechargeHeaderView;
@protocol GRRechargeHeaderViewDelegate <NSObject>

@optional
- (void)gr_rechargeHeaderView:(GRRechargeHeaderView *)headerView didSelectMoneyBtn:(UIButton *)btn;

@end

@interface GRRechargeHeaderView : UIView

@property (nonatomic, weak) id<GRRechargeHeaderViewDelegate> delegate;

@end
