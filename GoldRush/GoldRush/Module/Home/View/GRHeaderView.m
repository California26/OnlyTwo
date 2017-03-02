//
//  GRHeaderView.m
//  GoldRush
//
//  Created by Jack on 2016/12/22.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRHeaderView.h"

/** 轮播图 */
#import <SDCycleScrollView.h>
//#import "HeadLine.h"

@interface GRHeaderView ()<SDCycleScrollViewDelegate>
///数据源数组
@property(nonatomic, strong) NSMutableArray *dataArray;
//@property (nonatomic, weak) HeadLine *headLine;


@end

@implementation GRHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加子控件
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView{
    self.backgroundColor = [UIColor whiteColor];
    SDCycleScrollView *image = [self createCarousel];
    [self addSubview:image];
    
}

#pragma mark - private method
//添加轮播图
- (SDCycleScrollView *)createCarousel{
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, K_Screen_Width, 150) shouldInfiniteLoop:YES imageNamesGroup:@[@"Carousel",@"Carousel",@"Carousel",@"Carousel"]];
    cycleScrollView.delegate = self;
    cycleScrollView.autoScrollTimeInterval = 2.0;
    return cycleScrollView;
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if (self.carouselClick) {
        self.carouselClick(index);
    }
}


@end
