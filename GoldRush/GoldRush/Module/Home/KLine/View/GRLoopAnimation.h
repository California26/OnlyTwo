//
//  GRLoopAnimation.h
//  GoldRush
//
//  Created by Jack on 2016/12/26.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LoopAnimationTypeLeftToRight,   //从左到右
    LoopAnimationTypeRightToLeft    //从右到左
} LoopAnimationType;

@interface GRLoopAnimation : UIView
///动画时间间隔(默认间隔为1s)
@property (nonatomic, assign) NSTimeInterval duration;

///动画方式
@property (nonatomic, assign) LoopAnimationType animationType;

///素材图片
@property(nonatomic, strong) UIImage *sourceImage;

- (void)startAnimation;
@end
