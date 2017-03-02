//
//  GRTextField.m
//  GoldRush
//
//  Created by Jack on 2017/1/11.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRTextField.h"

@implementation GRTextField

- (CGRect)rightViewRectForBounds:(CGRect)bounds{
    CGRect iconRect = [super rightViewRectForBounds:bounds];
    iconRect.origin.x -= 13; //像右边偏15
    return iconRect;
}

//控制placeHolder的颜色、字体
- (void)drawPlaceholderInRect:(CGRect)rect{
    [[self placeholder] drawInRect:rect withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13] , NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#999999"]}];
}

//控制placeHolder的位置，左右缩20
- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x + 90, bounds.origin.y+18 , bounds.size.width, 40);
    return inset;
}

@end
