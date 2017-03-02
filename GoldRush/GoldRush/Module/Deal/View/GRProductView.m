//
//  GRProductView.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/3.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRProductView.h"

@interface GRProductView ()
@property (nonatomic,strong) UILabel *labelTitle;
@property (nonatomic,strong) UILabel *labelNumber;
@property (nonatomic,strong) UILabel *labelClose;

@end

@implementation GRProductView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.labelTitle];
        [self addSubview:self.labelNumber];
    }
    return self;
}

- (UILabel *)labelTitle
{
    if (!_labelTitle) {
        _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, self.frame.size.width, 18)];
        _labelTitle.font = [UIFont systemFontOfSize:13];
        _labelTitle.textColor  = [UIColor colorWithHexString:@"#333333"];
        _labelTitle.font = [UIFont systemFontOfSize:14];
        _labelTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labelTitle;
}

- (UILabel *)labelNumber
{
    if (!_labelNumber) {
        _labelNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_labelTitle.frame), CGRectGetWidth(_labelTitle.frame), CGRectGetHeight(_labelTitle.frame))];
        _labelNumber.font = [UIFont systemFontOfSize:12];
        _labelNumber.textAlignment = NSTextAlignmentCenter;
    }
    return _labelNumber;
}

- (void)setTitle:(NSString *)title
{
    _labelTitle.text = title;
}

- (void)setNumber:(NSString *)number
{
    _labelNumber.text = number;
}

- (void)setIsUpOrDown:(BOOL)isUpOrDown
{
    _isUpOrDown = isUpOrDown;
    if (isUpOrDown) {
        _labelNumber.textColor = [UIColor colorWithHexString:@"#f1496c"];
    }else{
        _labelNumber.textColor = [UIColor colorWithHexString:@"#09cb67"];
    }
}

- (UILabel *)labelClose
{
    if (!_labelClose) {
        _labelClose = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2+23, CGRectGetMinY(_labelTitle.frame), 12, CGRectGetHeight(_labelTitle.frame)-5)];
        _labelClose.text = @"休";
        _labelClose.font = [UIFont systemFontOfSize:12];
        _labelClose.textColor = [UIColor whiteColor];
        _labelClose.backgroundColor = [UIColor colorWithHexString:@"dcdada"];
        _labelClose.layer.cornerRadius = 3.0f;
        _labelClose.layer.masksToBounds = YES;
    }
    return _labelClose;
}

- (void)setIsClose:(BOOL)isClose
{
    _isClose = isClose;
    if (isClose) {
        [self.labelTitle addSubview:self.labelClose];
    }else{
        [self.labelClose removeFromSuperview];
    }
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor colorWithHexString:@"#cccccc"] setStroke];
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1.0);
    CGContextMoveToPoint(context, self.frame.size.width, 5);
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height-10);
//    CGContextMoveToPoint(context, 0, self.frame.size.height-1);
//    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height-1);
    CGContextStrokePath(context);
}

@end
