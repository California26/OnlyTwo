//
//  GRMineDealRingFansCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRMineDealRingFansCell.h"
#import "GRMineDealRingFansModel.h"         ///粉丝模型数据

@interface GRMineDealRingFansCell ()

@property (nonatomic, weak) UIImageView *iconImageView;         ///头像
@property (nonatomic, weak) UILabel *nameLabel;                 ///名字
@property (nonatomic, weak) UIButton *fellowBtn;                ///关注图片

@end

@implementation GRMineDealRingFansCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 头像
        UIImageView *icon = [[UIImageView alloc] init];
        [self.contentView addSubview:icon];
        self.iconImageView = icon;
        icon.layer.cornerRadius = 20;
        icon.layer.masksToBounds = YES;
        
        //名字
        UILabel *name = [[UILabel alloc] init];
        [self.contentView addSubview:name];
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        name.font = [UIFont systemFontOfSize:16];
        self.nameLabel = name;
        
        //关注图片
        UIButton *fellow = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:fellow];
        self.fellowBtn = fellow;
        [fellow addTarget:self action:@selector(fellowClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //布局
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView).offset(13);
            make.width.height.equalTo(@40);
        }];
        
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(icon.mas_right).offset(10);
        }];
        
        [fellow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.contentView).offset(-13);
        }];
    }
    return self;
}

#pragma mark - event response
- (void)fellowClick:(UIButton *)btn{
    if (self.fellowBlock) {
        self.fellowBlock();
    }
}

#pragma mark - setter and getter
- (void)setFansModel:(GRMineDealRingFansModel *)fansModel{
    _fansModel = fansModel;
    
    self.iconImageView.image = [UIImage imageNamed:fansModel.iconUrl];
    self.nameLabel.text = fansModel.name;
    if (fansModel.isFellow) {
        [self.fellowBtn setImage:[UIImage imageNamed:@"Discover_Mine_Fellow"] forState:UIControlStateNormal];
    }else{
        [self.fellowBtn setImage:[UIImage imageNamed:@"Discover_Mine_Add_Fellow"] forState:UIControlStateNormal];
    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRMineDealRingFansCell";
    GRMineDealRingFansCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRMineDealRingFansCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
