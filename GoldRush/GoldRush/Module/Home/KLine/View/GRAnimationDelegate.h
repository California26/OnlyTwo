//
//  GRAnimationDelegate.h
//  GoldRush
//
//  Created by Jack on 2017/2/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GRAnimationDelegate <NSObject>

@optional
- (void)gr_animationDidStop;

@end

@interface GRAnimationDelegate : NSObject<CAAnimationDelegate>

@property (nonatomic, weak) id<GRAnimationDelegate> delegate;

@end
