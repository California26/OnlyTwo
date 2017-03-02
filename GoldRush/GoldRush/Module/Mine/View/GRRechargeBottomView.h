//
//  GRRechargeBottomView.h
//  GoldRush
//
//  Created by Jack on 2017/1/20.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRRechargeBottomView;
@protocol GRRechargeBottomViewDelegate <NSObject>

@optional
- (void)gr_rechargeBottomView:(GRRechargeBottomView *)view didClickAddBankButton:(UIButton *)btn;
- (void)gr_rechargeBottomView:(GRRechargeBottomView *)view didClickNextButton:(UIButton *)btn;

@end

@interface GRRechargeBottomView : UIView

///按钮上的文字(充值/提现)
@property (nonatomic, copy) NSString *buttonType;

@property (nonatomic, weak) id<GRRechargeBottomViewDelegate> delegate;

@end
