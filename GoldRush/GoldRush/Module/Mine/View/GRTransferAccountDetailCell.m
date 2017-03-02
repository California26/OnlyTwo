//
//  GRTransferAccountDetailCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/11.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRTransferAccountDetailCell.h"

#import "GRTransferAccountJJDetail.h"         ///数据模型
#import "GRTransferAccountHDDetail.h"

@interface GRTransferAccountDetailCell ()

@property (nonatomic, weak) UIImageView *noDataImageView;       ///无数据图片
@property (nonatomic, weak) UILabel *timeLabel;                 ///时间
@property (nonatomic, weak) UILabel *yearLabel;                 ///年
@property (nonatomic, weak) UILabel *typeLabel;                 ///充值类型
@property (nonatomic, weak) UILabel *moneyLabel;                ///金额
@property (nonatomic, weak) UILabel *statusLabel;               ///转账状态

@end

@implementation GRTransferAccountDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *label1  = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, K_Screen_Width/4, 16)];
        label1.textColor = [UIColor colorWithHexString:@"#666666"];
        label1.font = [UIFont systemFontOfSize:12];
        label1.textAlignment = NSTextAlignmentCenter;
        self.yearLabel = label1;
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10+16+1, K_Screen_Width/4, 16)];
        label2.textAlignment = NSTextAlignmentCenter;
        label2.textColor = label1.textColor;
        label2.font = label1.font;
        self.timeLabel = label2;
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(K_Screen_Width/4,0, K_Screen_Width/4, 43)];
        label3.textAlignment = NSTextAlignmentCenter;
        label3.textColor = label1.textColor;
        label3.font = [UIFont systemFontOfSize:13];
        self.typeLabel = label3;
        
        UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(K_Screen_Width/4*2,0, K_Screen_Width/4, 43)];
        label4.textAlignment = NSTextAlignmentCenter;
        label4.textColor = label1.textColor;
        label4.font = [UIFont systemFontOfSize:13];
        self.moneyLabel = label4;
        
        UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(K_Screen_Width/4*3,0, K_Screen_Width/4, 43)];
        label5.textAlignment = NSTextAlignmentCenter;
//        label5.textColor = [UIColor colorWithHexString:@"#09cb67"];
        label5.font = [UIFont systemFontOfSize:13];
        self.statusLabel = label5;
        
        [self.contentView addSubview:label1];
        [self.contentView addSubview:label2];
        [self.contentView addSubview:label3];
        [self.contentView addSubview:label4];
        [self.contentView addSubview:label5];
        
    }
    return self;
}

#pragma mark - setter and getter 
- (void)setDetailModelJJ:(GRTransferAccountJJDetail *)detailModelJJ{
    _detailModelJJ = detailModelJJ;
    
    self.yearLabel.text = [[self timeWithTimeIntervalString:[NSString stringWithFormat:@"%zd",detailModelJJ.createTime.integerValue]] substringToIndex:10];
    self.timeLabel.text = [[self timeWithTimeIntervalString:[NSString stringWithFormat:@"%zd",detailModelJJ.createTime.integerValue]] substringFromIndex:10];
    
    if ([detailModelJJ.type isEqualToString:@"3"]) {
        self.typeLabel.text = @"充值";
    }else{
        self.typeLabel.text = @"提现";
    }
    
    if ([detailModelJJ.type isEqualToString:@"3"]) {
        self.moneyLabel.text = detailModelJJ.income;
    }else{
        self.moneyLabel.text = detailModelJJ.pay;
    }
    
    self.statusLabel.text = detailModelJJ.remark;
}

- (void)setDetailModelHD:(GRTransferAccountHDDetail *)detailModelHD{
    _detailModelHD = detailModelHD;
    
    self.yearLabel.text = [detailModelHD.addTime substringToIndex:10];
    self.timeLabel.text = [detailModelHD.addTime substringFromIndex:10];
    
    if ([detailModelHD.reType isEqualToString:@"1"]) {
        self.typeLabel.text = @"提现";
    }else{
        self.typeLabel.text = @"充值";
    }
    
    self.moneyLabel.text = detailModelHD.money;
    
    if ([detailModelHD.orderType isEqualToString:@"8"]) {
        self.statusLabel.text = @"申请充值";
    }else if ([detailModelHD.orderType isEqualToString:@"9"]){
        self.statusLabel.text = @"充值成功";
    }else if ([detailModelHD.orderType isEqualToString:@"10"]){
        self.statusLabel.text = @"充值失败";
    }else if ([detailModelHD.orderType isEqualToString:@"11"]){
        self.statusLabel.text = @"提现申请";
    }else if ([detailModelHD.orderType isEqualToString:@"12"]){
        self.statusLabel.text = @"提现审核通过";
    }else if ([detailModelHD.orderType isEqualToString:@"13"]){
        self.statusLabel.text = @"提现成功";
    }else{
        self.statusLabel.text = @"提现失败";
    }
}

- (NSString *)timeWithTimeIntervalString:(NSString *)timeString{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRTransferAccountDetailCell";
    GRTransferAccountDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRTransferAccountDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
