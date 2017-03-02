//
//  GRPropertyResultView.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/5.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRPropertyResultView.h"
#import <CoreText/CoreText.h>
#define labelWidth (K_Screen_Width-26)/4
#define labelMinx 13
@interface GRPropertyResultView ()

@property (nonatomic,strong) UILabel *labelPayMoney;
@property (nonatomic,strong) UILabel *labelCreatPrice;
@property (nonatomic,strong) UILabel *labelBreakevenPrice;
@property (nonatomic,strong) UILabel *labelGainMoney;
@property (nonatomic,strong) UILabel *labelText;
@property (nonatomic,strong) UIButton *buttonStop;
@property (nonatomic,strong) UIButton *buttonAlter;
@property (nonatomic,strong) UIButton *buttonClose;



@end

@implementation GRPropertyResultView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.labelPayMoney];
        [self addSubview:self.labelCreatPrice];
        [self addSubview:self.labelBreakevenPrice];
        [self addSubview:self.labelGainMoney];
        [self addSubview:self.labelText];
        [self addSubview:self.buttonStop];
        [self addSubview:self.buttonAlter];
        [self addSubview:self.buttonClose];
    }
    return self;
}

- (UILabel *)labelPayMoney
{
    if (!_labelPayMoney) {
        _labelPayMoney = [[UILabel alloc] initWithFrame:CGRectMake(labelMinx, 5, labelWidth-20, 15)];
        _labelPayMoney.font = [UIFont systemFontOfSize:11];
        _labelPayMoney.textColor = [UIColor colorWithHexString:@"#333333"];
        _labelPayMoney.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
        _labelPayMoney.layer.borderWidth = 1.0f;
        _labelPayMoney.text = @"买涨 88元";
        
    }
    return _labelPayMoney;
}

- (UILabel *)labelCreatPrice
{
    if (!_labelCreatPrice) {
        _labelCreatPrice = [[UILabel alloc] initWithFrame:CGRectMake(labelMinx+labelWidth-10, CGRectGetMinY(_labelPayMoney.frame),labelWidth+10 , 15)];
        _labelCreatPrice.font = _labelPayMoney.font;
        _labelCreatPrice.textColor = _labelPayMoney.textColor;
        _labelCreatPrice.text = @"建仓价 3888.2";
        [_labelCreatPrice sizeToFit];
    }
    return _labelCreatPrice;
}

- (UILabel *)labelBreakevenPrice
{
    if (!_labelBreakevenPrice) {
        _labelBreakevenPrice = [[UILabel alloc] initWithFrame:CGRectMake(labelMinx+labelWidth*2+5, CGRectGetMinY(_labelPayMoney.frame), CGRectGetWidth(_labelCreatPrice.frame), CGRectGetHeight(_labelCreatPrice.frame))];
        _labelBreakevenPrice.textColor = _labelPayMoney.textColor;
        _labelBreakevenPrice.font = _labelPayMoney.font;
        _labelBreakevenPrice.text = @"保本价 3888.2";
        [_labelBreakevenPrice sizeToFit];
    }
    return  _labelBreakevenPrice;
}

- (UILabel *)labelGainMoney
{
    if (!_labelGainMoney) {
        _labelGainMoney = [[UILabel alloc] initWithFrame:CGRectMake(labelMinx+labelWidth*3+10, CGRectGetMinY(_labelPayMoney.frame)-2, labelWidth-20, CGRectGetHeight(_labelCreatPrice.frame))];
        _labelGainMoney.textColor = _labelPayMoney.textColor;
        CATextLayer *textLayer = [self changeTextColorWithString:@"盈利涨8元" frame:_labelGainMoney.frame];
        [_labelGainMoney.layer addSublayer:textLayer];
        _labelGainMoney.font = _labelPayMoney.font;
    }
    return _labelGainMoney;
}

