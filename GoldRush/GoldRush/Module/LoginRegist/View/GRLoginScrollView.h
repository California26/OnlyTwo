//
//  GRLoginScrollView.h
//  GoldRush
//
//  Created by 徐孟林 on 2016/12/20.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginDelegate <NSObject>

- (void)loginEndChangeWithTextField:(UITextField *)textField;
- (void)loginGetCodeAction:(UIButton *)sender;
- (void)loginSureActionWith:(UIButton *)sender;
- (void)loginWithProtocol;
- (void)loginAgreeAction:(UIButton *)sender;

@end

@interface GRLoginScrollView : UIScrollView

@property (nonatomic,weak) id<LoginDelegate> loginDelegate;
///是否在获取验证码
@property (nonatomic, assign) BOOL isTime;

@end
