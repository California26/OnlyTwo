//
//  GRJJRegisterView.h
//  GoldRush
//
//  Created by Jack on 2017/2/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRJJRegisterView;
@protocol GRJJRegisterViewDelegate <NSObject>

@optional
///立即注册
- (void)JJ_registerClick:(GRJJRegisterView *)registerView withRegisterBtn:(UIButton *)btn;
///密码
- (void)JJ_getPasswordTextEndWithTextField:(UITextField *)field;
///协议
- (void)JJ_protocolClick:(GRJJRegisterView *)registerView withProtocolBtn:(UIButton *)btn;

@end

@interface GRJJRegisterView : UIView

@property (nonatomic, weak) id<GRJJRegisterViewDelegate> delegate;

@end
