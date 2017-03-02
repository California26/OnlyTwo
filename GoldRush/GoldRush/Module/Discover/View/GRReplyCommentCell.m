//
//  GRReplyCommentCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRReplyCommentCell.h"
#import "GRAttributedLabel.h"       ///属性 label
#import "GRReplyCommentModel.h"     ///评论模型
#import "GRReplyCommentCellFrame.h" ///评论的 frame 模型

@interface GRReplyCommentCell ()

@property (nonatomic, weak) UIImageView *iconImageView;                 ///头像
@property (nonatomic, weak) UILabel *nameLabel;                         ///名字
@property (nonatomic, weak) GRAttributedLabel *commentDetailLabel;      ///评论详情
@property (nonatomic, weak) UILabel *timeLabel;                         ///时间

@end

@implementation GRReplyCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //头像
        UIImageView *icon = [[UIImageView alloc] init];
        [self.contentView addSubview:icon];
        self.iconImageView = icon;
        icon.backgroundColor = [UIColor orangeColor];
        icon.layer.masksToBounds = YES;
        icon.layer.cornerRadius = 20;
        
        //名字
        UILabel *name = [[UILabel alloc] init];
        [self.contentView addSubview:name];
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        name.font = [UIFont systemFontOfSize:15];
        self.nameLabel = name;
        
        //评论详情
        GRAttributedLabel *desc = [[GRAttributedLabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:desc];
        desc.textColor = [UIColor colorWithHexString:@"#333333"];
        desc.font = [UIFont systemFontOfSize:15];
        desc.numberOfLines = 0;
        desc.backgroundColor = [UIColor colorWithHexString:@"eff0f2"];
        desc.linkAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:0/256.0 green:87/256.0 blue:168/256.0 alpha:1]};
        desc.activeLinkAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:140/256.0 green:87/256.0 blue:168/256.0 alpha:1]};
        self.commentDetailLabel = desc;
        
        //时间
        UILabel *time = [[UILabel alloc] init];
        [self.contentView addSubview:time];
        time.textColor = [UIColor colorWithHexString:@"#999999"];
        time.font = [UIFont systemFontOfSize:13];
        self.timeLabel = time;
        
        //布局
//        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.contentView).offset(13);
//            make.top.equalTo(self.contentView).offset(10);
//            make.width.height.equalTo(@40);
//        }];
//        
//        [name mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(icon.mas_centerY);
//            make.left.equalTo(icon.mas_right).offset(13);
//        }];
//        
//        [desc mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.contentView).offset(13);
//            make.top.equalTo(icon.mas_bottom).offset(8);
//            make.right.equalTo(self.contentView).offset(-13);
//        }];
//        
//        [time mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(icon.mas_centerY);
//            make.right.equalTo(self.contentView).offset(-13);
//        }];
        
    }
    return self;
}

#pragma mark - setter and getter
- (void)setReplyModelFrame:(GRReplyCommentCellFrame *)replyModelFrame{
    _replyModelFrame = replyModelFrame;
    
    self.commentDetailLabel.frame = replyModelFrame.commentFrame;
    self.iconImageView.frame = replyModelFrame.iconFrame;
    self.nameLabel.frame = replyModelFrame.nickFrame;
    self.timeLabel.frame = replyModelFrame.timeFrame;
    
    self.iconImageView.image = [UIImage imageNamed:replyModelFrame.commentModel.iconName];
    self.nameLabel.text = replyModelFrame.commentModel.fromName;
    self.timeLabel.text = replyModelFrame.commentModel.time;
    
    self.commentDetailLabel.text = replyModelFrame.contentAttributeString;
    
    GRAttributedLabelLink *fromLink = [self.commentDetailLabel addLinkToPhoneNumber:replyModelFrame.commentModel.fromName withRange:NSMakeRange(0, replyModelFrame.commentModel.fromName.length)];
    
    fromLink.linkTapBlock = ^(GRAttributedLabel *label, GRAttributedLabelLink *link){
        if (self.delegate && [self.delegate respondsToSelector:@selector(cell:didUserInfoClicked:)]) {
            [self.delegate cell:self didUserInfoClicked:replyModelFrame.commentModel.fromName];
        }
    };
    
    if (replyModelFrame.commentModel.toName.length > 0) {
        GRAttributedLabelLink *toLink = [self.commentDetailLabel addLinkToPhoneNumber:replyModelFrame.commentModel.fromName
                                                                       withRange:NSMakeRange(replyModelFrame.commentModel.fromName.length + 2, replyModelFrame.commentModel.toName.length)];
        
        toLink.linkTapBlock = ^(GRAttributedLabel *label, GRAttributedLabelLink *link){
            if (self.delegate && [self.delegate respondsToSelector:@selector(cell:didUserInfoClicked:)]) {
                [self.delegate cell:self didUserInfoClicked:replyModelFrame.commentModel.toName];
            }
        };
    }
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(GRReplyCommentModel *)object{
    CGFloat statusLabelWidth = [UIScreen mainScreen].bounds.size.width - 26;
    //字符串分类提供方法，计算字符串的高度
    //  ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
    CGRect statusLabelRect = [object.desc sizeWithLabelWidth:statusLabelWidth font:[UIFont systemFontOfSize:11]];
    return CGRectGetMaxY(statusLabelRect) + 62;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRReplyCommentCell";
    GRReplyCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRReplyCommentCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
