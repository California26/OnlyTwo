//
//  GRAnalystCommentCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/9.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRAnalystCommentCell.h"
#import "GRAnalystComment.h"

@interface GRAnalystCommentCell ()

@property (nonatomic, weak) UIImageView *iconImageView;         ///头像
@property (nonatomic, weak) UILabel *nameLabel;                 ///名字
@property (nonatomic, weak) UILabel *timeLabel;                 ///时间
@property (nonatomic, weak) UILabel *descLabel;                 ///描述文字

@end

@implementation GRAnalystCommentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //头像
        UIImageView *icon = [[UIImageView alloc] init];
        [self.contentView addSubview:icon];
        icon.layer.masksToBounds = YES;
        icon.layer.cornerRadius = 20;
        self.iconImageView = icon;
        icon.backgroundColor = [UIColor orangeColor];
        
        //名字
        UILabel *name = [[UILabel alloc] init];
        [self.contentView addSubview:name];
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        name.font = [UIFont systemFontOfSize:13];
        self.nameLabel = name;
        name.text = @"全民123";
        
        //时间
        UILabel *time = [[UILabel alloc] init];
        [self.contentView addSubview:time];
        time.textColor = [UIColor colorWithHexString:@"#999999"];
        time.font = [UIFont systemFontOfSize:12];
        self.timeLabel = time;
        time.text = @"1-5 08:30";
        
        //关注按钮
        UIButton *fellowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:fellowBtn];
        [fellowBtn setTitle:@"＋关注" forState:UIControlStateNormal];
        [fellowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [fellowBtn setTitle:@"已关注" forState:UIControlStateSelected];
        fellowBtn.backgroundColor = [UIColor colorWithHexString:@"#f39800"];
        [fellowBtn addTarget:self action:@selector(fellowClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //描述文字
        UILabel *desc = [[UILabel alloc] init];
        [self.contentView addSubview:desc];
        desc.textColor = [UIColor colorWithHexString:@"#666666"];
        desc.font = [UIFont systemFontOfSize:11];
        desc.backgroundColor = [UIColor colorWithHexString:@"eff0f2"];
        desc.numberOfLines = 0;
        self.descLabel = desc;
        desc.userInteractionEnabled = YES;
        
        //给描述文字添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDescLabel:)];
        [desc addGestureRecognizer:tap];
        
        //线
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:line];
        
        //布局
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.top.equalTo(self.contentView).offset(5);
            make.width.height.equalTo(@40);
        }];
        
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon.mas_right).offset(5);
            make.top.equalTo(self.contentView).offset(10);
        }];
        
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(name);
            make.top.equalTo(name.mas_bottom).offset(5);
        }];
        
        [fellowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(icon.mas_centerY);
            make.right.equalTo(self.contentView).offset(-13);
            make.height.equalTo(@20);
            make.width.equalTo(@80);
        }];
        
        [desc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.right.equalTo(self.contentView).offset(-13);
            make.top.equalTo(time.mas_bottom).offset(8);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(desc.mas_bottom).offset(8);
            make.left.right.equalTo(self.contentView);
            make.height.equalTo(@1);
        }];
    }
    return self;
}

#pragma mark - event response
- (void)fellowClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        btn.backgroundColor = [UIColor lightGrayColor];
    }else{
        btn.backgroundColor = [UIColor colorWithHexString:@"#f39800"];
    }
}

- (void)tapDescLabel:(UITapGestureRecognizer *)gesture{
    if (self.tapDescLabel) {
        self.tapDescLabel();
    }
}

#pragma mark - setter and getter 
- (void)setCommentModel:(GRAnalystComment *)commentModel{
    _commentModel = commentModel;
    
    self.nameLabel.text = commentModel.name;
    self.timeLabel.text = commentModel.time;
    self.descLabel.text = commentModel.desc;
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(GRAnalystComment *)object{
    CGFloat statusLabelWidth = [UIScreen mainScreen].bounds.size.width - 26;
    //字符串分类提供方法，计算字符串的高度
    //  ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
    CGRect statusLabelRect = [object.desc sizeWithLabelWidth:statusLabelWidth font:[UIFont systemFontOfSize:11]];
    return CGRectGetMaxY(statusLabelRect) + 62;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRAnalystCommentCell";
    GRAnalystCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRAnalystCommentCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
