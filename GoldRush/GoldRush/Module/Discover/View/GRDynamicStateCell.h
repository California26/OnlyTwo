//
//  GRDynamicStateCell.h
//  GoldRush
//
//  Created by Jack on 2017/1/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRDynamicStateCellFrame,GRDynamicStateCell,GRReplyCommentModel;

@protocol GRDynamicStateCellDelegate <NSObject>

@optional
- (void)cell:(GRDynamicStateCell *)cell didUserClicked:(NSString *)username;
- (void)cell:(GRDynamicStateCell *)cell didReplyClicked:(GRReplyCommentModel *)commentModel;

@end

@interface GRDynamicStateCell : UITableViewCell

///点赞
@property (nonatomic, copy) void(^likeBlock)();
///评论
@property (nonatomic, copy) void(^commentBlock)();

@property (nonatomic, weak) id<GRDynamicStateCellDelegate> delegate;

///数据模型
@property(nonatomic, strong) GRDynamicStateCellFrame *cellFrame;

///是否显示评论区域
@property (nonatomic, assign,getter=isShowComment) BOOL showComment;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
