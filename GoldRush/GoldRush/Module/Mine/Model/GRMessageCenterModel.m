//
//  GRMessageCenterModel.m
//  GoldRush
//
//  Created by Jack on 2017/1/17.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRMessageCenterModel.h"

@implementation GRMessageCenterModel

- (void)setMessage:(NSString *)message{
    _message = message;
    
    CGFloat statusLabelWidth = [UIScreen mainScreen].bounds.size.width - 26 - 45;
    self.cellHeight = [message sizeWithLabelWidth:statusLabelWidth font:[UIFont systemFontOfSize:15]].size.height + 44.2;
}

@end
