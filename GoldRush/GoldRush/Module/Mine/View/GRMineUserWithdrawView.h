//
//  GRMineUserWithdrawView.h
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/11.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GRMineUserWithdrawViewDelegate <NSObject>

- (void)sureButtonAction:(UIButton *)sender;
- (void)surewithDrawMoneyAction:(UITextField *)sender;

@end

@interface GRMineUserWithdrawView : UIView

@property (nonatomic,weak)id<GRMineUserWithdrawViewDelegate> delegate;
@end
