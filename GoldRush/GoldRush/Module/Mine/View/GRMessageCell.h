//
//  GRMessageCell.h
//  GoldRush
//
//  Created by Jack on 2017/1/17.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRMessageCenterModel;
@interface GRMessageCell : UITableViewCell

///消息模型
@property (nonatomic, strong) GRMessageCenterModel *messageModel;

///点击查看详情
@property (nonatomic, copy) void(^detailBlock)(BOOL isUnflod);

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
