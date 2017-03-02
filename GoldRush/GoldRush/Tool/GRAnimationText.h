//
//  GRAnimationText.h
//  GoldRush
//
//  Created by Jack on 2017/1/3.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRAnimationText : UIView

///标题
@property (nonatomic, copy) NSString *text;
///滚动数组
@property(nonatomic, strong) NSMutableArray *message;
///点击事件
@property (nonatomic, copy) void(^textClick)();

@end
