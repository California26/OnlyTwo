//
//  GRChart_LeftPriceView.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/16.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRChart_LeftPriceView.h"


@interface GRChart_LeftPriceView ()
@property (nonatomic,strong) UILabel *labelHightest;
@property (nonatomic,strong) UILabel *labelHighter;
@property (nonatomic,strong) UILabel *labelMid;
@property (nonatomic,strong) UILabel *labelLower;
@property (nonatomic,strong) UILabel *labelLowest;

@end
@implementation GRChart_LeftPriceView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.labelHightest];
        [self addSubview:self.labelHighter];
        [self addSubview:self.labelMid];
        [self addSubview:self.labelLower];
        [self addSubview:self.labelLowest];
    }
    
    return self;
}

- (UILabel *)labelHightest
{
    if (!_labelHightest) {
        _labelHightest = [[UILabel alloc] initWithFrame:CGRectMake(5, 0,self.frame.size.width, 15)];
        _labelHightest.textColor = [UIColor colorWithHexString:@"#f1496c"];
        _labelHightest.font = [UIFont systemFontOfSize:10];
        _labelHightest.backgroundColor = [UIColor clearColor];
    }
    return _labelHightest;
}

- (UILabel *)labelHighter
{
    if (!_labelHighter) {
        _labelHighter = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_labelHightest.frame), self.frame.size.height/4, CGRectGetWidth(_labelHightest.frame), CGRectGetHeight(_labelHightest.frame))];
        _labelHighter.textColor = _labelHightest.textColor;
        _labelHighter.font = _labelHightest.font;
        _labelHighter.backgroundColor = [UIColor clearColor];
    }
    return _labelHighter;
}

- (UILabel *)labelMid
{
    if (!_labelMid) {
        _labelMid = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_labelHightest.frame), self.frame.size.height/4*2, CGRectGetWidth(_labelHightest.frame), CGRectGetHeight(_labelHightest.frame))];
        _labelMid.textColor = [UIColor whiteColor];
        _labelMid.font = _labelHightest.font;
        _labelMid.backgroundColor = [UIColor clearColor];
    }
    return _labelMid;
}

- (UILabel *)labelLower
{
    if (!_labelLower) {
        _labelLower = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_labelHightest.frame), self.frame.size.height/4*3, CGRectGetWidth(_labelHightest.frame), CGRectGetHeight(_labelHightest.frame))];
        _labelLower.font = _labelHightest.font;
        _labelLower.textColor = [UIColor colorWithHexString:@"#09cb67"];
        _labelLower.backgroundColor = [UIColor clearColor];
    }
    return _labelLower;
}

- (UILabel *)labelLowest
{
    if (!_labelLowest) {
        _labelLowest = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_labelHightest.frame), self.frame.size.height-CGRectGetHeight(_labelHightest.frame), CGRectGetWidth(_labelHightest.frame), CGRectGetHeight(_labelHightest.frame))];
        _labelLowest.font = _labelHightest.font;
        _labelLowest.textColor = [UIColor colorWithHexString:@"#09cb67"];
        _labelLowest.backgroundColor = [UIColor clearColor];
    }
    return _labelLowest;
}

- (void)setMaxValue:(CGFloat)maxValue
{
    _maxValue = maxValue;
    self.labelHightest.text = [NSString stringWithFormat:@"%.2f",maxValue];
}
- (void)setMinValue:(CGFloat)minValue
{
    _minValue = minValue;
    self.labelLowest.text = [NSString stringWithFormat:@"%.2f",minValue];
}

- (void)setMiddleValue:(CGFloat)middleValue
{
    _middleValue = middleValue;
    self.labelMid.text = [NSString stringWithFormat:@"%.0f",middleValue];
}

- (void)setMinLabelText:(NSString *)minLabelText
{
    _minLabelText = minLabelText;
    self.labelLowest.text = minLabelText;
}
@end
