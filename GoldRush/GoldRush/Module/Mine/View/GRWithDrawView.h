//
//  GRWithDrawView.h
//  GoldRush
//
//  Created by Jack on 2017/1/19.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRWithDrawView;
@protocol GRWithDrawViewDelegate <NSObject>

@optional
- (void)gr_withDrawView:(GRWithDrawView *)withDrawView didClickNextButton:(UIButton *)btn;
- (void)gr_withDrawView:(GRWithDrawView *)withDrawView didEndEditing:(UITextField *)textField;
- (void)gr_withDrawView:(GRWithDrawView *)withDrawView didBeginEditing:(UITextField *)textField;

@end

@interface GRWithDrawView : UIView

@property (nonatomic, weak) id<GRWithDrawViewDelegate> delegate;

@end
