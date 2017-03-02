//
//  GRRechargeTopButtonView.h
//  GoldRush
//
//  Created by Jack on 2017/1/20.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GRRechargeTopButtonViewDelegate <NSObject>

@optional
- (void)gr_rechargeTopButtonViewDidClickBtn:(UIButton *)btn;

@end

@interface GRRechargeTopButtonView : UIView

@property (nonatomic, weak) id<GRRechargeTopButtonViewDelegate> delegate;

@end
