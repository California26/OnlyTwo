//
//  GRDiscoverMiddleCell.h
//  GoldRush
//
//  Created by Jack on 2017/1/12.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRDiscover;
@interface GRDiscoverMiddleCell : UITableViewCell

///数据模型
@property(nonatomic, strong) GRDiscover *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
