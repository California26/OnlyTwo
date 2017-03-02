//
//  GRPropertyHoldPositionDetailNoDataCell.h
//  GoldRush
//
//  Created by Jack on 2017/2/4.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRPropertyHoldPositionDetailNoDataCell;
@protocol GRPropertyHoldPositionDetailNoDataCellDelegate <NSObject>

@optional
- (void)propertyHoldPositionDetailNoDataCell:(GRPropertyHoldPositionDetailNoDataCell *)cell didClickDealBtn:(UIButton *)btn;

@end

@interface GRPropertyHoldPositionDetailNoDataCell : UITableViewCell

@property (nonatomic, weak) id<GRPropertyHoldPositionDetailNoDataCellDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
