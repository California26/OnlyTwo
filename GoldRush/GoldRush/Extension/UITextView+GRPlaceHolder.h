//
//  UITextView+GRPlaceHolder.h
//  GoldRush
//
//  Created by Jack on 2016/12/31.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (GRPlaceHolder)

@property (nonatomic, readonly) UILabel *placeholderLabel;

@property (nonatomic, strong) IBInspectable NSString *placeholder;
@property (nonatomic, strong) NSAttributedString *attributedPlaceholder;
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;

///默认 placeholder 的颜色
+ (UIColor *)defaultPlaceholderColor;

@end
