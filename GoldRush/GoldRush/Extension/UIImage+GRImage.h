//
//  UIImage+GRImage.h
//  GoldRush
//
//  Created by Jack on 2017/2/21.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GRImage)

/**
 不变形的拉伸图片
 
 @param originalImage 原始图片
 @param targetSize 目标 size
 @return  拉伸之后的图片
 */
+ (UIImage *)scaleImageAspectFit:(UIImage *)originalImage targetSize:(CGSize)targetSize;

/**
 在指定的 size 里面生成一个平铺的图片
 
 @param originalImage 原始图片
 @param targetSize 目标 size
 @return  返回一张目标 size 的图片
 */
+ (UIImage *)tiledImage:(UIImage *)originalImage targetSize:(CGSize)targetSize;

/**
 *  压缩图片到指定尺寸大小
 *
 *  @param image 原始图片
 *  @param size  目标大小
 *
 *  @return 生成图片
 */
+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size;

- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize;

@end
