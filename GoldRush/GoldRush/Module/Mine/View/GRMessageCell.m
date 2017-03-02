//
//  GRMessageCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/17.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRMessageCell.h"
#import "GRMessageCenterModel.h"            ///消息模型

@interface GRMessageCell ()

///消息
@property (nonatomic, weak) UILabel *messageLabel;
///时间
@property (nonatomic, weak) UILabel *timeLabel;
//查看详情按钮
@property (nonatomic, weak) UIButton *detailBtn;

@end

@implementation GRMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //图片
        UIImageView *icon = [[UIImageView alloc] init];
        [self.contentView addSubview:icon];
        icon.image = [UIImage imageNamed:@"Mine_Message_Thickets"];
        
        //消息
        UILabel *message = [[UILabel alloc] init];
        [self.contentView addSubview:message];
        self.messageLabel = message;
        message.numberOfLines = 2;
        message.textColor = [UIColor colorWithHexString:@"#666666"];
        message.font = [UIFont systemFontOfSize:15];
        
        //时间
        UILabel *time = [[UILabel alloc] init];
        [self.contentView addSubview:time];
        self.timeLabel = time;
        time.textColor = [UIColor colorWithHexString:@"#666666"];
        time.font = [UIFont systemFontOfSize:13];
        
        //查看详情按钮
        UIButton *detail = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:detail];
        [detail setTitle:@"查看详情" forState:UIControlStateNormal];
        detail.titleLabel.font = [UIFont systemFontOfSize:13];
        [detail setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [detail addTarget:self action:@selector(detailClick:) forControlEvents:UIControlEventTouchUpInside];
        self.detailBtn = detail;
        
        //布局
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.equalTo(@30);
            make.height.equalTo(@20);
        }];
        
        [message mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon.mas_right).offset(15);
            make.top.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-13);
        }];
        
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(message);
            make.top.equalTo(message.mas_bottom).offset(10);
        }];
        
        [detail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(message.mas_bottom).offset(10);
            make.right.equalTo(self.contentView).offset(-13);
            make.height.equalTo(@18);
        }];
        
    }
    return self;
}

#pragma mark - event response
- (void)detailClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    
    self.messageModel.isUnFold = btn.selected;
    
    if (self.messageModel.isUnFold) {
        self.messageLabel.numberOfLines = 0;
    }else{
        self.messageLabel.numberOfLines = 2;
    }
    
    if (self.detailBlock) {
        self.detailBlock(btn.selected);
    }
}

#pragma mark - setter and getter
- (void)setMessageModel:(GRMessageCenterModel *)messageModel{
    _messageModel = messageModel;
    
    self.messageLabel.text = messageModel.message;
    self.timeLabel.text = messageModel.time;
    
    if (messageModel.isUnFold) {
        self.messageLabel.numberOfLines = 0;
        self.detailBtn.selected = YES;
    }else{
        self.messageLabel.numberOfLines = 2;
        self.detailBtn.selected = NO;
    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRMessageCell";
    GRMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRMessageCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
