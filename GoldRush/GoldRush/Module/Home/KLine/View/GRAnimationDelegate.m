//
//  GRAnimationDelegate.m
//  GoldRush
//
//  Created by Jack on 2017/2/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRAnimationDelegate.h"

@implementation GRAnimationDelegate


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gr_animationDidStop)]) {
        
        [self.delegate gr_animationDidStop];
    }
}


@end
