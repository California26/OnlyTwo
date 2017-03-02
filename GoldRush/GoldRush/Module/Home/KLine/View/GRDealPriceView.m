//
//  GRDealPriceView.m
//  GoldRush
//
//  Created by Jack on 2016/12/26.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRDealPriceView.h"

@interface GRDealPriceView ()
///最高
@property (nonatomic, weak) UILabel *maxValueLabel;
///最低
@property (nonatomic, weak) UILabel *minValueLabel;
///今开值
@property (nonatomic, weak) UILabel *todayValueLabel;
///左收值
@property (nonatomic, weak) UILabel *yesterdayValueLabel;
@end

@implementation GRDealPriceView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //创建交易价格面板
        [self createPanel];
    }
    return self;
}

- (void)createPanel{

    //最高
    UILabel *maxLabel = [[UILabel alloc] init];
    maxLabel.font = [UIFont boldSystemFontOfSize:11];
    maxLabel.textColor = [UIColor colorWithHexString:@"#ffdbdb"];
    maxLabel.backgroundColor = [UIColor redColor];
    maxLabel.text = @"最高";
    [self addSubview:maxLabel];
    //最低
    UILabel *minLabel = [[UILabel alloc] init];
    minLabel.font = [UIFont boldSystemFontOfSize:11];
    minLabel.textColor = [UIColor colorWithHexString:@"#ffdbdb"];
    minLabel.backgroundColor = [UIColor blueColor];
    minLabel.text = @"最低";
    [self addSubview:minLabel];
    //今开
    UILabel *todayLabel = [[UILabel alloc] init];
    todayLabel.font = [UIFont boldSystemFontOfSize:11];
    todayLabel.textColor = [UIColor colorWithHexString:@"#ffdbdb"];
    todayLabel.backgroundColor = [UIColor blueColor];
    todayLabel.text = @"今开";
    [self addSubview:todayLabel];
    //昨收
    UILabel *yesterdayLabel = [[UILabel alloc] init];
    yesterdayLabel.font = [UIFont boldSystemFontOfSize:11];
    yesterdayLabel.textColor = [UIColor colorWithHexString:@"#ffdbdb"];
    yesterdayLabel.backgroundColor = [UIColor blueColor];
    yesterdayLabel.text = @"昨收";
    [self addSubview:yesterdayLabel];
    //最大值
    UILabel *max = [[UILabel alloc] init];
    self.maxValueLabel = max;
    max.font = [UIFont boldSystemFontOfSize:11];
    max.textColor = [UIColor colorWithHexString:@"#ffffff"];
    max.backgroundColor = RandColor;
    max.text = self.maxValue;
    [self addSubview:max];
    //最低值
    UILabel *min = [[UILabel alloc] init];
    self.minValueLabel = min;
    min.font = [UIFont boldSystemFontOfSize:11];
    min.textColor = [UIColor colorWithHexString:@"#ffffff"];
    min.backgroundColor = RandColor;
    min.text = self.minValue;
    [self addSubview:min];
    //今开值
    UILabel *today = [[UILabel alloc] init];
    self.todayValueLabel = today;
    today.font = [UIFont boldSystemFontOfSize:11];
    today.textColor = [UIColor colorWithHexString:@"#ffffff"];
    today.backgroundColor = RandColor;
    today.text = self.todayValue;
    [self addSubview:today];
    //昨收值
    UILabel *yesterday = [[UILabel alloc] init];
    self.yesterdayValueLabel = yesterday;
    yesterday.font = [UIFont boldSystemFontOfSize:11];
    yesterday.textColor = [UIColor colorWithHexString:@"#ffffff"];
    yesterday.backgroundColor = RandColor;
    yesterday.text = self.yesterdayValue;
    [self addSubview:yesterday];
    
    [maxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(self);
        make.height.equalTo(minLabel.mas_height);
        make.bottom.equalTo(minLabel.mas_top);
    }];
    [minLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.equalTo(self);
        make.height.equalTo(maxLabel.mas_height);
        make.top.equalTo(maxLabel.mas_bottom);
    }];
    
    [max mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(maxLabel.mas_right);
        make.height.equalTo(min.mas_height);
        make.bottom.equalTo(min.mas_top);
        make.width.equalTo(today.mas_width);
    }];
    [min mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(minLabel.mas_right);
        make.height.equalTo(max.mas_height);
        make.top.equalTo(max.mas_bottom);
        make.width.equalTo(yesterday.mas_width);
    }];
    
    [todayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(max.mas_right).offset(21);
        make.bottom.equalTo(yesterdayLabel.mas_top);
        make.height.equalTo(yesterdayLabel.mas_height);
    }];
    [yesterdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(min.mas_right).offset(21);
        make.top.equalTo(todayLabel.mas_bottom);
        make.height.equalTo(todayLabel.mas_height);
    }];
    
    [today mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.left.equalTo(todayLabel.mas_right);
        make.bottom.equalTo(yesterday.mas_top);
        make.top.equalTo(self.mas_top);
        make.height.equalTo(yesterday.mas_height);
        make.width.equalTo(yesterday.mas_width);
    }];
    [yesterday mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(yesterdayLabel.mas_right);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(today.mas_bottom);
        make.height.equalTo(today.mas_height);
        make.width.equalTo(today.mas_width);
    }];
}

#pragma mark - setter and getter
- (void)setMaxValue:(NSString *)maxValue{
    _maxValue = maxValue;
    self.maxValueLabel.text = maxValue;
}

- (void)setMinValue:(NSString *)minValue{
    _minValue = minValue;
    self.minValueLabel.text = minValue;
}

- (void)setTodayValue:(NSString *)todayValue{
    _todayValue = todayValue;
    self.todayValueLabel.text = todayValue;
}

- (void)setYesterdayValue:(NSString *)yesterdayValue{
    _yesterdayValue = yesterdayValue;
    self.yesterdayValueLabel.text = yesterdayValue;
}

@end
