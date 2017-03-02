//
//  GRNoHoldPositionCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/9.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRNoHoldPositionCell.h"

@interface GRNoHoldPositionCell ()

@property (nonatomic, weak) UIImageView *iconImageView;         ///头像
@property (nonatomic, weak) UILabel *nameLabel;                 ///姓名
@property (nonatomic, weak) UIButton *fellowBtn;                ///关注按钮


@end

@implementation GRNoHoldPositionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //头像
        UIImageView *icon = [[UIImageView alloc] init];
        icon.layer.masksToBounds = YES;
        icon.layer.cornerRadius = 20;
        [self.contentView addSubview:icon];
        self.iconImageView = icon;
        icon.backgroundColor = [UIColor orangeColor];
        
        //名字
        UILabel *name = [[UILabel alloc] init];
        [self.contentView addSubview:name];
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        name.font = [UIFont systemFontOfSize:15];
        self.nameLabel = name;
        name.text = @"全民小道";
        
        //按钮取消关注
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        btn.backgroundColor = [UIColor colorWithHexString:@"#f39800"];
        [btn setTitle:@"取消关注" forState:UIControlStateNormal];
        [btn setTitle:@"＋关注" forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.fellowBtn = btn;
        [btn addTarget:self action:@selector(fellowClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //线
        UIView *line = [[UIView alloc] init];
        [self.contentView addSubview:line];
        line.backgroundColor = [UIColor lightGrayColor];
        
        //当前无持仓单
        UILabel *bottom = [[UILabel alloc] init];
        bottom.text = @"当前无持仓单";
        bottom.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:bottom];
        bottom.textColor = [UIColor colorWithHexString:@"#666666"];
        bottom.font = [UIFont systemFontOfSize:15];
        
        //下部的灰色 view
        UIView *gray = [[UIView alloc] init];
        gray.backgroundColor = GRColor(240, 240, 240);
        [self.contentView addSubview:gray];
        
        //布局
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(19);
            make.top.equalTo(self.contentView).offset(5);
            make.width.height.equalTo(@40);
        }];
        
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon.mas_right).offset(10);
            make.topMargin.equalTo(icon);
        }];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(icon.mas_centerY);
            make.right.equalTo(self.contentView).offset(-13);
            make.height.equalTo(@20);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.height.equalTo(@1);
            make.top.equalTo(icon.mas_bottom).offset(5);
        }];
        
        [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(line.mas_bottom).offset(3);
        }];

        [gray mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.top.equalTo(bottom.mas_bottom);
            make.height.equalTo(@10);
        }];
        
    }
    return self;
}

#pragma mark - event response
- (void)fellowClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRNoHoldPositionCell";
    GRNoHoldPositionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRNoHoldPositionCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
