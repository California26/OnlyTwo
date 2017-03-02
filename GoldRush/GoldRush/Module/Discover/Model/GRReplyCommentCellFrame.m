//
//  GRReplyCommentCellFrame.m
//  GoldRush
//
//  Created by Jack on 2017/1/16.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRReplyCommentCellFrame.h"
#import "GRReplyCommentModel.h"

@implementation GRReplyCommentCellFrame

- (void)setCommentModel:(GRReplyCommentModel *)commentModel{
    _commentModel = commentModel;
    
    CGFloat margin = 13;
    
    //头像
    CGFloat iconW = 40;
    CGFloat iconH = 40;
    CGFloat iconX = 10;
    CGFloat iconY = 8;
    
    _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //昵称
    CGFloat nickH = [self sizeWithText:commentModel.fromName maxSize:CGSizeMake(K_Screen_Width - 20, 25) fontSize:15].height;
    CGFloat nickW = [self sizeWithText:commentModel.fromName maxSize:CGSizeMake(K_Screen_Width - 20, 25) fontSize:15].width;
    _nickFrame = CGRectMake(CGRectGetMaxX(_iconFrame) + 9, 22, nickW, nickH);
    
    //时间
    CGFloat timeW = [self sizeWithText:commentModel.time maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) fontSize:13].width;
    CGFloat timeH = [self sizeWithText:commentModel.time maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) fontSize:13].height;
    _timeFrame = CGRectMake(K_Screen_Width - timeW - 10, 22, timeW, timeH);
    
    CGFloat contentLabelX = margin;
    CGFloat contentLabelY = CGRectGetMaxY(_iconFrame) + 8;
    CGFloat contentLabelW = self.maxWidth - 2 * margin;
    CGFloat contentLabelH = 0;
    
    
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.lineSpacing = 2;
    NSDictionary *attr = @{
                           NSParagraphStyleAttributeName: para,
                           NSFontAttributeName: [UIFont systemFontOfSize:14],
                           NSForegroundColorAttributeName: [UIColor colorWithRed:46/256.0 green:46/256.0 blue:46/256.0 alpha:1]
                           };
    
    self.contentAttributeString = [[NSAttributedString alloc] initWithString:commentModel.all attributes:attr];
    contentLabelH = [self.contentAttributeString boundingRectWithSize:CGSizeMake(contentLabelW, MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    
    self.commentFrame = CGRectMake(contentLabelX, contentLabelY, contentLabelW, contentLabelH);
    
    self.rowHeight = CGRectGetMaxY(self.commentFrame) + 2;
}

- (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize fontSize:(CGFloat)fontSize{
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]} context:nil].size;
}

@end
