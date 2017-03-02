//
//  GRRechargeFooterView.h
//  GoldRush
//
//  Created by Jack on 2017/2/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GRRechargeFooterViewDelegate <NSObject>

@required
- (void)gr_rechargeFooterViewDidNextClickBtn:(UIButton *)btn;

@end

@interface GRRechargeFooterView : UIView

@property (nonatomic, weak) id<GRRechargeFooterViewDelegate> delegate;

@end
