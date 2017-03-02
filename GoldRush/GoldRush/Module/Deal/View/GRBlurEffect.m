//
//  GRBlurEffect.m
//  GoldRush
//
//  Created by Jack on 2017/1/13.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRBlurEffect.h"
#import "POP.h"

@interface GRBlurEffect ()


@end


@implementation GRBlurEffect


- (void)addEffectiVieAndAlterView:(UIView *)alterView{
    POPSpringAnimation *spingAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    spingAnimation.fromValue = @(-210);
    spingAnimation.toValue = @(K_Screen_Height / 2);
    spingAnimation.beginTime = CACurrentMediaTime();
    spingAnimation.springBounciness = 10.0f;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -64, K_Screen_Width, K_Screen_Height + 64 * 2)];
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    view.userInteractionEnabled = YES;
//    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    UIVisualEffectView *effective = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//    effective.alpha = 0.8f;
//    effective.frame = CGRectMake(0, -64, K_Screen_Width, K_Screen_Height + 64 * 2);
//    effective.userInteractionEnabled = YES;
    [view addSubview:alterView];
    [alterView pop_addAnimation:spingAnimation forKey:@"position"];
    UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removePopAnimation:)];
    [view addGestureRecognizer:tapgesture];
    [[[UIApplication sharedApplication] keyWindow] addSubview:view];
}

- (void)removePopAnimation:(UITapGestureRecognizer *)sender{
    POPSpringAnimation *anSpring1 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anSpring1.toValue = @(K_Screen_Height + 120);
    anSpring1.beginTime = CACurrentMediaTime();
    anSpring1.springBounciness = 1.0f;
    UIVisualEffectView *view = (UIVisualEffectView *)sender.view;
    UIView *subView = view.subviews.firstObject;
    [subView pop_addAnimation:anSpring1 forKey:@"position"];
    [view removeFromSuperview];
//    [subView removeFromSuperview];
}

@end
