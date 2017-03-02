//
//  GRCloseAlterView.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRCloseAlterView.h"

@interface GRCloseAlterView ()

@property (nonatomic,strong) UILabel *labelTitle;
@property (nonatomic,strong) UIButton *buttonCancel;
@property (nonatomic,strong) UIButton *buttonSure;
@property (nonatomic,strong) UILabel *labelDetail;

@property (nonatomic,strong) NSString *stringKinds;
@property (nonatomic,strong) NSString *stringNew;
@property (nonatomic,strong) NSString *stringWin;
@end

@implementation GRCloseAlterView


- (instancetype)initWithFrame:(CGRect)frame stringKinds:(NSString *)stringKinds stringNew:(NSString *)stringNew stringWin:(NSString *)stringWin
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.stringKinds = stringKinds;
        self.stringNew = stringNew;
        self.stringWin = stringWin;
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        [self addSubview:self.labelTitle];
        [self addSubview:self.labelDetail];
        [self addSubview:self.buttonCancel];
        [self addSubview:self.buttonSure];
    }
    return self;
}

- (UILabel *)labelTitle
{
    if (!_labelTitle) {
        _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
        _labelTitle.text = @"平仓";
        _labelTitle.font = [UIFont systemFontOfSize:20];
        _labelTitle.backgroundColor = [UIColor colorWithHexString:@"#f39800"];
        _labelTitle.textColor = [UIColor whiteColor];
        _labelTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labelTitle;
}

- (UILabel *)labelDetail
{
    if (!_labelDetail) {
        _labelDetail = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-40-18-8, K_Screen_Width, 18)];
        _labelDetail.textAlignment = NSTextAlignmentCenter;
        _labelDetail.textColor = [UIColor colorWithHexString:@"#999999"];
        _labelDetail.font = [UIFont systemFontOfSize:12];
        _labelDetail.text = @"以成交时市价为准";
    }
    return _labelDetail;
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


- (void)buttonAction:(UIButton *)sender
{
    [self.delegate closeAlterButton:sender];
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor] setFill];
    [GRColor(218, 218, 218) setStroke];
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1.0);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(15, 44+15, self.frame.size.width-15*2, 70));
    CGContextAddPath(context, path);
    CGPathRelease(path);
    CGContextMoveToPoint(context, 15+(self.frame.size.width-15*2)/3, 15+44);
    CGContextAddLineToPoint(context, 15+(self.frame.size.width-15*2)/3, 15+70+44);
    
    CGContextMoveToPoint(context, 15+(self.frame.size.width-15*2)/3*2, 15+44);
    CGContextAddLineToPoint(context, 15+(self.frame.size.width-15*2)/3*2, 15+70+44);
    
    CGContextMoveToPoint(context, 15, 15+35+44);
    CGContextAddLineToPoint(context, self.frame.size.width-15, 15+35+44);
    CGContextStrokePath(context);
    NSDictionary *Attribute = @{NSFontAttributeName :[UIFont systemFontOfSize:15],
                                NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"]};
    NSDictionary *attribute1 = @{NSFontAttributeName :[UIFont systemFontOfSize:13],
                                 NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"]};
    [@"品种" drawInRect:CGRectMake(15+4, 44+25, 50, 20) withAttributes:Attribute];
    [@"最新价" drawInRect:CGRectMake(15+4+(self.frame.size.width-15*2)/3, 44+25, 50, 20) withAttributes:Attribute];
    [@"盈亏" drawInRect:CGRectMake(15+4+(self.frame.size.width-15*2)/3*2, 44+25, 50, 20) withAttributes:Attribute];
    [self.stringKinds drawInRect:CGRectMake(15+4, 44+15+45,80, 20) withAttributes:attribute1];
    [self.stringNew drawInRect:CGRectMake(15+4+(self.frame.size.width-15*2)/3, 44+15+45,80, 20) withAttributes:attribute1];
    [self.stringWin drawInRect:CGRectMake(15+4+(self.frame.size.width-15*2)/3*2, 44+15+45,50, 20) withAttributes:attribute1];
    

}

@end
