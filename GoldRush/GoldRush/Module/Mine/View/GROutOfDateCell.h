//
//  GROutOfDateCell.h
//  GoldRush
//
//  Created by Jack on 2017/1/17.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRJJThicketsModel,GRHDThicketsModel;
@interface GROutOfDateCell : UITableViewCell

///恒大
@property (nonatomic, strong) GRHDThicketsModel *hdModel;
///吉交所
@property (nonatomic, strong) GRJJThicketsModel *jjModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
