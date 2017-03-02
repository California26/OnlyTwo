//
//  GRHDLogin.h
//  GoldRush
//
//  Created by Jack on 2017/1/18.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRHDLogin;
@protocol GRHDLoginDelegate <NSObject>

@optional
///立即登陆
- (void)HD_loginClick:(GRHDLogin *)loginView withLoginBtn:(UIButton *)btn;
///密码
- (void)HD_getPasswordTextEndWithTextField:(UITextField *)field;
///忘记密码
- (void)HD_forgetClick:(GRHDLogin *)loginView withForgetBtn:(UIButton *)btn;

@end

@interface GRHDLogin : UIView

@property (nonatomic, weak) id<GRHDLoginDelegate> delegate;

@end
