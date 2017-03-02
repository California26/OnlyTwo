//
//  GRAlterCardAlarm.h
//  GoldRush
//
//  Created by 徐孟林 on 2016/12/30.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol alarmDelegate <NSObject>

- (void)buttonAction:(UIButton *)sender changePrice:(NSString *)text lastPrice:(NSString *)lastPrice;

@end

@interface GRAlterCardAlarm : UIView

@property (nonatomic,weak) id<alarmDelegate> delegate;
@property (nonatomic,strong) NSString *stringLastPrice;
@property (nonatomic, copy) NSString *stringSetPrice;

@end
