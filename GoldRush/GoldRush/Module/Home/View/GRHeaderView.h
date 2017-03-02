//
//  GRHeaderView.h
//  GoldRush
//
//  Created by Jack on 2016/12/22.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^carouselClick)(NSInteger index);

@interface GRHeaderView : UIView

///轮播图被点击
@property (nonatomic, copy) carouselClick carouselClick;

@end
