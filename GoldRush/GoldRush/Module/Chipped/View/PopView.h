//
//  PopView.h
//  PopScrollerView
//
//  Created by Jack on 2016/12/20.
//  Copyright © 2016年 Jack. All rights reserved.
//  弹出 view 提示框

#import <UIKit/UIKit.h>


@interface PopView : UIView

///点击充值按钮
@property (nonatomic, copy, nullable) void(^rechargeBlock)();


///标题
@property (nonatomic, copy, readwrite, nullable) NSString *headTitle;


- (nullable instancetype)initWithFrame:(CGRect)frame withTitle:(nullable NSString *)title;

@end
