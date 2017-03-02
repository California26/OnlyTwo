//
//  GRStopAlterView.h
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol stopAlterDelegate <NSObject>

///确定取消按钮
- (void)stopAlterButton:(UIButton *)sender;
///修改止盈止损数值时调用
- (void)getWinOrLoseNumber:(UIView *)view number:(NSInteger)number;

@end

@interface GRStopAlterView : UIView

@property (nonatomic,weak)id<stopAlterDelegate> delegate;
//盈
@property (nonatomic, copy) NSString *topLimit;
//损
@property (nonatomic, copy) NSString *bottomLimit;

@property (nonatomic, assign) NSInteger maxTop;  ///最大值

@property (nonatomic, assign) NSInteger minBottom; ///最小值



@end
