//
//  GRProductClickView.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/3.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRProductClickView.h"
#import "GRRiseAnimationView.h"

@interface GRProductClickView ()

@property (nonatomic,strong) UILabel *labelTitle;
@property (nonatomic,strong) UILabel *labelNumber;
@property (nonatomic,strong) UILabel *labelLeft;
@property (nonatomic,strong) UILabel *labelRight;
@property (nonatomic,strong) GRRiseAnimationView *animationView;
@property (nonatomic,strong) UIView *viewLine;

@property (nonatomic,strong) UILabel *labelClose;

@end

@implementation GRProductClickView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        [self addSubview:self.labelTitle];
        [self addSubview:self.labelNumber];
        [self addSubview:self.labelLeft];
        [self addSubview:self.labelRight];
        [self addSubview:self.viewLine];
        [self addSubview:self.animationView];
        [self addshadow];
    }
    return self;
}

- (void)addshadow
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    view.backgroundColor = [UIColor clearColor];
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:view.bounds];
    view.layer.masksToBounds = NO;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(0.0f, -5.0f);
    view.layer.shadowOpacity = 1.0f;
    view.layer.shadowPath = shadowPath.CGPath;
    [self addSubview:view];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, self.frame.size.height)];
    leftView.backgroundColor = [UIColor clearColor];
    UIBezierPath *shadowPathLeft = [UIBezierPath bezierPathWithRect:leftView.bounds];
    leftView.layer.masksToBounds = NO;
    leftView.layer.shadowColor = [UIColor blackColor].CGColor;
    leftView.layer.shadowOffset = CGSizeMake(2.0f, 0.0);
    leftView.layer.shadowOpacity = 0.5f;
    leftView.layer.shadowPath = shadowPathLeft.CGPath;
    [self addSubview:leftView];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width-1, 0,1 , self.frame.size.height)];
    rightView.backgroundColor = [UIColor clearColor];
    UIBezierPath *shadowPathright = [UIBezierPath bezierPathWithRect:leftView.bounds];
    rightView.layer.masksToBounds = NO;
    rightView.layer.shadowColor = [UIColor blackColor].CGColor;
    rightView.layer.shadowOffset = CGSizeMake(-2.0f, 0.0);
    rightView.layer.shadowOpacity = 0.5f;
    rightView.layer.shadowPath = shadowPathright.CGPath;
    [self addSubview:rightView];
}

- (UILabel *)labelTitle
{
    if (!_labelTitle) {
        _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, self.frame.size.width/3*2, 18)];
        _labelTitle.font = [UIFont systemFontOfSize:13];
        _labelTitle.textColor  = [UIColor colorWithHexString:@"#333333"];
        _labelTitle.font = [UIFont systemFontOfSize:14];
        _labelTitle.textAlignment = NSTextAlignmentRight;
    }
    return _labelTitle;
}

- (UILabel *)labelNumber
{
    if (!_labelNumber) {
        _labelNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_labelTitle.frame)-2, self.frame.size.width/3*2, 18)];
        _labelNumber.font = [UIFont systemFontOfSize:18];
        _labelNumber.textAlignment = NSTextAlignmentRight;
    }
    return _labelNumber;
}

- (GRRiseAnimationView *)animationView
{
    if (!_animationView) {
        _animationView = [[GRRiseAnimationView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_labelNumber.frame), CGRectGetMinY(_labelNumber.frame), 20, 20)];
    }
    return _animationView;
}

- (UILabel *)labelLeft
{
    if (!_labelLeft) {
        _labelLeft = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_labelNumber.frame)-3, self.frame.size.width/2-5, 13)];
        _labelLeft.textAlignment = NSTextAlignmentRight;
        _labelLeft.font = [UIFont systemFontOfSize:10];
    }
    return _labelLeft;
}

-(UILabel *)labelRight
{
    if (!_labelRight) {
        _labelRight = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2+5, CGRectGetMinY(_labelLeft.frame), CGRectGetWidth(_labelLeft.frame), CGRectGetHeight(_labelLeft.frame))];
        _labelRight.font = _labelLeft.font;
        _labelRight.textAlignment = NSTextAlignmentLeft;
    }
    return _labelRight;
}

- (UIView *)viewLine
{
    if (!_viewLine) {
        _viewLine = [[UIView alloc] initWithFrame:CGRectMake(15, self.frame.size.height-4, self.frame.size.width-30, 4)];
        _viewLine.backgroundColor = mainColor;
    }
    return _viewLine;
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
    if (isUpOrDown == YES) {//涨
        _labelNumber.textColor = [UIColor colorWithHexString:@"#f1496c"];
        _labelLeft.textColor = _labelNumber.textColor;
        _labelRight.textColor = _labelNumber.textColor;
        self.animationView.animationDirection = AnimationDirectionFromBottomToTop;
    }else{//跌
        _labelNumber.textColor = [UIColor colorWithHexString:@"#09cb67"];
        _labelLeft.textColor = _labelNumber.textColor;
        _labelRight.textColor = _labelNumber.textColor;
        self.animationView.animationDirection = AnimationDirectionFromTopToBottom;
    }
}

- (void)setStringLeft:(NSString *)stringLeft
{
    _stringLeft = stringLeft;
    if ([stringLeft containsString:@"-"]) {
        _labelLeft.text = stringLeft;
    }else{
        _labelLeft.text = [NSString stringWithFormat:@"+%@",stringLeft];
    }
}

- (void)setStringRight:(NSString *)stringRight
{
    _stringRight = stringRight;
    if ([stringRight containsString:@"-"]) {
        _labelRight.text = stringRight;
    }else{
        _labelRight.text = [NSString stringWithFormat:@"+%@",stringRight];
    }
}


- (UILabel *)labelClose
{
    if (!_labelClose) {
        _labelClose = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_labelTitle.frame), CGRectGetMinY(_labelTitle.frame), self.frame.size.width/3-8, CGRectGetHeight(_labelTitle.frame))];
        _labelClose.text = @"休市中";
        _labelClose.textColor = [UIColor whiteColor];
        _labelClose.font = [UIFont systemFontOfSize:10];
        _labelClose.textAlignment = NSTextAlignmentCenter;
        _labelClose.backgroundColor = [UIColor colorWithHexString:@"dcdada"] ;
        _labelClose.layer.cornerRadius = 5.0f;
        _labelClose.layer.masksToBounds = YES;
    }
    return _labelClose;
}
- (void)setIsClose:(BOOL)isClose
{
    _isClose = isClose;
    if (isClose) {
        [self addSubview:self.labelClose];
    }else{
        [self.labelClose removeFromSuperview];
    }
}

//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [[UIColor colorWithHexString:@"#cccccc"] setStroke];
//    CGContextSetLineCap(context, kCGLineCapRound);
//    CGContextSetLineWidth(context, 1.0f);
//    CGContextMoveToPoint(context, self.frame.size.width, 5);
//    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height-10);
//    CGContextStrokePath(context);
//}

@end
