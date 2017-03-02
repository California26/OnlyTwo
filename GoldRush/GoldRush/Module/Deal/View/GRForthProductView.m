//
//  GRForthProductView.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/4.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRForthProductView.h"
//产品下面的今开，昨收 最高 最低数据
@interface GRForthProductView ()

@end

@implementation GRForthProductView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.labelJK];
        [self addSubview:self.labelZS];
        [self addSubview:self.labelZG];
        [self addSubview:self.labelZD];
    }
    return self;
}


- (UILabel *)labelJK
{
    if (!_labelJK) {
        _labelJK = [[UILabel alloc] initWithFrame:CGRectMake(30+5, 5,(K_Screen_Width-10-30*4)/4, 18)];
        _labelJK.font = [UIFont systemFontOfSize:13];
        _labelJK.textColor = [UIColor colorWithHexString:@"f1496c"];
    }
    return _labelJK;
}

- (UILabel *)labelZS
{
    if (!_labelZS) {
        _labelZS = [[UILabel alloc] initWithFrame:CGRectMake((K_Screen_Width-10)/4+30+5, CGRectGetMinY(_labelJK.frame), CGRectGetWidth(_labelJK.frame), CGRectGetHeight(_labelJK.frame))];
        _labelZS.font = _labelJK.font;
        _labelZS.textColor = _labelJK.textColor;
    }
    return _labelZS;
}

- (UILabel *)labelZG
{
    if (!_labelZG) {
        _labelZG = [[UILabel alloc] initWithFrame:CGRectMake((K_Screen_Width-10)/4*2+30+5,CGRectGetMinY(_labelJK.frame), CGRectGetWidth(_labelJK.frame), CGRectGetHeight(_labelJK.frame))];
        _labelZG.font = _labelJK.font;
        _labelZG.textColor = _labelJK.textColor;
    }
    return _labelZG;
}

- (UILabel *)labelZD
{
    if (!_labelZD) {
        _labelZD = [[UILabel alloc] initWithFrame:CGRectMake((K_Screen_Width-10)/4*3+30+5,CGRectGetMinY(_labelJK.frame), CGRectGetWidth(_labelJK.frame), CGRectGetHeight(_labelJK.frame))];
        _labelZD.font = _labelJK.font;
        _labelZD.textColor = [UIColor colorWithHexString:@"09cb67"];
    }
    return _labelZD;
}



- (void)drawRect:(CGRect)rect
{
    NSDictionary *Attribute = @{NSFontAttributeName :[UIFont systemFontOfSize:11],
                                NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"]};
    [@"今开" drawInRect:CGRectMake(10, 7, 30, 18) withAttributes:Attribute];
    [@"昨收" drawInRect:CGRectMake(10+(K_Screen_Width-10)/4, 7, 30, 18) withAttributes:Attribute];
    [@"最高" drawInRect:CGRectMake(10+(K_Screen_Width-10)/4*2, 7, 30, 18) withAttributes:Attribute];
    [@"最低" drawInRect:CGRectMake(10+(K_Screen_Width-10)/4*3, 7, 30, 18) withAttributes:Attribute];
}

@end
