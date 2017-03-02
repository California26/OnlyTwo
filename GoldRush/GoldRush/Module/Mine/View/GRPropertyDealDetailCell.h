//
//  GRPropertyDealDetailCell.h
//  GoldRush
//
//  Created by Jack on 2017/1/10.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRPropertyDealDetailCell, GRPropertyDealDetail,GRJJPropertyDealDetail;
@protocol GRPropertyDealDetailCellDelegate <NSObject>

@optional
- (void)propertyDealDetailCell:(GRPropertyDealDetailCell *)cell didClickUnfoldBtn:(BOOL)unfold;

@end

@interface GRPropertyDealDetailCell : UITableViewCell

///箭头点击展开
@property (nonatomic, copy) void(^arrowBlock)(BOOL isUnfold);
///代理
@property (nonatomic, weak) id<GRPropertyDealDetailCellDelegate> delegate;

///数据模型
@property(nonatomic, strong) GRPropertyDealDetail *dealDetailModel;
@property (nonatomic, strong) GRJJPropertyDealDetail *JJDetailModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
