//
//  UIButton+GRButtonLayout.h
//  GoldRush
//
//  Created by Jack on 2016/12/24.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (GRButtonLayout)

/** 修改按钮的图片和文字的位置 */
@property (nonatomic,assign) CGRect titleRect;
@property (nonatomic,assign) CGRect imageRect;

@end
