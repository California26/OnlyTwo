//
//  GRDealMiddleView.m
//  GoldRush
//
//  Created by Jack on 2017/1/4.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRDealMiddleView.h"
#import "GRNumberBtn.h"
#import "GRStopButton.h"

@interface GRDealMiddleView ()
///已选择手数
@property (nonatomic, assign) NSInteger selectedHandCount;
///选择手数
@property (nonatomic, weak) UILabel *limitLabel;
///最大手数
@property (nonatomic, weak) UILabel *maxLabel;
///止盈止损范围
@property (nonatomic, weak) UILabel *stopProfitLabel;
@property (nonatomic, weak) UILabel *stopLossLabel;

///是否使用赢家券按钮
@property (nonatomic, weak) UISwitch *switchBtn;

///赢家券数量
@property (nonatomic, weak) UILabel *thicketLabel;

///手数
@property (nonatomic, weak) GRNumberBtn *handCountBtn;
///止盈
@property (nonatomic, weak) GRStopButton *stopProfitBtn;
///止损
@property (nonatomic, weak) GRStopButton *stopLossBtn;

@end

@implementation GRDealMiddleView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加子控件
        [self setupHandCount];
    }
    return self;
}

- (void)setupHandCount{
    //手数
    UILabel *handCount = [[UILabel alloc] init];
    [self addSubview:handCount];
    handCount.text = @"手数";
    handCount.textColor = [UIColor colorWithHexString:@"#333333"];
    handCount.font = [UIFont systemFontOfSize:15];
    [handCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.top.equalTo(self).offset(20);
    }];
    
    //按钮
    GRNumberBtn *numberBtn = [[GRNumberBtn alloc] init];
    [self addSubview:numberBtn];
    self.handCountBtn = numberBtn;
    numberBtn.borderColor = [UIColor grayColor];
    numberBtn.increaseTitle = @"＋";
    numberBtn.decreaseTitle = @"－";
    numberBtn.buttonTitleFont = 20;
    numberBtn.maxValue = 10;
    numberBtn.minValue = 1;
    numberBtn.shakeAnimation = YES;
    WS(weakSelf)
    numberBtn.resultBlock = ^(NSInteger num ,BOOL increaseStatus){
        weakSelf.selectedHandCount = num;
        if (weakSelf.numberBlock) {
            weakSelf.numberBlock(num);
        }
    };
    
    //限制手数
    UILabel *limit = [[UILabel alloc] init];
    limit.textColor = [UIColor colorWithHexString:@"#333333"];
    limit.font = [UIFont systemFontOfSize:10];
    limit.text = @"已选择1手";
    self.limitLabel = limit;
    [self addSubview:limit];
    
    UILabel *max = [[UILabel alloc] init];
    max.textColor = [UIColor colorWithHexString:@"#333333"];
    max.font = [UIFont systemFontOfSize:10];
    max.text = @"(最大持有10手)";
    self.maxLabel = max;
    [self addSubview:max];
    
    [limit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(numberBtn);
        make.leftMargin.equalTo(max);
    }];
    [max mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.bottomMargin.equalTo(numberBtn);
    }];
    [numberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(handCount.mas_right).offset(14);
        make.centerY.equalTo(handCount.mas_centerY);
        make.right.equalTo(max.mas_left).offset(-11);
        make.height.equalTo(@25);
    }];

    //止盈
    UILabel *stopProfit = [[UILabel alloc] init];
    [self addSubview:stopProfit];
    stopProfit.text = @"止盈";
    stopProfit.textColor = [UIColor colorWithHexString:@"#333333"];
    stopProfit.font = [UIFont systemFontOfSize:15];
    [stopProfit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.top.equalTo(handCount.mas_bottom).offset(20);
    }];

    //按钮
    GRStopButton *number1Btn = [[GRStopButton alloc] init];
    [self addSubview:number1Btn];
    self.stopProfitBtn = number1Btn;
    number1Btn.borderColor = [UIColor grayColor];
    number1Btn.increaseTitle = @"＋";
    number1Btn.decreaseTitle = @"－";
    number1Btn.buttonTitleFont = 20;
    number1Btn.minValue = 0;
    number1Btn.maxValue = 50;
    number1Btn.currentNumber = 0;
    number1Btn.shakeAnimation = YES;
    number1Btn.resultBlock = ^(NSInteger num ,BOOL increaseStatus){
        if (weakSelf.stopProfit) {
            weakSelf.stopProfit(num);
        }
    };

    //限制
    UILabel *range = [[UILabel alloc] init];
    range.textColor = [UIColor colorWithHexString:@"#333333"];
    range.font = [UIFont systemFontOfSize:10];
    range.text = @"(范围:0~50)";
    self.stopProfitLabel = range;
    [self addSubview:range];
    
    [range mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(stopProfit.mas_centerY);
        make.leftMargin.equalTo(max);
    }];
    
    [number1Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(stopProfit.mas_right).offset(14);
        make.centerY.equalTo(stopProfit.mas_centerY);
        make.right.equalTo(range.mas_left).offset(-11);
        make.height.equalTo(@25);
    }];
    
    //止损
    UILabel *stopLoss = [[UILabel alloc] init];
    [self addSubview:stopLoss];
    stopLoss.text = @"止损";
    stopLoss.textColor = [UIColor colorWithHexString:@"#333333"];
    stopLoss.font = [UIFont systemFontOfSize:15];
    [stopLoss mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.top.equalTo(stopProfit.mas_bottom).offset(20);
    }];
    
    //按钮
    GRStopButton *number2Btn = [[GRStopButton alloc] init];
    [self addSubview:number2Btn];
    self.stopLossBtn = number2Btn;
    number2Btn.borderColor = [UIColor grayColor];
    number2Btn.increaseTitle = @"＋";
    number2Btn.decreaseTitle = @"－";
    number2Btn.buttonTitleFont = 20;
    number2Btn.maxValue = 50;
    number2Btn.minValue = 0;
    number2Btn.currentNumber = 0;
    number2Btn.shakeAnimation = YES;
    number2Btn.resultBlock = ^(NSInteger num ,BOOL increaseStatus){
        if (weakSelf.stopLoss) {
            weakSelf.stopLoss(num);
        }
    };
    
    //限制
    UILabel *range2 = [[UILabel alloc] init];
    range2.textColor = [UIColor colorWithHexString:@"#333333"];
    range2.font = [UIFont systemFontOfSize:10];
    range2.text = @"(范围:0~50)";
    self.stopLossLabel = range2;
    [self addSubview:range2];
    
    [range2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(stopLoss.mas_centerY);
        make.leftMargin.equalTo(max);
    }];
    
    [number2Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(stopLoss.mas_right).offset(14);
        make.centerY.equalTo(stopLoss.mas_centerY);
        make.right.equalTo(range2.mas_left).offset(-11);
        make.height.equalTo(@25);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.height.equalTo(@1);
        make.top.equalTo(number2Btn.mas_bottom).offset(10);
    }];
    
    UISwitch *switchBtn = [[UISwitch alloc] init];
    switchBtn.onTintColor = GRColor(197, 72, 60);
    [self addSubview:switchBtn];
    self.switchBtn = switchBtn;
    [switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(9);
        make.top.equalTo(line.mas_bottom).offset(10);
    }];
    [switchBtn addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *ticket = [[UILabel alloc] init];
    [self addSubview:ticket];
    ticket.text = @"使用赢家券(剩余0张,每次限用一张)";
    self.thicketLabel = ticket;
    ticket.textColor = [UIColor colorWithHexString:@"#666666"];
    ticket.font = [UIFont systemFontOfSize:13];
    [ticket mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(switchBtn.mas_right).offset(18);
        make.centerY.equalTo(switchBtn.mas_centerY);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

#pragma mark - private method
- (void)switchClick:(UISwitch *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(gr_dealMiddleView:didClickSwitch:)]) {
        [self.delegate gr_dealMiddleView:self didClickSwitch:btn];
    }
    
    if (self.thicketCount == 0) btn.on = NO;
}

