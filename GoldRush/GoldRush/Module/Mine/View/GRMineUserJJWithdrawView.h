//
//  GRWithDrawView.h
//  GoldRush
//
//  Created by Jack on 2017/1/19.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRMineUserJJWithdrawView,GRCountDownBtn;
@protocol GRMineUserJJWithdrawViewDelegate <NSObject>

@optional
- (void)gr_withDrawView:(GRMineUserJJWithdrawView *)withDrawView didClickNextButton:(UIButton *)btn;
- (void)gr_withDrawView:(GRMineUserJJWithdrawView *)withDrawView didEndEditing:(UITextField *)textField;
- (void)gr_getCodeBtnClick:(GRCountDownBtn *)btn;

@end

@interface GRMineUserJJWithdrawView : UIView

@property (nonatomic, weak) id<GRMineUserJJWithdrawViewDelegate> delegate;

@end
