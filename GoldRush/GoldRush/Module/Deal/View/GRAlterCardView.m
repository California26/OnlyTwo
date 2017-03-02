//
//  GRAlterCardView.m
//  GoldRush
//
//  Created by 徐孟林 on 2016/12/29.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRAlterCardView.h"

@interface GRAlterCardView ()

@property (nonatomic,strong) UILabel *labelTitle;
@property (nonatomic,strong) UILabel *icon;
@property (nonatomic,strong) UILabel *label1;
@property (nonatomic,strong) UILabel *label2;
@property (nonatomic,strong) UILabel *labelNewPrice;
@property (nonatomic,strong) UILabel *labelPoundage;
@property (nonatomic,strong) UIButton *buttonCancel;
@property (nonatomic,strong) UIButton *buttonSure;

@end

@implementation GRAlterCardView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 3.0f;
        self.layer.masksToBounds = YES;
        [self addSubview:self.labelTitle];
        [self addSubview:self.icon];
        [self addSubview:self.label1];
        [self addSubview:self.label2];
        [self addSubview:self.labelNewPrice];
        [self addSubview:self.labelPoundage];
        [self addSubview:self.buttonCancel];
        [self addSubview:self.buttonSure];
    }
    return self;
}
- (UILabel *)labelTitle
{
    if (!_labelTitle) {
        _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 44)];
        _labelTitle.font = [UIFont systemFontOfSize:18];
    }
    return _labelTitle;
}

- (UILabel *)icon
{
    if (!_icon) {
        _icon = [[UILabel alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(_labelTitle.frame)+13, 18, 18)];
        _icon.text = @"注";
        _icon.textColor = [UIColor whiteColor];
        _icon.font = [UIFont systemFontOfSize:11];
    }
    return _icon;
}

- (UILabel *)label1
{
    if (!_label1) {
        _label1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_icon.frame)+8, CGRectGetMaxY(_labelTitle.frame)+5, self.frame.size.width-50, 17)];
        _label1.text = @"*暂不支持过夜，收盘后自动结算平仓";
        _label1.textColor = [UIColor colorWithHexString:@"#666666"];
        _label1.font = _icon.font;
    }
    return _label1;
}

- (UILabel *)label2
{
    if (!_label1) {
        _label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_icon.frame)+8, CGRectGetMaxY(_label1.frame)+5, self.frame.size.width-50, 17)];
        _label2.text = @"*只能持仓一笔平仓才可以建新单";
        _label2.textColor = [UIColor colorWithHexString:@"#666666"];
        _label2.font = _icon.font;
    }
    return _label2;
}

- (UILabel *)labelNewPrice
{
    if (!_labelNewPrice) {
        _labelNewPrice = [[UILabel alloc] initWithFrame:CGRectMake(8, 88+12, self.frame.size.width/2, 20)];
        _labelNewPrice.font = [UIFont systemFontOfSize:13];
        _labelNewPrice.textColor = [UIColor colorWithHexString:@"#666666"];
        
    }
    return _labelNewPrice;
}

- (UILabel *)labelPoundage
{
    if (!_labelPoundage) {
        _labelPoundage = [[UILabel alloc] initWithFrame:CGRectMake(K_Screen_Width-13-17, CGRectGetMinY(_labelNewPrice.frame), CGRectGetWidth(_labelNewPrice.frame), CGRectGetHeight(_labelNewPrice.frame))];
        _labelPoundage.font = _labelNewPrice.font;
        _labelPoundage.textColor = _labelNewPrice.textColor;
        _labelPoundage.textAlignment = NSTextAlignmentRight;
    }
    return _labelPoundage;
}

- (UIButton *)buttonCancel
{
    if (!_buttonCancel) {
        _buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonCancel setTitle:@"取消" forState:UIControlStateNormal];
        [_buttonCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _buttonCancel.titleLabel.font = [UIFont systemFontOfSize:15];
        _buttonCancel.frame = CGRectMake(26, 44*3+20, self.frame.size.width-26*2-42, 30);
        [_buttonCancel addTarget:self action:@selector(cacelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _buttonCancel.backgroundColor = [UIColor colorWithHexString:@"#b8b8b8"];
    }
    return _buttonCancel;
}

- (UIButton *)buttonSure
{
    if (!_buttonSure) {
        _buttonSure = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonSure setTitle:@"确定" forState:UIControlStateNormal];
        [_buttonSure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _buttonSure.titleLabel.font = _buttonCancel.titleLabel.font;
        _buttonSure.frame = CGRectMake(CGRectGetMaxX(_buttonCancel.frame)+21, CGRectGetMinY(_buttonCancel.frame), CGRectGetWidth(_buttonCancel.frame), CGRectGetHeight(_buttonCancel.frame));
        [_buttonSure addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _buttonSure.backgroundColor = [UIColor colorWithHexString:@"#00a0e9"];
    }
    return _buttonSure;
}


- (void)setStringTitle:(NSString *)stringTitle
{
    _labelTitle.text = stringTitle;
}
- (void)cacelBtnAction:(UIButton *)sender
{
    
}

- (void)sureBtnAction:(UIButton *)sender
{
    
}



- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context,kCGLineCapRound);
    CGContextSetLineWidth(context, 0.8);
    [[UIColor colorWithHexString:@"#cccccc"] setStroke];
    CGContextMoveToPoint(context, 0, 88);
    CGContextAddLineToPoint(context, self.frame.size.width, 88);
    
    CGContextMoveToPoint(context, 0, 122);
    CGContextAddLineToPoint(context, self.frame.size.width, 122);
    CGContextStrokePath(context);
}

@end
