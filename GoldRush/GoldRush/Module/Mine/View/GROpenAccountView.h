//
//  GROpenAccountView.h
//  GoldRush
//
//  Created by Jack on 2016/12/26.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GROpenAccountView : UIView

///点击开户按钮
@property (nonatomic, copy) void(^openBlock)(NSString *type);
///当前是哪个交易所
@property (nonatomic, copy) NSString *type;
///点击登陆按钮
@property (nonatomic, copy) void(^loginBlock)(NSString *type);

///是否显示按钮
@property (nonatomic, assign, getter=isShowBtn) BOOL showBtn;

///是否开户成功
@property (nonatomic,assign) BOOL isSucceedRegister;


@end
