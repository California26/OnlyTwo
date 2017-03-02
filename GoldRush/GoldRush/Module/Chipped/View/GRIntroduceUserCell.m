//
//  GRIntroduceUserCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/10.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRIntroduceUserCell.h"
#import "GRDocumentary.h"       ///数据模型

@interface GRIntroduceUserCell ()

@property (nonatomic, weak) UIImageView *iconImageView;     ///头像
@property (nonatomic, weak) UILabel *nameLabel;             ///姓名
@property (nonatomic, weak) UILabel *fellowNumLabel;        ///关注人数

@end

@implementation GRIntroduceUserCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //头像
        UIImageView *icon = [[UIImageView alloc] init];
        [self addSubview:icon];
        icon.layer.cornerRadius = 17.5;
        icon.layer.masksToBounds = YES;
        self.iconImageView = icon;
        icon.backgroundColor = mainColor;
        
        //名字
        UILabel *name = [[UILabel alloc] init];
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        name.font = [UIFont systemFontOfSize:14];
        [self addSubview:name];
        self.nameLabel = name;
        name.text = @"全民刀刀";
        
        //关注人数
        UILabel *fellowNum = [[UILabel alloc] init];
        [self addSubview:fellowNum];
        fellowNum.textColor = [UIColor colorWithHexString:@"#666666"];
        fellowNum.font = [UIFont systemFontOfSize:14];
        self.fellowNumLabel = fellowNum;
        fellowNum.text = @"关注人数2143143";
        
        //布局
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self).offset(13);
            make.top.equalTo(self).offset(5);
            make.width.height.equalTo(@35);
        }];
        
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon.mas_right).offset(5);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        [fellowNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self).offset(-13);
        }];

    }
    return self;
}

#pragma mark - setter and getter
- (void)setDocumentModel:(GRDocumentary *)documentModel{
    _documentModel = documentModel;
    
    self.iconImageView.image = [UIImage imageNamed:documentModel.header];
    self.nameLabel.text = documentModel.name;
    self.fellowNumLabel.text = documentModel.fellow;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRIntroduceUserCell";
    GRIntroduceUserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRIntroduceUserCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
