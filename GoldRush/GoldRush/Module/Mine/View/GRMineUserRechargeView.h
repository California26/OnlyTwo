//
//  GRMineUserRechargeView.h
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/10.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RechargeDelegate <NSObject>

@optional
- (void)buttonMoneyTypeAction:(UIButton *)sender;

- (void)NextAction:(UIButton *)sender;

- (void)getBankCardNumberWithTextField:(UITextField *)field;

- (void)selectedWhichPayType:(UIButton *)btn;

@end

@interface GRMineUserRechargeView : UIView

@property (nonatomic, weak) id<RechargeDelegate> delegate;
@end
