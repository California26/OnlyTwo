//
//  GRReplyCommentCellFrame.h
//  GoldRush
//
//  Created by Jack on 2017/1/16.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GRReplyCommentModel;
@interface GRReplyCommentCellFrame : NSObject

///评论模型
@property (nonatomic, strong) GRReplyCommentModel *commentModel;
///头像
@property (nonatomic, assign, readonly) CGRect iconFrame;
///名字
@property (nonatomic, assign, readonly) CGRect nickFrame;
///时间
@property (nonatomic, assign, readonly) CGRect timeFrame;

///评论内容的 frame
@property (nonatomic, assign) CGRect commentFrame;

///cell 的行高
@property (nonatomic, assign) CGFloat rowHeight;

///属性字符串显示用户
@property (nonatomic, copy) NSAttributedString *contentAttributeString;

///显示区域的最大宽度
@property (nonatomic, assign) CGFloat maxWidth;

@end
