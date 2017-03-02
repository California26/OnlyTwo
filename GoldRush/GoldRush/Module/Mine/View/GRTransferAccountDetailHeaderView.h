//
//  GRTransferAccountDetailHeaderView.h
//  GoldRush
//
//  Created by Jack on 2017/2/18.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GRTransferAccountDetailHeaderViewDelegate <NSObject>

@optional
- (void)gr_transferAccountDetailTimeSelectedClick;


@end

@interface GRTransferAccountDetailHeaderView : UIView

///
@property (nonatomic, weak) id<GRTransferAccountDetailHeaderViewDelegate> delegate;

///时间范围
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;

@end
