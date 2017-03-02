//
//  GRChartHeaderView.m
//  GoldRush
//
//  Created by 徐孟林 on 2016/12/26.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRChartHeaderView.h"

@interface GRChartHeaderView ()

@property (nonatomic,strong) UIButton *button1;
@property (nonatomic,strong) UIButton *button2;
@property (nonatomic,strong) UIButton *button3;
@property (nonatomic,strong) UIButton *button4;
@property (nonatomic,strong) UIButton *button5;
@property (nonatomic,strong) UIButton *button6;
@property (nonatomic,strong) UIView   *lineRedView;
@property (nonatomic,assign) CGFloat redViewWidth;
@end

@implementation GRChartHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        if (iPhone4 || iPhone5) {
            _redViewWidth = 30;
        }else if(iPhone6 ){
            _redViewWidth = 40;
        }else if(iPhone6P){
            _redViewWidth = 50;
        }
        
        [self addSubview:self.button1];
        [self addSubview:self.button2];
        [self addSubview:self.button3];
        [self addSubview:self.button4];
        [self addSubview:self.button5];
        [self addSubview:self.button6];
        [self addSubview:self.lineRedView];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self creatLineView];
    
}
- (void)creatLineView
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, .5f);
    [GRColor(218, 218, 218) setStroke];
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, 35-.5);
    CGContextAddLineToPoint(context, K_Screen_Width, 35-.5);
    CGContextStrokePath(context);
}

- (UIButton *)button1
{
    if (!_button1) {
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button1.frame = CGRectMake(0, 0, K_Screen_Width/6, self.frame.size.height);
        [_button1 setTitle:@"分时" forState:UIControlStateNormal];
        [_button1 setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        _button1.titleLabel.font = [UIFont systemFontOfSize:12];
        [_button1 addTarget:self action:@selector(button1Action:) forControlEvents:UIControlEventTouchUpInside];
        _button1.tag = 100;
    }
    return _button1;
}

- (UIButton *)button2
{
    if (!_button2) {
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button2.frame = CGRectMake(CGRectGetMaxX(_button1.frame), CGRectGetMinY(_button1.frame), CGRectGetWidth(_button1.frame), CGRectGetHeight(_button1.frame));
        [_button2 setTitle:@"5分" forState:UIControlStateNormal];
        [_button2 setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        _button2.titleLabel.font = _button1.titleLabel.font;
        [_button2 addTarget:self action:@selector(button2Action:) forControlEvents:UIControlEventTouchUpInside];
        _button2.tag = 101;
    }
    return _button2;
}

- (UIButton *)button3
{
    if (!_button3) {
        _button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button3.frame = CGRectMake(CGRectGetMaxX(_button2.frame), CGRectGetMinY(_button1.frame),CGRectGetWidth(_button1.frame), CGRectGetHeight(_button1.frame));
        [_button3 setTitle:@"15分" forState:UIControlStateNormal];
        [_button3 setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        _button3.titleLabel.font = _button1.titleLabel.font;
        [_button3 addTarget:self action:@selector(button3Action:) forControlEvents:UIControlEventTouchUpInside];
        _button3.tag = 102;
    }
    return _button3;
}

- (UIButton *)button4
{
    if (!_button4) {
        _button4 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button4.frame = CGRectMake(CGRectGetMaxX(_button3.frame), CGRectGetMinY(_button1.frame), CGRectGetWidth(_button1.frame), CGRectGetHeight(_button1.frame));
        [_button4 setTitle:@"30分" forState:UIControlStateNormal];
        [_button4 setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        _button4.titleLabel.font = _button1.titleLabel.font;
        [_button4 addTarget:self action:@selector(button4Action:) forControlEvents:UIControlEventTouchUpInside];
        _button4.tag = 103;
    }
    return _button4;
}

- (UIButton *)button5
{
    if (!_button5) {
        _button5 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button5.frame = CGRectMake(CGRectGetMaxX(_button4.frame), CGRectGetMinY(_button1.frame), CGRectGetWidth(_button1.frame), CGRectGetHeight(_button1.frame));
        [_button5 setTitle:@"60分" forState:UIControlStateNormal];
        _button5.titleLabel.font = _button1.titleLabel.font;
        [_button5 setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [_button5 addTarget:self action:@selector(button5Action:) forControlEvents:UIControlEventTouchUpInside];
        _button5.tag = 104;
    }
    return _button5;
}

- (UIButton *)button6
{
    if (!_button6) {
        _button6 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button6.frame = CGRectMake(CGRectGetMaxX(_button5.frame), CGRectGetMinY(_button1.frame), CGRectGetWidth(_button1.frame), CGRectGetHeight(_button1.frame));
        [_button6 setImage:[UIImage imageNamed:@"detail"] forState:UIControlStateNormal];
        [_button6 addTarget:self action:@selector(button6Action:) forControlEvents:UIControlEventTouchUpInside];
        _button6.tag = 105;
    }
    return _button6;
}
- (UIView *)lineRedView
{
    if (!_lineRedView) {
        _lineRedView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(_button1.frame)-_redViewWidth/2, self.frame.size.height-2, _redViewWidth, 2)];
        _lineRedView.backgroundColor = mainColor;
    }
    return _lineRedView;
}


- (void)button1Action:(UIButton *)sender
{
    [self.delegate buttonChartTypeAction:sender];
    [UIView animateWithDuration:0.1 animations:^{
        _lineRedView.frame = CGRectMake(CGRectGetMidX(_button1.frame)-_redViewWidth/2, self.frame.size.height-2, _redViewWidth, 2);
    }];
    
}
- (void)button2Action:(UIButton *)sender
{
    [self.delegate buttonChartTypeAction:sender];
    [UIView animateWithDuration:0.1 animations:^{
    _lineRedView.frame = CGRectMake(CGRectGetMidX(_button2.frame)-_redViewWidth/2, self.frame.size.height-2, _redViewWidth, 2);
    }];
}
- (void)button3Action:(UIButton *)sender
{
    [self.delegate buttonChartTypeAction:sender];
    [UIView animateWithDuration:0.1 animations:^{
    _lineRedView.frame = CGRectMake(CGRectGetMidX(_button3.frame)-_redViewWidth/2, self.frame.size.height-2, _redViewWidth, 2);
    }];
}
- (void)button4Action:(UIButton *)sender
{
    [self.delegate buttonChartTypeAction:sender];
    [UIView animateWithDuration:0.1 animations:^{
    _lineRedView.frame = CGRectMake(CGRectGetMidX(_button4.frame)-_redViewWidth/2, self.frame.size.height-2, _redViewWidth, 2);
    }];
}
- (void)button5Action:(UIButton *)sender
{
    [self.delegate buttonChartTypeAction:sender];
    [UIView animateWithDuration:0.1 animations:^{
        _lineRedView.frame = CGRectMake(CGRectGetMidX(_button5.frame)-_redViewWidth/2, self.frame.size.height-2, _redViewWidth, 2);
    }];

}

- (void)button6Action:(UIButton *)sender
{

    [self.delegate buttonChartTypeImageAction];
    [UIView animateWithDuration:0.1 animations:^{
        _lineRedView.frame = CGRectMake(CGRectGetMidX(_button6.frame)-_redViewWidth/2, self.frame.size.height-2, _redViewWidth, 2);
    }];
}



@end
