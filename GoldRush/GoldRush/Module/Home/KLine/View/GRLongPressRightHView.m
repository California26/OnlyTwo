//
//  GRLongPressRightHView.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/2/13.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRLongPressRightHView.h"
#import "GRChart_KLineModel.h"
@interface GRLongPressRightHView ()

@property (nonatomic,strong) UILabel *labelDate;
@property (nonatomic,strong) UILabel *labelHight;
@property (nonatomic,strong) UILabel *labelLow;
@property (nonatomic,strong) UILabel *labelOpen;
@property (nonatomic,strong) UILabel *labelClose;


@end

@implementation GRLongPressRightHView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor colorWithHexString:@"#3d3d4f"];
        [self addSubview:self.labelDate];
        [self addSubview:self.labelOpen];
        [self addSubview:self.labelClose];
        [self addSubview:self.labelHight];
        [self addSubview:self.labelLow];
    }
    return self;
}

- (UILabel *)labelDate
{
    if (!_labelDate) {
        _labelDate = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/5)];
        _labelDate.textColor = [UIColor whiteColor];
        _labelDate.font = [UIFont systemFontOfSize:12];
        _labelDate.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:self.labelDate];
    }
    return _labelDate;
}

- (UILabel *)labelOpen
{
    if (!_labelOpen) {
        _labelOpen = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_labelDate.frame), CGRectGetWidth(_labelDate.frame), CGRectGetHeight(_labelDate.frame))];
        _labelOpen.textAlignment = _labelDate.textAlignment;
        _labelOpen.textColor = _labelDate.textColor;
        _labelOpen.font = _labelDate.font;
//        [self addSubview:self.labelOpen];
    }
    return _labelOpen;
}

- (UILabel *)labelClose
{
    if (!_labelClose) {
        _labelClose = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_labelOpen.frame), CGRectGetWidth(_labelDate.frame), CGRectGetHeight(_labelDate.frame))];
        _labelClose.textAlignment = _labelDate.textAlignment;
        _labelClose.textColor = _labelDate.textColor;
        _labelClose.font = _labelDate.font;
//        [self addSubview:self.labelClose];
    }
    return _labelClose;
}

- (UILabel *)labelHight
{
    if (!_labelHight) {
        _labelHight = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_labelClose.frame), CGRectGetWidth(_labelDate.frame), CGRectGetHeight(_labelDate.frame))];
        _labelHight.textAlignment = _labelDate.textAlignment;
        _labelHight.textColor = _labelDate.textColor;
        _labelHight.font = _labelDate.font;
//        [self addSubview:self.labelHight];
    }
    return _labelHight;
}

- (UILabel *)labelLow
{
    if (!_labelLow) {
        _labelLow = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_labelHight.frame), CGRectGetWidth(_labelDate.frame), CGRectGetHeight(_labelDate.frame))];
        _labelLow.textAlignment = _labelDate.textAlignment;
        _labelLow.textColor = _labelDate.textColor;
        _labelLow.font = _labelDate.font;
//        [self addSubview:self.labelLow];
    }
    return _labelLow;
}

- (void)setModel:(GRChart_KLineModel *)model
{
    _model = model;
    _labelDate.text = [model.date substringWithRange:NSMakeRange(5, 11)];
    _labelOpen.text =  [NSString stringWithFormat:@"开盘  %.0f",model.open.floatValue];
    _labelClose.text = [NSString stringWithFormat:@"收盘  %.0f",model.close.floatValue];
    _labelHight.text = [NSString stringWithFormat:@"最高  %.0f",model.hight.floatValue];
    _labelLow.text =   [NSString stringWithFormat:@"最低  %.0f",model.low.floatValue];
}


@end
