//
//  GRPropertyHeaderView.m
//  GoldRush
//
//  Created by Jack on 2016/12/30.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRPropertyHeaderView.h"
#import "UICountingLabel.h"

@implementation GRPropertyHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //设置 UI
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.backgroundColor = mainColor;
    //止损止盈
    UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [stopBtn setTitle:@"止盈止损" forState:UIControlStateNormal];
    [stopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    stopBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    stopBtn.layer.cornerRadius = 8;
    stopBtn.layer.masksToBounds = YES;
    stopBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    stopBtn.layer.borderWidth = 1.0;
    [stopBtn sizeToFit];
    stopBtn.frame = CGRectMake(13, 30, 90, 28);
    [stopBtn addTarget:self action:@selector(stopClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:stopBtn];
    
    //止损止盈
    UIButton *warnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [warnBtn setImage:[UIImage imageNamed:@"Deal_Warn"] forState:UIControlStateNormal];
    warnBtn.frame = CGRectMake(K_Screen_Width - 33, 30, 28, 28);
    [warnBtn addTarget:self action:@selector(warnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:warnBtn];
    
    UICountingLabel *priceLabel = [[UICountingLabel alloc] init];
    priceLabel.textColor = [UIColor whiteColor];
    priceLabel.font = [UIFont systemFontOfSize:35];
    priceLabel.format = @"%zd";
    [priceLabel countFrom:12345 to:54321 withDuration:3];
    priceLabel.formatBlock = ^(CGFloat value){
        NSInteger years = value / 12;
        NSInteger months = (NSInteger)value % 12;
        if (years == 0) {
            return [NSString stringWithFormat: @"%ld", (long)months];
        }
        else {
            return [NSString stringWithFormat: @"%ld", (long)years];
        }
    };
    [self addSubview:priceLabel];
    [priceLabel sizeToFit];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(13);
        make.top.equalTo(stopBtn.mas_bottom).offset(10);
    }];
    
    UICountingLabel *riseLabel = [[UICountingLabel alloc] init];
    riseLabel.textColor = [UIColor whiteColor];
    riseLabel.font = [UIFont systemFontOfSize:10];
    riseLabel.format = @"%.2f";
    [riseLabel countFrom:0.01 to:2.99 withDuration:3];
    riseLabel.formatBlock = ^(CGFloat value){
        CGFloat years = value / 12;
        CGFloat months = value / 12;
        if (years == 0) {
            return [NSString stringWithFormat: @"+%.2f", months];
        }
        else {
            return [NSString stringWithFormat: @"+%.2f", years];
        }
    };
    [self addSubview:riseLabel];
    [riseLabel sizeToFit];
    [riseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(priceLabel.mas_right).offset(10);
        make.topMargin.equalTo(priceLabel);
    }];
    
    UICountingLabel *percentLabel = [[UICountingLabel alloc] init];
    percentLabel.textColor = [UIColor whiteColor];
    percentLabel.font = [UIFont systemFontOfSize:10];
    percentLabel.format = @"%.2f";
    [percentLabel countFrom:0.01 to:2.99 withDuration:3];
    percentLabel.formatBlock = ^(CGFloat value){
        CGFloat years = value / 12;
        CGFloat months = value / 12;
        if (years == 0) {
            return [NSString stringWithFormat: @"+%.2f%%", months];
        }
        else {
            return [NSString stringWithFormat: @"+%.2f%%", years];
        }
    };
    [self addSubview:percentLabel];
    [percentLabel sizeToFit];
    [percentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(priceLabel.mas_right).offset(10);
        make.bottomMargin.equalTo(priceLabel);
    }];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    [self addSubview:timeLabel];
    timeLabel.text = @"交易时间: 8:00 - 18:00";
    timeLabel.font = [UIFont systemFontOfSize:9];
    timeLabel.textColor = [UIColor whiteColor];
    [timeLabel sizeToFit];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerY.equalTo(priceLabel.mas_centerY);
    }];
    
}
    
#pragma mark - event response
- (void)warnClick{
    if (self.warnBlock) {
        self.warnBlock();
    }
}
    
- (void)stopClick{
    if (self.stopBlock) {
        self.stopBlock();
    }
}



@end
