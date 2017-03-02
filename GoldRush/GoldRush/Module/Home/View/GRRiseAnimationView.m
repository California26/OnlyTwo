//
//  GRRiseAnimationView.m
//  GoldRush
//
//  Created by Jack on 2016/12/28.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRRiseAnimationView.h"

@interface GRRiseAnimationView ()

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, assign) AnimationDirection direction;

@end

@implementation GRRiseAnimationView


- (instancetype)initWithFrame:(CGRect)frame withImage:(NSString *)imageName withDirection:(AnimationDirection)direction{
    if (self = [super initWithFrame:frame]) {
        self.imageName = imageName;
        self.direction = direction;
        //设置 UI
        [self setupUI];
        //添加定时器
//        [NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(startAnination) userInfo:nil repeats:YES];
        [self startAnination];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //设置 UI
        [self setupUI];
        //添加定时器
//        [NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(startAnination) userInfo:nil repeats:YES];
        [self startAnination];
    }
    return self;
}

- (void)setupUI{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:self.imageName];
    imageView.contentMode = UIViewContentModeCenter;
    self.imageView = imageView;

    [self addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.and.right.equalTo(self);
    }];
}

- (void)startAnination{
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    if (self.direction == AnimationDirectionFromBottomToTop) {
        positionAnimation.fromValue = @(10);
        positionAnimation.toValue = @(0);
    }else if (self.direction == AnimationDirectionFromTopToBottom){
        positionAnimation.fromValue = @(0);
        positionAnimation.toValue = @(10);
    }
    positionAnimation.repeatCount = HUGE_VALF;
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @(1);
    alphaAnimation.toValue = @(0);
    alphaAnimation.repeatCount = HUGE_VALF;
    alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = .5;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    animationGroup.animations = @[positionAnimation,alphaAnimation];
    animationGroup.repeatCount = HUGE_VALF;
    [self.imageView.layer addAnimation:animationGroup forKey:@"animation"];
    
}

- (void)setAnimationDirection:(AnimationDirection)animationDirection{
    _animationDirection = animationDirection;
    
    if (animationDirection == AnimationDirectionFromBottomToTop) {
        self.imageView.image = [UIImage imageNamed:@"Rise_red"];
    }else{
        self.imageView.image = [UIImage imageNamed:@"Fall_Green"];
    }
    [self startAnination];
}


@end
