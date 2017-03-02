//
//  GRPropertyHeaderView.m
//  GoldRush
//
//  Created by Jack on 2017/1/10.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRPropertyAssetsHeaderView.h"
#import "GRDateFormatter.h"

@interface GRPropertyAssetsHeaderView ()

@property (nonatomic, weak) UILabel *titleLabel;        ///标题
///时间选择
@property (nonatomic, weak) UILabel *startLabel;
@property (nonatomic, weak) UILabel *endLabel;

@end

@implementation GRPropertyAssetsHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //标题
        UILabel *title = [[UILabel alloc] init];
        [self addSubview:title];
        self.titleLabel = title;
        title.textColor = [UIColor colorWithHexString:@"#333333"];
        if (iPhone5) {
            title.font = [UIFont systemFontOfSize:13];
        }else{
            title.font = [UIFont systemFontOfSize:15];
        }
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@13);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    
    self.titleLabel.text = title;
    if ([title isEqualToString:@"交易明细"]) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"Mine_Exchange_Time"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(changeTimeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-13);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        UILabel *title = [[UILabel alloc] init];
        title.text = @"默认时间范围：";
        title.textColor = [UIColor colorWithHexString:@"#666666"];
        if (iPhone5) {
            title.font = [UIFont systemFontOfSize:11];
        }else{
            title.font = [UIFont systemFontOfSize:13];
        }
        [self addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(5);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        //获取当前时间，日期
        NSDate *currentDate = [NSDate date];
        NSDateFormatter *dateFormatter = [GRDateFormatter sharedInstance];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSString *dateString = [dateFormatter stringFromDate:currentDate];
        
        UILabel *start = [[UILabel alloc] init];
        start.textColor = [UIColor colorWithHexString:@"#666666"];
        if (iPhone5) {
            start.font = [UIFont systemFontOfSize:11];
        }else{
            start.font = [UIFont systemFontOfSize:13];
        }
        
        start.text = [NSString stringWithFormat:@"%@ -",dateString];
        self.startLabel = start;
        [self addSubview:start];
        [start mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title.mas_right);
            make.centerY.equalTo(self);
        }];
        
        UILabel *end = [[UILabel alloc] init];
        end.textColor = [UIColor colorWithHexString:@"#666666"];
        if (iPhone5) {
            end.font = [UIFont systemFontOfSize:11];
        }else{
            end.font = [UIFont systemFontOfSize:13];
        }
        
        end.text = [NSString stringWithFormat:@"%@",dateString];
        self.endLabel = end;
        [self addSubview:end];
        [end mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(start.mas_right);
            make.centerY.equalTo(self);
        }];
    }
}

- (void)changeTimeButtonAction:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gr_propertyAssetsHeaderView:didClickSelectedTime:)]) {
        [self.delegate gr_propertyAssetsHeaderView:self didClickSelectedTime:sender];
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

@end
