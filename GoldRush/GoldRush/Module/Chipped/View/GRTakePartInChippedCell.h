//
//  GRTakePartInChippedCell.h
//  GoldRush
//
//  Created by Jack on 2017/1/7.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRTakePartInChippedCell : UITableViewCell

///点击事件
@property (nonatomic, copy) void(^participateBlock)();


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
