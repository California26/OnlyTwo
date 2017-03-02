//
//  GRPropertyLoopAnimationView.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/5.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRPropertyLoopAnimationView.h"

/** 循环动画 */
#import "GRLoopAnimation.h"

#define animationViewWidth (K_Screen_Width - 26)

@interface GRPropertyLoopAnimationView ()
@property (nonatomic,strong) UILabel *riseLabel;
@property (nonatomic,strong) UILabel *fallLabel;
@property (nonatomic,strong) GRLoopAnimation *leftAnimationView;
@property (nonatomic,strong) GRLoopAnimation *rightAnimationView;

@end

@implementation GRPropertyLoopAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.riseRate = @"0.9";
        //创建下部动画
        [self createAnimationView];
    }
    return self;
}

- (void)createAnimationView{
    _riseLabel = [[UILabel alloc] init];
//    riseLabel.textColor = [UIColor colorWithHexString:@"#f1496c"];
    _riseLabel.textColor = [UIColor blackColor];
    _riseLabel.font = [UIFont boldSystemFontOfSize:8];
    _riseLabel.text = [NSString stringWithFormat:@"买涨%.0f%%",self.riseRate.floatValue * 100];
    _riseLabel.backgroundColor = [UIColor clearColor];
    _riseLabel.textAlignment = NSTextAlignmentLeft;
    _fallLabel = [[UILabel alloc] init];
//    fallLabel.textColor = [UIColor colorWithHexString:@"#09cb67"];
    _fallLabel.textColor = [UIColor blackColor];
    _fallLabel.font = [UIFont boldSystemFontOfSize:8];
    _fallLabel.text = [NSString stringWithFormat:@"买跌%.0f%%",(1 - self.riseRate.floatValue) * 100];
    _fallLabel.backgroundColor = [UIColor clearColor];
    _fallLabel.textAlignment = NSTextAlignmentRight;
    
    CGFloat rise = self.riseRate.floatValue;
    _leftAnimationView = [[GRLoopAnimation alloc] initWithFrame:CGRectMake(13,0, animationViewWidth * rise, 10)];
    _leftAnimationView.sourceImage = [UIImage imageNamed:@"Deal_Animation_Left_Arrow"];
    _leftAnimationView.animationType = LoopAnimationTypeLeftToRight;
    _leftAnimationView.duration = 3.f;
    _leftAnimationView.alpha = 0.3f;
    _leftAnimationView.backgroundColor = [UIColor colorWithHexString:@"#f1496c"];
    [self addSubview:self.leftAnimationView];
    _leftAnimationView.backgroundColor = mainColor;
    [_leftAnimationView startAnimation];
    
    _riseLabel.frame = _leftAnimationView.frame;
    [self addSubview:self.riseLabel];
    
    _rightAnimationView = [[GRLoopAnimation alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftAnimationView.frame), 0, animationViewWidth * (1 - rise), 10)];
    _rightAnimationView.sourceImage = [UIImage imageNamed:@"Deal_Animation_Right_Arrow"];
    _rightAnimationView.animationType = LoopAnimationTypeRightToLeft;
    _rightAnimationView.duration = 3.f;
    _rightAnimationView.alpha = 0.3f;
    [self addSubview:self.rightAnimationView];
    _rightAnimationView.backgroundColor = [UIColor colorWithHexString:@"#09cb67"];
    [_rightAnimationView startAnimation];
    
    _fallLabel.frame = _rightAnimationView.frame;
    [self addSubview:self.fallLabel];
    
    [self addSubview:self.leftAnimationView];
    [self addSubview:self.rightAnimationView];
}

- (void)setRiseRate:(NSString *)riseRate{
    _riseRate = riseRate;
    CGFloat rise = riseRate.floatValue;
    _riseLabel.text = [NSString stringWithFormat:@"买涨%.0f%%",self.riseRate.floatValue * 100];
    _fallLabel.text = [NSString stringWithFormat:@"买跌%.0f%%",(1 - self.riseRate.floatValue) * 100];
    _leftAnimationView.frame = CGRectMake(13,0, animationViewWidth * rise, 10);
    _rightAnimationView.frame = CGRectMake(CGRectGetMaxX(_leftAnimationView.frame), 0, animationViewWidth * (1 - rise), 10);
    _riseLabel.frame = _leftAnimationView.frame;
    _fallLabel.frame = _rightAnimationView.frame;
}

@end
