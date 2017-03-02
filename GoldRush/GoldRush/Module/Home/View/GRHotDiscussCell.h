//
//  GRHotDiscussCell.h
//  GoldRush
//
//  Created by Jack on 2016/12/24.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRDiscusscellFrame;
@interface GRHotDiscussCell : UITableViewCell

///记录当前那个 cell 被点击
//@property (nonatomic, strong) NSIndexPath *indexPath;

///点赞
@property (nonatomic, copy) void(^likeBlock)();
///评论
@property (nonatomic, copy) void(^commentBlock)();
///模型数据
@property(nonatomic, strong) GRDiscusscellFrame *discussFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
