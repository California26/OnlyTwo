//
//  GRHotEventsCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/12.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRHotEventsCell.h"
#import "GRHotEvents.h"              ///模型数据

@interface GRHotEventsCell ()

@property (nonatomic, weak) UIImageView *iconImageView;             ///图片
@property (nonatomic, weak) UILabel *titleLabel;                    ///活动标题
@property (nonatomic, weak) UILabel *eventTimeLabel;                ///活动时间
@property (nonatomic, weak) UIButton *statusButton;                   ///活动状态

@end

@implementation GRHotEventsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //活动图片
        UIImageView *icon = [[UIImageView alloc] init];
        [self.contentView addSubview:icon];
        self.iconImageView = icon;
        icon.contentMode = UIViewContentModeScaleToFill;
        icon.clipsToBounds = YES;
        
        //背景 view
        UIView *view = [[UIView alloc] init];
        [self.contentView addSubview:view];
        view.backgroundColor = [UIColor colorWithHexString:@"#eff0f1"];
        
        //标题
        UILabel *text = [[UILabel alloc] init];
        [view addSubview:text];
        self.titleLabel = text;
        text.textColor = [UIColor colorWithHexString:@"#333333"];
        text.font = [UIFont systemFontOfSize:14];
        
        //活动时间
        UILabel *time = [[UILabel alloc] init];
        [view addSubview:time];
        self.eventTimeLabel = time;
        time.textColor = [UIColor colorWithHexString:@"#666666"];
        time.font = [UIFont systemFontOfSize:11];
        
        //活动状态
        UIButton *status = [UIButton buttonWithType:UIButtonTypeCustom];
        [view addSubview:status];
        self.statusButton = status;
        [status setTitle:@"进行中" forState:UIControlStateNormal];
        status.titleLabel.font = [UIFont systemFontOfSize:12];
        [status setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        status.backgroundColor = [UIColor colorWithHexString:@"#f39800"];
        status.layer.masksToBounds = YES;
        status.layer.cornerRadius = 6;
        
        //布局
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.right.equalTo(self.contentView).offset(-13);
            make.top.equalTo(self.contentView).offset(10);
            make.height.equalTo(@87);
        }];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.top.equalTo(icon.mas_bottom);
            make.width.equalTo(@(K_Screen_Width - 26));
            make.height.equalTo(@50);
        }];
        
        [text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left).offset(13);
            make.top.equalTo(view.mas_top).offset(10);
        }];
        
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(text);
            make.top.equalTo(text.mas_bottom).offset(6);
        }];
        
        [status mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view.mas_right);
            make.centerY.equalTo(view.mas_centerY);
            make.width.equalTo(@50);
            make.height.equalTo(@20);
        }];
        
    }
    return self;
}

#pragma mark - setter and getter
- (void)setHotEvent:(GRHotEvents *)hotEvent{
    _hotEvent = hotEvent;
    
    self.iconImageView.image = [UIImage imageNamed:hotEvent.imageUrl];
    self.titleLabel.text = hotEvent.title;
    self.eventTimeLabel.text = hotEvent.time;
    [self.statusButton setTitle:hotEvent.status forState:UIControlStateNormal];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRHotEventsCell";
    GRHotEventsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRHotEventsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
