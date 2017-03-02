//
//  GRTabbar.h
//  GoldRush
//
//  Created by Jack on 2017/1/20.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRTabbar;

@protocol GRTabbarDelegate <NSObject>

@optional
- (void)gr_didClickDealBtn:(GRTabbar *)tabbar;

@end

@interface GRTabbar : UITabBar

///按钮点击代理
@property (nonatomic, weak) id<GRTabbarDelegate> tabbarDelegate;

@end
