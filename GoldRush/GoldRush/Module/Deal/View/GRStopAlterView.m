//
//  GRStopAlterView.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRStopAlterView.h"
#import "GRStopButton.h"
@interface GRStopAlterView ()<GRStopButtonDelegate>

@property (nonatomic,strong) UILabel *labelTitle;
@property (nonatomic,strong) UILabel *labelWinLeft;
@property (nonatomic,strong) UILabel *labelWinRight;
@property (nonatomic,strong) GRStopButton *buttonWin;
@property (nonatomic,strong) GRStopButton *buttonLose;
@property (nonatomic,strong) UILabel *labelloseLeft;
@property (nonatomic,strong) UILabel *labelLoseRight;
@property (nonatomic,strong) UIButton *buttonCancel;
@property (nonatomic,strong) UIButton *buttonSure;
@end

@implementation GRStopAlterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        [self addSubview:self.labelTitle];
        [self addSubview:self.buttonWin];
        [self addSubview:self.labelWinLeft];
        [self addSubview:self.labelWinRight];
        [self addSubview:self.buttonLose];
        [self addSubview:self.labelloseLeft];
        [self addSubview:self.labelLoseRight];
        [self addSubview:self.buttonCancel];
        [self addSubview:self.buttonSure];
    }
    return self;
}

- (UILabel *)labelTitle
{
    if (!_labelTitle) {
        _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
        _labelTitle.text = @"止盈止损";
        _labelTitle.font = [UIFont systemFontOfSize:18];
        _labelTitle.textColor = [UIColor whiteColor];
        _labelTitle.backgroundColor = [UIColor colorWithHexString:@"#00a0e9"];
        _labelTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labelTitle;
}

///止盈
- (GRStopButton *)buttonWin
{
    if (!_buttonWin) {
        _buttonWin = [[GRStopButton alloc] initWithFrame:CGRectMake(self.frame.size.width/2-75, 44+20, 150, 30)];
        _buttonWin.delegate = self;
        _buttonWin.tag = 100;
        _buttonWin.borderColor = [UIColor grayColor];
        _buttonWin.increaseTitle = @"＋";
        _buttonWin.decreaseTitle = @"－";
        _buttonWin.buttonTitleFont = 20;
        _buttonWin.maxValue = 50;
        _buttonWin.minValue = 0;
        _buttonWin.shakeAnimation = YES;
        _buttonWin.currentNumber = self.topLimit.integerValue;
    }
    return _buttonWin;
}

- (UILabel *)labelWinLeft
{
    if (!_labelWinLeft) {
        _labelWinLeft = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2-75-15-60, CGRectGetMinY(_buttonWin.frame)+5, 60, 20)];
        _labelWinLeft.font = [UIFont systemFontOfSize:15];
        _labelWinLeft.textColor = [UIColor colorWithHexString:@"#333333"];
        _labelWinLeft.textAlignment = NSTextAlignmentRight;
        _labelWinLeft.text = @"止盈";
    }
    return _labelWinLeft;
}

- (UILabel *)labelWinRight
{
    if (!_labelWinRight) {
        _labelWinRight = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2+75+5, CGRectGetMinY(_labelWinLeft.frame), 90, 20)];
        _labelWinRight.text = @"(范围:0~50)";
        _labelWinRight.textColor = _labelWinLeft.textColor;
        _labelWinRight.font = [UIFont systemFontOfSize:12];
    }
    return _labelWinRight;
}

///止损
- (GRStopButton *)buttonLose
{
    if (!_buttonLose) {
        _buttonLose = [[GRStopButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(_buttonWin.frame), CGRectGetMaxY(_buttonWin.frame)+20, CGRectGetWidth(_buttonWin.frame), CGRectGetHeight(_buttonWin.frame))];
        _buttonLose.delegate = self;
        _buttonLose.tag = 101;
        _buttonLose.borderColor = [UIColor grayColor];
        _buttonLose.increaseTitle = @"＋";
        _buttonLose.decreaseTitle = @"－";
        _buttonLose.buttonTitleFont = 20;
        _buttonLose.maxValue = 50;
        _buttonLose.minValue = 0;
        _buttonLose.shakeAnimation = YES;
        _buttonLose.currentNumber = self.bottomLimit.integerValue;
    }
    return _buttonLose;
}

