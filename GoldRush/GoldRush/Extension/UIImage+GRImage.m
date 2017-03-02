//
//  UIImage+GRImage.m
//  GoldRush
//
//  Created by Jack on 2017/2/21.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "UIImage+GRImage.h"

typedef NS_ENUM(NSUInteger, DiscardImageType) {
    DiscardImageUnknown,
    DiscardImageTopSide,
    DiscardImageRightSide,
    DiscardImageBottomSide,
    DiscardImageLeftSide
};


@implementation UIImage (GRImage)

/**
 在指定的 size 里面生成一个平铺的图片
 
 @param originalImage 原始图片
 @param targetSize 目标 size
 @return  返回一张目标 size 的图片
 */
+ (UIImage *)tiledImage:(UIImage *)originalImage targetSize:(CGSize)targetSize{
    //创建临时 view 画图
    UIView *tempView = [[UIView alloc] init];
    tempView.bounds = (CGRect){CGPointZero, targetSize};
    tempView.backgroundColor = [UIColor colorWithPatternImage:originalImage];
    UIGraphicsBeginImageContext(targetSize);
    [tempView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 不变形的拉伸图片
 
 @param originalImage 原始图片
 @param targetSize 目标 size
 @return  拉伸之后的图片
 */
+ (UIImage *)scaleImageAspectFit:(UIImage *)originalImage targetSize:(CGSize)targetSize{
    //如果原图和目标图片的大小相同则直接返回
    if (CGSizeEqualToSize(originalImage.size, targetSize)) {
        return originalImage;
    }
    
    //原图和目标图尺寸不相同
    CGFloat imageWidth = originalImage.size.width;
    CGFloat imageHeight = originalImage.size.height;
    
    //声明一个判断属性
    DiscardImageType dicardType = DiscardImageUnknown;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    //声明拉伸的系数
    CGFloat scaleFactor = 0.0f;
    CGFloat scaleWidth = 0.0f;
    CGFloat scaleHeight = 0.0f;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    CGFloat widthFactor = targetWidth / targetHeight;
    CGFloat heightFactor = targetHeight / targetWidth;
    
    //FIXME: 分四种情况
    //TODO:第一种情况
    //XXX:判读要缩小那一边的尺寸
    if (widthFactor < 1 && heightFactor < 1) {
        if (widthFactor > heightFactor) {
            dicardType = DiscardImageRightSide;
            scaleFactor = heightFactor;
        }else{
            dicardType = DiscardImageBottomSide;
            scaleFactor = widthFactor;
        }
    }else if (widthFactor > 1 && heightFactor < 1){     //宽度不够比例,高度缩小一点
        dicardType = DiscardImageRightSide;
        scaleFactor = imageWidth / targetWidth;
    }else if (widthFactor < 1 && heightFactor > 1){     //高度不够比例,宽度缩小一点
        dicardType = DiscardImageBottomSide;
        scaleFactor = imageHeight / targetHeight;
    }else{      //处理放大
        if (widthFactor > heightFactor) {
            dicardType = DiscardImageRightSide;
            scaleFactor = heightFactor;
        }else{
            dicardType = DiscardImageBottomSide;
            scaleFactor = widthFactor;
        }
    }
    
    scaleWidth = imageWidth * scaleFactor;
    scaleHeight = imageHeight * scaleFactor;
    
    switch (dicardType) {
        case DiscardImageTopSide:
            
            break;
        case DiscardImageRightSide:
            targetSize.width = scaleWidth;
            break;
        case DiscardImageBottomSide:
            targetSize.height = scaleHeight;
            break;
        case DiscardImageLeftSide:
            
            break;
        case DiscardImageUnknown:
            
            break;
        default:
            break;
    }
    
    UIGraphicsBeginImageContext(targetSize);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaleWidth;
    thumbnailRect.size.height = scaleHeight;
    [originalImage drawInRect:thumbnailRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 *  压缩图片到指定尺寸大小
 *
 *  @param image 原始图片
 *  @param size  目标大小
 *
 *  @return 生成图片
 */
+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size{
    UIImage * resultImage = image;
    UIGraphicsBeginImageContext(size);
    [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        GRLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

@end
