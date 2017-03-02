//
//  GRHotEventsCell.h
//  GoldRush
//
//  Created by Jack on 2017/1/12.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRHotEvents;
@interface GRHotEventsCell : UITableViewCell

///模型数据
@property(nonatomic, strong) GRHotEvents *hotEvent;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
