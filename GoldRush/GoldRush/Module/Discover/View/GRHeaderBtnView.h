//
//  GRHeaderBtnView.h
//  GoldRush
//
//  Created by Jack on 2017/1/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRHeaderBtnView : UIView

///按钮标题文字
@property(nonatomic, strong) NSArray *titleArray;

///按钮点击
@property (nonatomic, copy) void(^btnClick)(UIButton *btn);

///点击的索引
@property (nonatomic, assign) NSInteger index;

@end
