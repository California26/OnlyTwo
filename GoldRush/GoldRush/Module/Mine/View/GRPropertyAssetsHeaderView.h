//
//  GRPropertyHeaderView.h
//  GoldRush
//
//  Created by Jack on 2017/1/10.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRPropertyAssetsHeaderView;
@protocol GRPropertyAssetsHeaderViewDelegate <NSObject>

@optional
- (void)gr_propertyAssetsHeaderView:(GRPropertyAssetsHeaderView *)view didClickSelectedTime:(UIButton *)btn;

@end

@interface GRPropertyAssetsHeaderView : UIView

///标题
@property (nonatomic, copy) NSString *title;
@property (nonatomic, weak) id<GRPropertyAssetsHeaderViewDelegate> delegate;

///时间范围
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;

@end
