//
//  GRLoopAnimation.m
//  GoldRush
//
//  Created by Jack on 2016/12/26.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRLoopAnimation.h"

@interface GRLoopAnimation ()

///左边的图片
@property(nonatomic, strong) UIImageView *leftImageView;
///右边的图片
@property(nonatomic, strong) UIImageView *rightImageView;
///内容 view
@property(nonatomic, strong) UIView *contentView;

@property (nonatomic,strong) CABasicAnimation *loopAnimation1;

@property (nonatomic,strong) CABasicAnimation *loopAnimation2;

@end

@implementation GRLoopAnimation

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.masksToBounds = YES;
        
        //添加两个 image
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        self.loopAnimation1 = [CABasicAnimation animationWithKeyPath:@"bounds"];
        self.loopAnimation2 = [CABasicAnimation animationWithKeyPath:@"bounds"];
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width * 2, height)];
        [self addSubview:self.contentView];
        
        self.leftImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        self.leftImageView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:self.leftImageView];
        
        self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width, 0, width, height)];
        self.rightImageView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:self.rightImageView];
        
        _animationType = LoopAnimationTypeLeftToRight;
        _duration = 1.8f;
        
    }
    return self;
}

/**
 开始动画
 */
- (void)startAnimation{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    CGRect startRect = CGRectMake(0, 0, width * 2, height);
    CGRect endRect = CGRectMake(-width, 0, width * 2, height);
    
    if (self.animationType == LoopAnimationTypeLeftToRight) {
        self.contentView.frame = startRect;
        _loopAnimation1.fromValue = [NSValue valueWithCGRect:startRect];
        _loopAnimation1.toValue = [NSValue valueWithCGRect:endRect];
        _loopAnimation1.removedOnCompletion = NO;
        _loopAnimation1.duration = self.duration;
        _loopAnimation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        _loopAnimation1.repeatCount = HUGE_VALF;
        self.contentView.frame = endRect;
        [self.contentView.layer addAnimation:_loopAnimation1 forKey:@"animation"];
        
    }else if (self.animationType == LoopAnimationTypeRightToLeft){
        self.contentView.frame = startRect;
        _loopAnimation2.fromValue = [NSValue valueWithCGRect:endRect];
        _loopAnimation2.toValue = [NSValue valueWithCGRect:startRect];
        _loopAnimation2.removedOnCompletion = NO;
        _loopAnimation2.duration = self.duration;
        _loopAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        _loopAnimation2.repeatCount = HUGE_VALF;
        self.contentView.frame = endRect;
        [self.contentView.layer addAnimation:_loopAnimation2 forKey:@"animation"];
    }
}

#pragma mark - setter and getter
@synthesize sourceImage = _sourceImage;
- (void)setSourceImage:(UIImage *)sourceImage {
    _sourceImage = sourceImage;
    _leftImageView.image = sourceImage;
    _rightImageView.image = sourceImage;
}

- (UIImage *)sourceImage {
    return _sourceImage;
}

#pragma mark - setter and getter
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    //添加两个 image
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    
    
    self.leftImageView.frame = CGRectMake(0, 0, width, height);
    
    self.rightImageView.frame = CGRectMake(width, 0, width, height);
    
    [self startAnimation];
}

@end
