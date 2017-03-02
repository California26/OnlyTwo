//
//  GRChippedCarouselView.h
//  GoldRush
//
//  Created by Jack on 2016/12/29.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRChippedCarouselView : UIView

///信息数据
@property(nonatomic, strong) NSMutableArray *messageArray;

///轮播图被点击
@property (nonatomic, copy) void(^carouselClick)(NSInteger index);


@end
