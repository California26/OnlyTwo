//
//  GRKLineCell.h
//  GoldRush
//
//  Created by Jack on 2016/12/23.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRKLineCell : UITableViewCell

///数据原数组
@property (nonatomic, strong) NSMutableArray *dataArray;

///按钮点击事件
@property (nonatomic, copy) void(^btnClick)(NSInteger index);


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
