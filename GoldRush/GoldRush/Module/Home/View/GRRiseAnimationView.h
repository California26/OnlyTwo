//
//  GRRiseAnimationView.h
//  GoldRush
//
//  Created by Jack on 2016/12/28.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger , AnimationDirection) {
    AnimationDirectionFromBottomToTop,
    AnimationDirectionFromTopToBottom
};

@interface GRRiseAnimationView : UIView

- (instancetype)initWithFrame:(CGRect)frame withImage:(NSString *)image withDirection:(AnimationDirection)direction;

@property (nonatomic, assign) AnimationDirection animationDirection;

@end
