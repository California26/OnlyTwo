//
//  GRDealFooterView.h
//  GoldRush
//
//  Created by Jack on 2016/12/26.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRDealFooterView : UIView

///按钮点击事件的 block
//@property (nonatomic, copy) void(^remindClick) (UIButton *btn);
@property (nonatomic, copy) void(^riseClick) (UIButton *btn);
@property (nonatomic, copy) void(^fallClick) (UIButton *btn);

@property (nonatomic,assign) BOOL isClose; ///yes  休市中 no 没有休市中



@end
