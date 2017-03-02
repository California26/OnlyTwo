//
//  GRRechargeTimeSelectedCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/11.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRRechargeTimeSelectedCell.h"
#import "GRDateFormatter.h"

@interface GRRechargeTimeSelectedCell ()

///时间选择
@property (nonatomic, weak) UILabel *startLabel;
@property (nonatomic, weak) UILabel *endLabel;

@end

@implementation GRRechargeTimeSelectedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 95, 30)];
        title.text = @"默认时间范围：";
        title.textColor = [UIColor colorWithHexString:@"#666666"];
        title.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:title];
        
        //获取当前时间，日期
        NSDate *currentDate = [NSDate date];
        NSDateFormatter *dateFormatter = [GRDateFormatter sharedInstance];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSString *dateString = [dateFormatter stringFromDate:currentDate];
        
        UILabel *start = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(title.frame), 0, 90, 30)];
        start.textColor = [UIColor colorWithHexString:@"#666666"];
        start.font = [UIFont systemFontOfSize:13];
        
        start.text = [NSString stringWithFormat:@"%@ -",dateString];
        self.startLabel = start;
        [self.contentView addSubview:start];
        
        UILabel *end = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(start.frame), 0, 90, 30)];
        end.textColor = [UIColor colorWithHexString:@"#666666"];
        end.font = [UIFont systemFontOfSize:13];
        
        end.text = [NSString stringWithFormat:@"%@",dateString];
        self.endLabel = end;
        [self.contentView addSubview:end];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"Mine_Exchange_Time"] forState:UIControlStateNormal];
        button.frame = CGRectMake(K_Screen_Width - 40, 0, 30, 30);
        [button addTarget:self action:@selector(changeTimeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        
    }
    return self;
}

- (void)changeTimeButtonAction:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gr_rechargeTimeSelectedCellClick:)]) {
        [self.delegate gr_rechargeTimeSelectedCellClick:self];
    }
}

- (void)setStartTime:(NSString *)startTime{
    _startTime = startTime;
    
    if (startTime.length) {
        self.startLabel.text = [NSString stringWithFormat:@"%@ -",startTime];
    }
}

- (void)setEndTime:(NSString *)endTime{
    _endTime = endTime;
    if (endTime.length) {
        self.endLabel.text = [NSString stringWithFormat:@"%@",endTime];
    }
}


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRRechargeTimeSelectedCell";
    GRRechargeTimeSelectedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRRechargeTimeSelectedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
