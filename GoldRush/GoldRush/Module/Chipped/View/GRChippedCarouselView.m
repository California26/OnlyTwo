//
//  GRChippedCarouselView.m
//  GoldRush
//
//  Created by Jack on 2016/12/29.
//  Copyright © 2016年 Jack. All rights reserved.
//

#define CarouselHeight 102
#define HeadeLinelHeight 20

#import "GRChippedCarouselView.h"
#import "HeadLine.h"
#import <SDCycleScrollView.h>

@interface GRChippedCarouselView ()<SDCycleScrollViewDelegate>

@property (nonatomic, weak) SDCycleScrollView *cycleScrollView;
@property (nonatomic, weak) HeadLine *lineView;


@end

@implementation GRChippedCarouselView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //设置 UI
        [self setupUI];
    }
    return self;
}


- (void)setupUI{
    
    //轮播图
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, K_Screen_Width, CarouselHeight) imageNamesGroup:@[@"Carousel",@"Carousel",@"Carousel",@"Carousel",@"Carousel"]];
    self.cycleScrollView = cycleScrollView;
    cycleScrollView.delegate = self;
    cycleScrollView.autoScrollTimeInterval = 2.0;
    [self addSubview:cycleScrollView];
    
    UIView *view = [[UIView alloc] init];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@25);
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.top.equalTo(self.cycleScrollView.mas_bottom).offset(10);
    }];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    
    UIImageView *voice = [[UIImageView alloc] initWithFrame:CGRectMake(17, 0, 25, 25)];
    voice.image = [UIImage imageNamed:@"Voice"];
    voice.contentMode = UIViewContentModeCenter;
    voice.backgroundColor = [UIColor whiteColor];
    
    HeadLine *textView = [[HeadLine alloc]initWithFrame:CGRectMake(59, 0, K_Screen_Width - 89, 25)];
    [textView setBgColor:[UIColor whiteColor] textColor:nil textFont:[UIFont systemFontOfSize:12]];
    self.lineView = textView;
    [textView setScrollDuration:0.5 stayDuration:3];

    [textView start];
    [view addSubview:voice];
    [view addSubview:textView];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    GRLog(@"第%zd张被点击了!",index);
    WS(weakSelf)
    if (weakSelf.carouselClick) {
        weakSelf.carouselClick(index);
    }
}

#pragma mark - setter and getter
- (void)setMessageArray:(NSMutableArray *)messageArray{
    _messageArray = messageArray;
    for (int i = 0; i < messageArray.count; i ++) {
        NSString *text = messageArray[i];
        NSRange range = [text stringSubWithString:@"户" andString:@"刚"];
        NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc] initWithString:text];
        [attribut addAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#d43c33"]} range:range];
        [messageArray replaceObjectAtIndex:i withObject:attribut];
    }
    self.lineView.messageArray = messageArray;
    [self.lineView start];
}


@end
