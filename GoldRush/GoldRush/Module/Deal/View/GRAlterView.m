//
//  GRAlterView.m
//  GoldRush
//
//  Created by 徐孟林 on 2016/12/29.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRAlterView.h"

@interface GRAlterView ()
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UILabel *labelLeft;
@property (nonatomic,strong) UILabel *labelRight;

@end


@implementation GRAlterView

- (instancetype)initWithFrame:(CGRect)frame withArray:(NSArray<NSString *> *)text
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        [self addSubview:self.label];
        [self addSubview:self.labelLeft];
        [self addSubview:self.labelRight];
        _label.text = text[0];
        _labelLeft.text = text[1];
        _labelRight.text = text[2];
    }
    return self;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/2)];
        _label.textColor = GRColor(102, 102, 102);
        _label.font = [UIFont systemFontOfSize:15];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = @"你还未开户";
    }
    return _label;
}

- (UILabel *)labelLeft
{
    //3d7aeb
    if (!_labelLeft) {
        _labelLeft = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height/2, self.frame.size.width/2, CGRectGetHeight(_label.frame))];
        _labelLeft.textColor = [UIColor colorWithHexString:@"#3d7aeb"];
        _labelLeft.font = _label.font;
        _labelLeft.textAlignment = NSTextAlignmentCenter;
        _labelLeft.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelLeftAction:)];
        [_labelLeft addGestureRecognizer:tapges];
    }
    return _labelLeft;
}

- (UILabel *)labelRight
{
    if (!_labelRight) {
        _labelRight = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2, CGRectGetMinY(_labelLeft.frame), CGRectGetWidth(_labelLeft.frame), CGRectGetHeight(_labelLeft.frame))];
        _labelRight.textColor = _labelLeft.textColor;
        _labelRight.font = _labelLeft.font;
        _labelRight.textAlignment = NSTextAlignmentCenter;
        _labelRight.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelRightAction:)];
        [_labelRight addGestureRecognizer:tapges];
    }
    return _labelRight;
}

- (void)labelLeftAction:(UITapGestureRecognizer *)sender
{
    
}

- (void)labelRightAction:(UITapGestureRecognizer *)sender
{
    
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor colorWithHexString:@"#cccccc"] setStroke];
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 0.8);
    CGContextMoveToPoint(context, 0, self.frame.size.height/2);
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height/2);
    CGContextMoveToPoint(context, self.frame.size.width, self.frame.size.height/2);
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height);
    CGContextStrokePath(context);
}

@end
