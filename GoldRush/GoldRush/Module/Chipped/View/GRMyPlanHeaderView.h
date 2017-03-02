//
//  GRMyPlanHeaderView.h
//  GoldRush
//
//  Created by Jack on 2017/1/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRMyPlanHeaderView : UIView

///标题
@property (nonatomic, copy) NSString *title;
///按钮标题
@property (nonatomic, copy) NSString *btnTitle;

///按钮点击
@property (nonatomic, copy) void(^btnClick)(NSString *str);


@end
