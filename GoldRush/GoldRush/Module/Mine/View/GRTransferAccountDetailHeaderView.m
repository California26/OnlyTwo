//
//  GRTransferAccountDetailHeaderView.m
//  GoldRush
//
//  Created by Jack on 2017/2/18.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRTransferAccountDetailHeaderView.h"
#import "GRDateFormatter.h"

@interface GRTransferAccountDetailHeaderView ()

///时间选择
@property (nonatomic, weak) UILabel *startLabel;
@property (nonatomic, weak) UILabel *endLabel;

@end

@implementation GRTransferAccountDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self createTimeSelect];
        
    }
    return self;
}

- (void)createTimeSelect{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 95, 30)];
    title.text = @"默认时间范围：";
    title.textColor = [UIColor colorWithHexString:@"#666666"];
    title.font = [UIFont systemFontOfSize:13];
    [self addSubview:title];
    
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
    [self addSubview:start];
    
    UILabel *end = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(start.frame), 0, 90, 30)];
    end.textColor = [UIColor colorWithHexString:@"#666666"];
    end.font = [UIFont systemFontOfSize:13];
    
    end.text = [NSString stringWithFormat:@"%@",dateString];
    self.endLabel = end;
    [self addSubview:end];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"Mine_Exchange_Time"] forState:UIControlStateNormal];
    button.frame = CGRectMake(K_Screen_Width - 40, 0, 30, 30);
    [button addTarget:self action:@selector(changeTimeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    NSArray *arytext = [NSArray arrayWithObjects:@"时间",@"类型",@"金额",@"范围", nil];
    for (int i = 0; i < arytext.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((K_Screen_Width / 4) * i, 30, K_Screen_Width/4, 34)];
        label.text = arytext[i];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
}

- (void)changeTimeButtonAction:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gr_transferAccountDetailTimeSelectedClick)]) {
        [self.delegate gr_transferAccountDetailTimeSelectedClick];
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
