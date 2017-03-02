//
//  GRHDRegister.h
//  GoldRush
//
//  Created by Jack on 2017/1/18.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRHDRegister;
@protocol GRHDRegisterDelegate <NSObject>

@optional
///立即注册
- (void)HD_registerClick:(GRHDRegister *)registerView withRegisterBtn:(UIButton *)btn;
///密码
- (void)HD_getPasswordTextEndWithTextField:(UITextField *)field;
///协议
- (void)HD_protocolClick:(GRHDRegister *)registerView withProtocolBtn:(UIButton *)btn;

@end

@interface GRHDRegister : UIView

@property (nonatomic, weak) id<GRHDRegisterDelegate> delegate;

///图片名字
@property (nonatomic, copy) NSString *imageName;

@end
