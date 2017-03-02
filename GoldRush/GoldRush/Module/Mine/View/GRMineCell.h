//
//  GRMineCell.h
//  GoldRush
//
//  Created by Jack on 2016/12/26.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GRSettingItem;
@interface GRMineCell : UITableViewCell

///是否是消息提醒的 cell
@property (nonatomic, assign) BOOL isMessage;

///模型数据
@property(nonatomic, strong) GRSettingItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
