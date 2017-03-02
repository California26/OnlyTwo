//
//  GRTheNewestOpinionCell.h
//  GoldRush
//
//  Created by Jack on 2017/1/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRTheNewestOpinionFrame,GRTheNewestOpinion;
@interface GRTheNewestOpinionCell : UITableViewCell

///frame 模型
@property(nonatomic, strong) GRTheNewestOpinionFrame *opinionFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

///是否显示箭头
@property (nonatomic, assign) BOOL isShowArrow;

///点赞
@property (nonatomic, copy) void(^likeBlock)();
///评论
@property (nonatomic, copy) void(^commentBlock)();


+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(GRTheNewestOpinion *)object;

@end
