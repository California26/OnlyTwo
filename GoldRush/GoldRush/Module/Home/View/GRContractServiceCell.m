//
//  GRContractServiceCell.m
//  GoldRush
//
//  Created by Jack on 2017/3/1.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRContractServiceCell.h"
#import "UILabel+GRCopy.h"

@interface GRContractServiceCell ()

///头像
@property (nonatomic, weak) UIImageView *iconView;
///标题
@property (nonatomic, weak) UILabel *titleLabel;
///描述
@property (nonatomic, weak) UILabel *descLabel;

///
@property (nonatomic, weak) UIView *background;

@end

@implementation GRContractServiceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *view = [[UIView alloc] init];
        [self.contentView addSubview:view];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 8;
        self.background = view;
        view.backgroundColor = [UIColor whiteColor];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@13);
            make.top.bottom.equalTo(self.contentView);
            make.right.equalTo(@(-13));
        }];
        
        UIImageView *icon = [[UIImageView alloc] init];
        [view addSubview:icon];
        icon.layer.masksToBounds = YES;
        icon.layer.cornerRadius = 5;
        self.iconView = icon;
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left).offset(10);
            make.centerY.equalTo(view.mas_centerY);
            make.top.equalTo(view).offset(10);
            make.bottom.equalTo(view.mas_bottom).offset(-10);
            make.width.equalTo(@45);
        }];
        
        UILabel *title = [[UILabel alloc] init];
        title.font = [UIFont systemFontOfSize:15];
        [view addSubview:title];
        title.isCopyable = YES;
        self.titleLabel = title;
        title.textColor = [UIColor colorWithHexString:@"#333333"];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon.mas_right).offset(20);
            make.centerY.equalTo(view.mas_centerY);
        }];
        
        UILabel *desc = [[UILabel alloc] init];
        [view addSubview:desc];
        desc.textColor = [UIColor colorWithHexString:@"#999999"];
        desc.font = [UIFont systemFontOfSize:13];
        self.descLabel = desc;
    }
    return self;
}

- (void)setDataDict:(NSDictionary *)dataDict{
    _dataDict = dataDict;
    
    self.iconView.image = [UIImage imageNamed:dataDict[@"icon"]];
    self.titleLabel.text = dataDict[@"title"];
    if (dataDict[@"desc"]) {
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.background.mas_centerY).offset(-13);
        }];
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(self.titleLabel.mas_leftMargin);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        }];
        self.descLabel.text = dataDict[@"desc"];
    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRContractServiceCell";
    GRContractServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRContractServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

@end
