//
//  GRTextField.m
//  GoldRush
//
//  Created by Jack on 2017/1/7.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRTextField.h"

@implementation GRTextField

//控制placeHolder的位置，左右缩20
- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    //return CGRectInset(bounds, 20, 0);
    CGRect inset = CGRectMake(bounds.origin.x + 10, bounds.origin.y + 5, bounds.size.width - 10, bounds.size.height);//更好理解些
    return inset;
}

@end
