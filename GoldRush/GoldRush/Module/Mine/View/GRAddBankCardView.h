//
//  GRAddBankCardView.h
//  GoldRush
//
//  Created by Jack on 2017/1/11.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRAddBankCardView;
@protocol GRAddBankCardViewDelegate <NSObject>

@optional
- (void)gr_addBankCardView:(GRAddBankCardView *)addBankView didClickBindButton:(UIButton *)btn;
- (void)gr_addBankCardView:(GRAddBankCardView *)addBankView textFieldShouldBeginEditing:(UITextField *)textField;
- (void)gr_addBankCardView:(GRAddBankCardView *)addBankView textFieldDidEndEditing:(UITextField *)textField;

@end

@interface GRAddBankCardView : UIView

///按钮文字
@property (nonatomic, copy) NSString *buttonTittle;

///前面文字数组
@property (nonatomic, strong) NSArray *textArray;

///代理
@property (nonatomic, weak) id<GRAddBankCardViewDelegate> delegate;


@end
