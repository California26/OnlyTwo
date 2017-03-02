//
//  GRReplyCommentCell.h
//  GoldRush
//
//  Created by Jack on 2017/1/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRReplyCommentCellFrame,GRReplyCommentCell;

@protocol GRReplyCommentCellDelegate <NSObject>

@optional
- (void)cell:(GRReplyCommentCell *)cell didUserInfoClicked:(NSString *)username;

@end

@interface GRReplyCommentCell : UITableViewCell

///数据模型
@property (nonatomic, strong) GRReplyCommentCellFrame *replyModelFrame;
///代理
@property (nonatomic, weak) id<GRReplyCommentCellDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