- (UILabel *)labelloseLeft
{
    if (!_labelloseLeft) {
        _labelloseLeft = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2-75-15-60, CGRectGetMinY(_buttonLose.frame)+5, 60, 20)];
        _labelloseLeft.font = [UIFont systemFontOfSize:15];
        _labelloseLeft.textColor = [UIColor colorWithHexString:@"#333333"];
        _labelloseLeft.textAlignment = NSTextAlignmentRight;
        _labelloseLeft.text = @"止损";
    }
    return _labelloseLeft;
}


- (UILabel *)labelLoseRight
{
    if (!_labelLoseRight) {
        _labelLoseRight = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2+75+5, CGRectGetMinY(_labelloseLeft.frame), 90, 20)];
        _labelLoseRight.text = @"(范围:0~50)";
        _labelLoseRight.textColor = _labelWinLeft.textColor;
        _labelLoseRight.font = [UIFont systemFontOfSize:12];
    }
    return _labelLoseRight;
}


- (UIButton *)buttonCancel
{
    if (!_buttonCancel) {
        _buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonCancel.frame = CGRectMake(self.frame.size.width/2-20-100, self.frame.size.height-40, 100, 30);
        [_buttonCancel setTitle:@"取消" forState:UIControlStateNormal];
        [_buttonCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _buttonCancel.titleLabel.font = [UIFont systemFontOfSize:15];
        _buttonCancel.backgroundColor = [UIColor colorWithHexString:@"#b8b8b8"];
        [_buttonCancel addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _buttonCancel.tag = 100;
    }
    return _buttonCancel;
}

- (UIButton *)buttonSure
{
    if (!_buttonSure) {
        _buttonSure = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonSure.frame = CGRectMake(self.frame.size.width/2+20, CGRectGetMinY(_buttonCancel.frame), CGRectGetWidth(_buttonCancel.frame), CGRectGetHeight(_buttonCancel.frame));
        [_buttonSure setTitle:@"确定" forState:UIControlStateNormal];
        [_buttonSure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _buttonSure.backgroundColor = [UIColor colorWithHexString:@"#00a0e9"] ;
        _buttonSure.titleLabel.font = _buttonCancel.titleLabel.font;
        [_buttonSure addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _buttonSure.tag = 101;
    }
    return _buttonSure;
}

- (void)setTopLimit:(NSString *)topLimit
{
    _topLimit = topLimit;
    _buttonWin.currentNumber = _topLimit.floatValue * 100;
}

- (void)setBottomLimit:(NSString *)bottomLimit
{
    _bottomLimit = bottomLimit;
    _buttonLose.currentNumber = _bottomLimit.floatValue * 100;
}

- (void)setMaxTop:(NSInteger)maxTop
{
    _maxTop = maxTop;
    _buttonWin.maxValue = maxTop;
    _labelWinRight.text = [NSString stringWithFormat:@"范围(0~%ld)",(long)maxTop];
}

- (void)setMinBottom:(NSInteger)minBottom
{
    _minBottom = minBottom;
    _buttonLose.maxValue = minBottom;
    _labelLoseRight.text = [NSString stringWithFormat:@"范围(0~%ld)",(long)minBottom];
}

- (void)buttonAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(stopAlterButton:)]) {
        [self.delegate stopAlterButton:sender];
    }
}

- (void)gr_numberButton:(__kindof UIView *)numberButton number:(NSInteger)number increaseStatus:(BOOL)increaseStatus
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(getWinOrLoseNumber:number:)]) {
        [self.delegate getWinOrLoseNumber:numberButton number:number];
    }
}
@end
