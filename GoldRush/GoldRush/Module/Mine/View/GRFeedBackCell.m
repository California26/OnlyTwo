//
//  GRFeedBackCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/17.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRFeedBackCell.h"

@interface GRFeedBackCell ()

///描述
@property (nonatomic, weak) UILabel *descLabel;
///时间
@property (nonatomic, weak) UILabel *timeLabel;

@end

@implementation GRFeedBackCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //问题描述
        UILabel *desc = [[UILabel alloc] init];
        [self.contentView addSubview:desc];
        desc.textColor = [UIColor colorWithHexString:@"#666666"];
        desc.font = [UIFont systemFontOfSize:15];
        desc.numberOfLines = 0;
        self.descLabel = desc;
        
        //时间
        UILabel *time = [[UILabel alloc] init];
        [self.contentView addSubview:time];
        time.textColor = [UIColor colorWithHexString:@"#999999"];
        time.font = [UIFont systemFontOfSize:13];
        self.timeLabel = time;
        
        //布局
        [desc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.top.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(13);
        }];
        
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView).offset(-10);
            make.right.equalTo(self.contentView).offset(13);
        }];
        
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRFeedBackCell";
    GRFeedBackCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRFeedBackCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
