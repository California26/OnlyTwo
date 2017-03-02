//
//  GRAnalystCommentCell.h
//  GoldRush
//
//  Created by Jack on 2017/1/9.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRAnalystComment;

@interface GRAnalystCommentCell : UITableViewCell

///数据模型
@property(nonatomic, strong) GRAnalystComment *commentModel;

///点击描述文字
@property (nonatomic, copy) void(^tapDescLabel)();


+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(GRAnalystComment *)object;

@end
