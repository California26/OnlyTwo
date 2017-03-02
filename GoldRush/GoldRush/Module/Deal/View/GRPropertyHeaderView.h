//
//  GRPropertyHeaderView.h
//  GoldRush
//
//  Created by Jack on 2016/12/30.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRPropertyHeaderView : UIView

///止盈止损点击
@property (nonatomic, copy) void(^stopBlock)();
///提醒
@property (nonatomic, copy) void(^warnBlock)();


@end
