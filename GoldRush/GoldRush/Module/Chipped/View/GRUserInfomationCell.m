//
//  GRUserInfomationCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/7.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRUserInfomationCell.h"
#import "GRPieProfitView.h"
#import "GRDocumentary.h"

@interface GRUserInfomationCell ()

@property (nonatomic, weak) UILabel *nameLabel;         ///按钮
@property (nonatomic, weak) UILabel *numberLabel;       ///合买人数
@property (nonatomic, weak) UILabel *profitLabel;       ///盈利人数
@property (nonatomic, weak) UILabel *nickLabel;         ///昵称
@property (nonatomic, weak) UIImageView *iconImageView; ///头像
@property (nonatomic, weak) UILabel *fellowLabel;       ///关注人数
@property (nonatomic, weak) GRPieProfitView *pieView;   ///盈利指数

@end

@implementation GRUserInfomationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //名字
        UILabel *name = [[UILabel alloc] init];
        [self.contentView addSubview:name];
        self.nameLabel = name;
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        name.font = [UIFont systemFontOfSize:15];
        name.text = @"全民小道";
        
        //参与合买人数
        UILabel *number = [[UILabel alloc] init];
        [self.contentView addSubview:number];
        self.numberLabel = number;
        number.textColor = [UIColor colorWithHexString:@"#666666"];
        number.font = [UIFont systemFontOfSize:11];
        number.text = @"参与合买5605人";
        
        //线
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:line];
        
        //盈利
        UILabel *profit = [[UILabel alloc] init];
        [self.contentView addSubview:profit];
        self.profitLabel = profit;
        profit.textColor = [UIColor colorWithHexString:@"#666666"];
        profit.font = [UIFont systemFontOfSize:11];
        profit.text = @"盈利1605324元";
        
        //盈利指数
        GRPieProfitView *pie = [[GRPieProfitView alloc] initWithFrame:CGRectMake(0, 0, 50, 50) andPercent:.87 andColor:[UIColor redColor]];
        self.pieView = pie;
        [self.contentView addSubview:pie];
        
        //下面的线
        UIView *bottomLine = [[UIView alloc] init];
        bottomLine.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:bottomLine];
        
        //头像
        UIImageView *icon = [[UIImageView alloc] init];
        self.iconImageView = icon;
        icon.layer.cornerRadius = 10;
        icon.layer.masksToBounds = YES;
        [self.contentView addSubview:icon];
        icon.backgroundColor = [UIColor redColor];
        
        //nick
        UILabel *nick = [[UILabel alloc] init];
        self.nickLabel = nick;
        nick.textColor = [UIColor colorWithHexString:@"#666666"];
        nick.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:nick];
        nick.text = @"全民叨叨";
        
        //关注人数
        UILabel *fellow = [[UILabel alloc] init];
        fellow.textColor = [UIColor colorWithHexString:@"#666666"];
        fellow.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:fellow];
        self.fellowLabel = fellow;
        fellow.text = @"13432人关注";
        
        //关注按钮
        UIButton *fellowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:fellowBtn];
        fellowBtn.titleLabel.font = [UIFont systemFontOfSize:8];
        [fellowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        fellowBtn.backgroundColor = [UIColor colorWithHexString:@"#f39800"];
        [fellowBtn setTitle:@"＋关注" forState:UIControlStateNormal];
        [fellowBtn setTitle:@"取消关注" forState:UIControlStateSelected];
        [fellowBtn addTarget:self action:@selector(fellowBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        //布局
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.top.equalTo(self.contentView).offset(10);
        }];
        
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.height.equalTo(@1);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-24);
        }];
        
        [number mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(name);
            make.bottom.equalTo(bottomLine.mas_top).offset(-8);;
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(number.mas_right).offset(10);
            make.centerY.equalTo(number.mas_centerY);
            make.height.equalTo(@11);
            make.width.equalTo(@1);
        }];
        
        [profit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(number.mas_centerY);
            make.left.equalTo(line.mas_right).offset(10);
        }];
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.top.equalTo(bottomLine.mas_bottom).offset(2);
            make.height.width.equalTo(@20);
        }];
        
        [nick mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon.mas_right).offset(5);
            make.centerY.equalTo(icon.mas_centerY);
        }];
        
        [fellowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-13);
            make.width.equalTo(@40);
            make.height.equalTo(@15);
            make.centerY.equalTo(icon.mas_centerY);
        }];
        
        [fellow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(icon.mas_centerY);
            make.right.equalTo(fellowBtn.mas_left).offset(-20);
        }];
        
        [pie mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-13);
            make.top.equalTo(self.contentView).offset(5);
            make.height.width.equalTo(@50);
        }];
        
    }
    return self;
}

#pragma mark - private method
- (void)fellowBtn:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        btn.backgroundColor = [UIColor lightGrayColor];
    }else{
        btn.backgroundColor = [UIColor colorWithHexString:@"#f39800"];
    }
}

#pragma mark - setter and getter
- (void)setDocumentModel:(GRDocumentary *)documentModel{
    _documentModel = documentModel;
    
    NSString *str = [NSString stringWithFormat:@"参与合买%@人",documentModel.number];
    NSRange range = [str stringSubWithString:@"买" andString:@"人"];
    NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc] initWithString:str];
    [attribut addAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#f39800"]} range:range];
    self.numberLabel.attributedText = attribut;
    
    NSString *profit = [NSString stringWithFormat:@"盈利%@元",documentModel.profit];
    NSRange profitRange = [str stringSubWithString:@"利" andString:@"元"];
    NSMutableAttributedString *attribut1 = [[NSMutableAttributedString alloc] initWithString:profit];
    [attribut addAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#d43c33"]} range:profitRange];
    self.numberLabel.attributedText = attribut1;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRUserInfomationCell";
    GRUserInfomationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRUserInfomationCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
