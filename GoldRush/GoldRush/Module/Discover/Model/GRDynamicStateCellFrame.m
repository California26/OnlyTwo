//
//  GRDynamicStateCellFrame.m
//  GoldRush
//
//  Created by Jack on 2017/1/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRDynamicStateCellFrame.h"
#import "GRDynamicStateModel.h"         ///数据模型
#import "GRReplyCommentCellFrame.h"     ///评论的 cell frame模型

@implementation GRDynamicStateCellFrame

- (void)setDynamicModel:(GRDynamicStateModel *)dynamicModel{
    _dynamicModel = dynamicModel;
    
    CGFloat margin = 10;
    //头像
    CGFloat iconW = 31;
    CGFloat iconH = 31;
    CGFloat iconX = margin;
    CGFloat iconY = margin;
    
    _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //昵称
    CGFloat nickH = [self sizeWithText:dynamicModel.name maxSize:CGSizeMake(K_Screen_Width - 20, 25) fontSize:12].height;
    CGFloat nickW = [self sizeWithText:dynamicModel.name maxSize:CGSizeMake(K_Screen_Width - 20, 25) fontSize:12].width;
    _nickFrame = CGRectMake(CGRectGetMaxX(_iconFrame) + 9, margin, nickW, nickH);
    
    //时间
    CGFloat timeW = [self sizeWithText:dynamicModel.time maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) fontSize:10].width;
    CGFloat timeH = [self sizeWithText:dynamicModel.time maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) fontSize:10].height;
    _timeFrame = CGRectMake(CGRectGetMaxX(_iconFrame) + 9, CGRectGetMaxY(_nickFrame) + 6, timeW, timeH);
    
    //手机
    CGFloat phoneW = [self sizeWithText:dynamicModel.phone maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) fontSize:8].width;
    CGFloat phoneH = [self sizeWithText:dynamicModel.phone maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) fontSize:8].height;
    _phoneFrame = CGRectMake(CGRectGetMaxX(_timeFrame) + 11, CGRectGetMaxY(_nickFrame) + 6, phoneW, phoneH);
    
    //正文描述
    CGFloat descW = [self sizeWithText:dynamicModel.msgContent maxSize:CGSizeMake(K_Screen_Width - 20, 40) fontSize:11].width;
    CGFloat descH = [self sizeWithText:dynamicModel.msgContent maxSize:CGSizeMake(K_Screen_Width - 20, 40) fontSize:11].height;
    _descFrame = CGRectMake(margin, CGRectGetMaxY(_iconFrame) + 8, descW, descH);
    
    //图片
    if (dynamicModel.picNamesArray.count == 1) {
        CGFloat imageW = K_Screen_Width - 20;
        CGFloat imageH = 100;
        CGFloat imageX = margin;
        CGFloat imageY = CGRectGetMaxY(_descFrame) + 8;
        _picture1Frame = CGRectMake(imageX, imageY, imageW, imageH);
    }else if(dynamicModel.picNamesArray.count == 2){
        CGFloat imageW = (K_Screen_Width - 20 - 5) / 2;
        CGFloat imageH = 100;
        CGFloat imageX = margin;
        CGFloat imageY = CGRectGetMaxY(_descFrame) + 8;
        _picture1Frame = CGRectMake(imageX, imageY, imageW, imageH);
        _picture2Frame = CGRectMake(imageX + imageW + 5, imageY, imageW, imageH);
    }else if (dynamicModel.picNamesArray.count == 3){
        CGFloat imageW = (K_Screen_Width - 20 - 10) / 3;
        CGFloat imageH = 100;
        CGFloat imageX = margin;
        CGFloat imageY = CGRectGetMaxY(_descFrame) + 8;
        _picture1Frame = CGRectMake(imageX, imageY, imageW, imageH);
        _picture2Frame = CGRectMake(imageX + imageW + 5, imageY, imageW, imageH);
        _picture3Frame = CGRectMake(imageX + imageW * 2 + 10, imageY, imageW, imageH);
    } else{
        _picture1Frame = CGRectZero;
        _picture2Frame = CGRectZero;
        _picture3Frame = CGRectZero;
    }
    
    //分割线
    if (dynamicModel.picNamesArray) {
        CGFloat lineW = K_Screen_Width;
        CGFloat lineH = 1;
        CGFloat lineX = 0;
        CGFloat lineY = CGRectGetMaxY(_picture1Frame) + 8;
        _lineFrame = CGRectMake(lineX, lineY, lineW, lineH);
    }else{
        CGFloat lineW = K_Screen_Width;
        CGFloat lineH = 1;
        CGFloat lineX = 0;
        CGFloat lineY = CGRectGetMaxY(_descFrame) + 8;
        _lineFrame = CGRectMake(lineX, lineY, lineW, lineH);
    }
    
    //点赞
    CGFloat likeW = 30;
    CGFloat likeH = 25;
    CGFloat likeX = K_Screen_Width - 110;
    CGFloat likeY = CGRectGetMaxY(_lineFrame) + 3;
    _likeBtnFrame = CGRectMake(likeX, likeY, likeW, likeH);
    
    //评论
    CGFloat commentW = 30;
    CGFloat commentH = 25;
    CGFloat commentX = K_Screen_Width - 55;
    CGFloat commentY = CGRectGetMaxY(_lineFrame) + 3;
    _commentBtnFrame = CGRectMake(commentX, commentY, commentW, commentH);
    
    //tableview 的高度
    CGFloat tableViewH = 0;
    
    //评论的模型
    NSArray *commentModels = dynamicModel.commentModels;
    NSMutableArray *mutableFrame = [NSMutableArray array];
    if (commentModels.count > 0) {
        for (int i = 0; i < commentModels.count; i ++) {
            GRReplyCommentCellFrame *commentFrame = [[GRReplyCommentCellFrame alloc] init];
            commentFrame.maxWidth = K_Screen_Width;
            commentFrame.commentModel = commentModels[i];
            
            tableViewH += commentFrame.rowHeight;
            
            [mutableFrame addObject:commentFrame];
        }
    }
    self.commentCellFrame = mutableFrame.copy;
    if (tableViewH > 0) {
        _tableViewFrame = CGRectMake(0, CGRectGetMaxY(_likeBtnFrame) + 10, K_Screen_Width, tableViewH);
        GRLog(@"%f",tableViewH);
        _rowHeight = CGRectGetMaxY(_tableViewFrame) + 3;
    }else{
        _rowHeight = CGRectGetMaxY(_likeBtnFrame) + 10;
    }
    
}


- (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize fontSize:(CGFloat)fontSize{
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]} context:nil].size;
}

@end
