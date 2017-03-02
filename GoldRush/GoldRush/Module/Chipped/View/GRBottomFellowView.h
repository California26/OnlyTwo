//
//  GRBottomFellowView.h
//  GoldRush
//
//  Created by Jack on 2017/1/10.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRBottomFellowView : UIView

///点击关注回调
@property (nonatomic, copy) void(^fellowBlock)();


@end
