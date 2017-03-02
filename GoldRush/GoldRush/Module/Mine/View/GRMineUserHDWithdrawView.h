//
//  GRMineUserWithdrawView.h
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/11.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRCountDownBtn;
@protocol GRMineUserHDWithdrawViewDelegate <NSObject>

@optional
- (void)gr_sureButtonAction:(UIButton *)sender;
- (void)gr_surewithDrawMoneyAction:(UITextField *)sender;
- (void)gr_getCodeClick:(GRCountDownBtn *)btn;

@end

@interface GRMineUserHDWithdrawView : UIView

@property (nonatomic,weak)id<GRMineUserHDWithdrawViewDelegate> delegate;

@property (nonatomic, copy) NSString *bank;

@end
