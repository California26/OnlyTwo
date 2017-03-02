//
//  GRProProductDetailTableViewCell.h
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/18.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRPropertyDealDetail.h"
#import "GRJJHoldPositionModel.h"
@protocol GRProProductDetailTableViewCellDelegate <NSObject>

- (void)proProductDetailTableViewCellButtonAction:(NSInteger)sender;
- (void)proProductDetailTableViewCellButtonStopAction:(NSInteger)sender;

@end

@interface GRProProductDetailTableViewCell : UITableViewCell

@property (nonatomic,assign) id<GRProProductDetailTableViewCellDelegate> delegate;

@property (nonatomic,strong) GRPropertyDealDetail *positionModel;

@property (nonatomic,strong) GRJJHoldPositionModel *positionModelJJ;

+ (instancetype)cellWithTableView:(UITableView *)tableView;



@end
