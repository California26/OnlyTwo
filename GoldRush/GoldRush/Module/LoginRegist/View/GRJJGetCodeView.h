//
//  GRJJGetCodeView.h
//  GoldRush
//
//  Created by Jack on 2017/2/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRJJGetCodeView;
@protocol GRJJGetCodeViewDelegate <NSObject>

@optional
///获取验证码
- (void)JJ_getCodeClick:(GRJJGetCodeView *)registerView withGetCodeBtn:(UIButton *)btn;
///验证码
- (void)JJ_getCode:(GRJJGetCodeView *)view withTextField:(UITextField *)field;
///改变验证码
//- (void)JJ_changeBtnClick:(GRJJGetCodeView *)registerView withChangeBtnBtn:(UIButton *)btn;

@end

@interface GRJJGetCodeView : UIView

@property (nonatomic, weak) id<GRJJGetCodeViewDelegate> delegate;

///按钮文字
@property (nonatomic, copy) NSString *buttonTitle;

@end