- (UILabel *)labelText
{
    if (!_labelText) {
        _labelText = [[UILabel alloc] initWithFrame:CGRectMake(labelMinx, CGRectGetMaxY(_labelPayMoney.frame)+5, (K_Screen_Width-13*2-18*3)/4, 25)];
        _labelText.backgroundColor = [UIColor colorWithHexString:@"#f1496c"];
        _labelText.text = @"+0.00";
        _labelText.textAlignment = NSTextAlignmentCenter;
        _labelText.font = [UIFont systemFontOfSize:13];
        _labelText.textColor = [UIColor whiteColor];
    }
    return _labelText;
}

- (UIButton *)buttonStop
{
    if (!_buttonStop) {
        _buttonStop = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonStop.frame = CGRectMake(CGRectGetMaxX(_labelText.frame)+18, CGRectGetMinY(_labelText.frame), CGRectGetWidth(_labelText.frame), CGRectGetHeight(_labelText.frame));
        [_buttonStop setTitle:@"止盈止损" forState:UIControlStateNormal];
        [_buttonStop setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        _buttonStop.titleLabel.font = [UIFont systemFontOfSize:12];
        _buttonStop.layer.borderColor = [UIColor colorWithHexString:@"#cccccc"].CGColor;
        _buttonStop.layer.borderWidth = 1.0f;
        [_buttonStop addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _buttonStop.tag = 100;
    }
    return _buttonStop;
}

- (UIButton *)buttonAlter
{
    if (!_buttonAlter) {
        _buttonAlter = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonAlter.frame = CGRectMake(CGRectGetMaxX(_buttonStop.frame)+18, CGRectGetMinY(_buttonStop.frame), CGRectGetWidth(_buttonStop.frame), CGRectGetHeight(_buttonStop.frame));
        [_buttonAlter setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [_buttonAlter setTitle:@"提醒" forState:UIControlStateNormal];
        _buttonAlter.titleLabel.font = _buttonStop.titleLabel.font;
        [_buttonAlter addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _buttonAlter.tag = 101;
        _buttonAlter.layer.borderColor = _buttonStop.layer.borderColor;
        _buttonAlter.layer.borderWidth = _buttonStop.layer.borderWidth;
    }
    return _buttonAlter;
}
- (UIButton *)buttonClose
{
    if (!_buttonClose) {
        _buttonClose = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonClose.frame = CGRectMake(CGRectGetMaxX(_buttonAlter.frame)+18, CGRectGetMinY(_buttonStop.frame), CGRectGetWidth(_buttonStop.frame), CGRectGetHeight(_buttonStop.frame));
        [_buttonClose setTitle:@"平仓" forState:UIControlStateNormal];
        [_buttonClose setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _buttonClose.titleLabel.font = _buttonStop.titleLabel.font;
        [_buttonClose addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _buttonClose.backgroundColor = [UIColor colorWithHexString:@"#f39800"];
        _buttonClose.tag = 102;
    }
    return _buttonClose;
}

- (void)buttonAction:(UIButton *)sender
{
    [self.delegate buttonBottomAction:sender.tag];
}

- (CATextLayer *)changeTextColorWithString:(NSString *)string frame:(CGRect)frame
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
    [text addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[UIColor colorWithHexString:@"#d43c33"].CGColor range:NSMakeRange(3,string.length-4)];
    CATextLayer *textlayer = [CATextLayer layer];
    textlayer.string = text;
    textlayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    textlayer.contentsScale = 2; //防止模糊
//    textlayer.font = (__bridge CFTypeRef _Nullable)([UIFont systemFontOfSize:11]);
//    textlayer.fontSize = 12;
//    [textlayer setWrapped:YES];//自动换行
//    textlayer.font = (__bridge CFTypeRef _Nullable)(@"HiraKakuProN-W3");
//    textlayer.fontSize = 8;
    
    UIFont *font = [UIFont systemFontOfSize:11];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef =CGFontCreateWithFontName(fontName);
    textlayer.font = fontRef;
    textlayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    return textlayer;
}

@end
