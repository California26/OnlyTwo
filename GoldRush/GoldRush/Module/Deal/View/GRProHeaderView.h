//
//  GRProHeaderView.h
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/3.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol proHeaderDelegate <NSObject>

@optional
- (void)rechargeAction;
- (void)warnAction;

@end

@interface GRProHeaderView : UIView

@property (nonatomic,weak) id<proHeaderDelegate> delegate;
@property (nonatomic,assign) double money;
@property (nonatomic,assign) NSInteger  count;
@end
