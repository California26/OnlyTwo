//
//  GROutOfDateCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/17.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GROutOfDateCell.h"

#import "GRHDThicketsModel.h"
#import "GRJJThicketsModel.h"

@interface GROutOfDateCell ()

@property (nonatomic, weak) UILabel *moneyLabel;
@property (nonatomic, weak) UILabel *expireLabel;

@end

@implementation GROutOfDateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = defaultBackGroundColor;
        
        ///背景图片
        UIImageView *image = [[UIImageView alloc] init];
        [self.contentView addSubview:image];
        image.image = [UIImage imageNamed:@"Mine_Out_Date_Thicket"];
        
        ///抵金券
        UILabel *thicket = [[UILabel alloc] init];
        [self.contentView addSubview:thicket];
        thicket.textColor = [UIColor whiteColor];
        thicket.text = @"抵金券";
        thicket.font = [UIFont systemFontOfSize:20];
        
        ///横线
        UIImageView *horizontal = [[UIImageView alloc] init];
        [self.contentView addSubview:horizontal];
        horizontal.image = [UIImage imageNamed:@"Mine_Thicket_Horizontal@3x"];
        
        ///竖线
        UIImageView *vertical = [[UIImageView alloc] init];
        [self.contentView addSubview:vertical];
        vertical.image = [UIImage imageNamed:@"Mine_Thicket_Vertical"];
        
        //金额
        UILabel *money = [[UILabel alloc] init];
        [image addSubview:money];
        money.textColor = [UIColor whiteColor];
        money.font = [UIFont boldSystemFontOfSize:50];
        self.moneyLabel = money;
        
        //已过期
        UILabel *expired = [[UILabel alloc] init];
        [self.contentView addSubview:expired];
        expired.textColor = [UIColor whiteColor];
        expired.backgroundColor = GRColor(204, 204, 204);
        expired.text = @"已过期";
        expired.textAlignment = NSTextAlignmentCenter;
        expired.font = [UIFont systemFontOfSize:12];
        
        //有效期至
        UILabel *validity = [[UILabel alloc] init];
        [self.contentView addSubview:validity];
        validity.text = @"有效期至";
        validity.textColor = [UIColor whiteColor];
        validity.font = [UIFont systemFontOfSize:14];
        
        //到期时间
        UILabel *time = [[UILabel alloc] init];
        [image addSubview:time];
        time.textColor = [UIColor whiteColor];
        time.font = [UIFont systemFontOfSize:12];
        self.expireLabel = time;
        
        //布局
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.contentView).offset(10);
            make.left.equalTo(self.contentView).offset(13);
            make.right.equalTo(self.contentView).offset(-13);
            make.height.equalTo(@140);
        }];
        
        [thicket mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(image.mas_centerX).offset(-70);
            make.top.equalTo(image.mas_top).offset(15);
        }];
        
        [horizontal mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(thicket.mas_centerX);
            make.top.equalTo(thicket.mas_bottom).offset(17);
        }];
        
        [vertical mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(horizontal.mas_right).offset(15);
            make.centerY.equalTo(image.mas_centerY);
        }];
        
        [money mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(thicket.mas_centerX);
            make.top.equalTo(thicket.mas_bottom).offset(34);
        }];
        
        [expired mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(image.mas_top).offset(15);
            if (iPhone5) {
                make.right.equalTo(image.mas_right).offset(-20);
            }else{
                make.right.equalTo(image.mas_right).offset(-40);
            }
            make.width.equalTo(@60);
            make.height.equalTo(@30);
        }];
        
        [validity mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(expired.mas_centerX);
            make.top.equalTo(image.mas_top).offset(70);
        }];
        
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(expired.mas_centerX);
            make.top.equalTo(validity.mas_bottom).offset(15);
        }];
        
    }
    return self;
}


- (void)setHdModel:(GRHDThicketsModel *)hdModel{
    _hdModel = hdModel;
    
    NSString *moneyStr = [NSString stringWithFormat:@"%zd元",hdModel.rechargeMoney];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:moneyStr];
    [string addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]} range:NSMakeRange(moneyStr.length - 1, 1)];
    self.moneyLabel.attributedText = string;
    self.expireLabel.text = [hdModel.endTime substringToIndex:10];
    
}

- (void)setJjModel:(GRJJThicketsModel *)jjModel{
    _jjModel = jjModel;
    
    NSString *moneyStr = [NSString stringWithFormat:@"%@元",jjModel.sum];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:moneyStr];
    [string addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]} range:NSMakeRange(moneyStr.length - 1, 1)];
    self.moneyLabel.attributedText = string;
    self.expireLabel.text = jjModel.endDate;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GROutOfDateCell";
    GROutOfDateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GROutOfDateCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