#pragma mark - setter and getter
- (void)setSelectedHandCount:(NSInteger)selectedHandCount{
    _selectedHandCount = selectedHandCount;
    
    self.limitLabel.text = [NSString stringWithFormat:@"已选择%ld手",(long)selectedHandCount];
}

- (void)setType:(NSString *)type{
    _type = type;
    
    if ([type isEqualToString:@"10"]) {
        self.maxLabel.text = @"(最大持有10手)";
        self.handCountBtn.maxValue = 10;
    }else if ([type isEqualToString:@"200"]){
        self.maxLabel.text = @"(最大持有30手)";
        self.handCountBtn.maxValue = 30;
    }else if ([type isEqualToString:@"2000"]){
        self.maxLabel.text = @"(最大持有20手)";
        self.handCountBtn.maxValue = 20;
    }else{
        self.maxLabel.text = @"(最大持有10手)";
        self.handCountBtn.maxValue = 10;
    }
}

- (void)setHDOrJJ:(BOOL)HDOrJJ{
    _HDOrJJ = HDOrJJ;
    if (HDOrJJ) {       ///吉交所
        self.switchBtn.on = NO;
        self.stopProfitLabel.text = @"(范围:0~200)";
        self.stopLossLabel.text = @"(范围:0~90)";
        self.stopProfitBtn.maxValue = 200;
        self.stopLossBtn.maxValue = 90;
        self.stopProfitBtn.currentNumber = 0;
        self.stopLossBtn.currentNumber = 0;
        self.handCountBtn.currentNumber = 1;
        self.limitLabel.text = @"已选择1手";
    }else{          ///恒大
        self.stopProfitLabel.text = @"(范围:0~50)";
        self.stopLossLabel.text = @"(范围:0~50)";
        self.stopProfitBtn.maxValue = 50;
        self.stopLossBtn.maxValue = 50;
        self.stopProfitBtn.currentNumber = 0;
        self.stopLossBtn.currentNumber = 0;
        self.handCountBtn.currentNumber = 1;
        self.limitLabel.text = @"已选择1手";
        self.switchBtn.on = NO;
    }
}

- (void)setThicketCount:(NSInteger)thicketCount{
    _thicketCount = thicketCount;
    self.thicketLabel.text = [NSString stringWithFormat:@"使用赢家券(剩余%zd张,每次限用一张)",thicketCount];
    if (thicketCount == 0) {
        self.switchBtn.on = NO;
    }
    if (self.switchBtn.isOn) {
        self.thicketLabel.text = [NSString stringWithFormat:@"使用赢家券(剩余%zd张,每次限用一张)",thicketCount - 1];
//        self.handCountBtn.maxValue = 1;
//        [SVProgressHUD showInfoWithStatus:@"使用券只能购买一手"];
    }
}

@end
