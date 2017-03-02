//
//  GRTimeTypeView.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/16.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRTimeTypeView.h"
#import "UIColor+GRChart.h"
static NSInteger const Y_StockChartSegmentStartTag = 2000;


@interface GRTimeTypeView ()

@property (nonatomic,strong) UIView *viewBackGround;
@property (nonatomic,strong) UIButton *viewFore;
@property (nonatomic,strong) UIButton *selectedBtn;

@end

@implementation GRTimeTypeView

- (instancetype)initWithItems:(NSArray *)items
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
//        [self addSubview:self.viewBackGround];
//        [self addSubview:self.viewFore];
        self.items = items;
        
    }
    return self;
}


- (UIView *)viewBackGround
{
    if (!_viewBackGround) {
        _viewBackGround = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 125)];
        _viewBackGround.layer.cornerRadius = 5.0f;
        _viewBackGround.layer.masksToBounds = YES;
        _viewBackGround.backgroundColor = [UIColor colorWithHexString:@"#3d3d4f"];
    }
    return _viewBackGround;
}

- (UIButton *)viewFore
{
    if (!_viewFore) {
        _viewFore = [UIButton buttonWithType:UIButtonTypeCustom];
        _viewFore.frame = CGRectMake(0, 0, 60, 25);
        _viewFore.layer.cornerRadius = 5.0f;
        _viewFore.layer.masksToBounds = YES;
        _viewFore.backgroundColor = [UIColor colorWithHexString:@"d43c33"];
        [_viewFore setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_viewFore setTitle:@"分时图" forState:UIControlStateNormal];
        _viewFore.titleLabel.font = [UIFont systemFontOfSize:13];
        [_viewFore addTarget:self action:@selector(event_foreButtonAction:)forControlEvents:UIControlEventTouchUpInside];
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(event_LongPressButtonAction:)];
        [_viewFore addGestureRecognizer:longPress];
    }
    return _viewFore;
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    [self.viewBackGround removeFromSuperview];
    [self.viewFore removeFromSuperview];
    _items = items;
    if (items.count == 0 || !items) {
        return;
    }
    
    [self addSubview:self.viewBackGround];
    [self addSubview:self.viewFore];
    self.viewBackGround.hidden = YES;
    for (int i = 0; i < items.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 25*i, 60, 25);
        button.backgroundColor = [UIColor clearColor];
        [button setTitle:_items[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(event_buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = Y_StockChartSegmentStartTag + i;
        [_viewBackGround addSubview:button];
    }
    _viewBackGround.frame = CGRectMake(0, 0, 60, 25*items.count);
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    _viewFore.frame = CGRectMake(0, 0, 60, 25);
    [_viewFore setTitle:self.items[selectedIndex] forState:UIControlStateNormal];
    UIButton *btn = [self.viewBackGround viewWithTag:Y_StockChartSegmentStartTag + selectedIndex];
    NSAssert(btn, @"按钮初始化错误");
    [self event_segmentButtonClicked:btn];
}


#pragma mark 底部按钮点击事件
- (void)event_segmentButtonClicked:(UIButton *)btn
{
    self.selectedBtn = btn;
    if(self.delegate && [self.delegate respondsToSelector:@selector(timeTypeClickSegementButtonIndex:)])
    {
        [self.delegate timeTypeClickSegementButtonIndex:btn.tag - Y_StockChartSegmentStartTag];
    }
}

- (void)event_buttonAction:(UIButton *)sender
{
    if (self.items.count == 6) {
        
    }else{
        
    }
    if (self.frame.origin.y + self.frame.size.height > K_Screen_Height - 277) {
        _viewFore.frame = CGRectMake(0, self.frame.size.height-25, 60, 25);
    }else{
        _viewFore.frame = CGRectMake(0, 0, 60, 25);
    }
    [_viewFore setTitle:self.items[sender.tag-Y_StockChartSegmentStartTag] forState:UIControlStateNormal];
    _viewBackGround.hidden = YES;
    self.selectedBtn = sender;
    _selectedIndex = sender.tag - Y_StockChartSegmentStartTag;
    if(self.delegate && [self.delegate respondsToSelector:@selector(timeTypeClickSegementButtonIndex:)])
    {
        [self.delegate timeTypeClickSegementButtonIndex:sender.tag - Y_StockChartSegmentStartTag];
    }
}

- (void)event_foreButtonAction:(UIButton *)sender
{
    if (self.viewBackGround.hidden == YES) {
        self.viewBackGround.hidden = NO;
    }else{
        self.viewBackGround.hidden = YES;
    }
    UIButton *btn = self.selectedBtn;
    [UIView animateWithDuration:.5f animations:^{
        _viewFore.frame = btn.frame;
    }];
    [_viewFore setTitle:self.items[btn.tag-Y_StockChartSegmentStartTag] forState:UIControlStateNormal];
}

#pragma mark 长按手势
- (void)event_LongPressButtonAction:(UILongPressGestureRecognizer *)sender
{
    CGPoint location = [sender locationInView:self.superview];
    CGFloat defaultHeight = K_Screen_Height-277;
    if (location.y < 0 || location.y > defaultHeight) {
        
    }else{
        if (location.x<0 || location.x > K_Screen_Width - 60) {
            
        }else{
            if (location.y > defaultHeight - 125) {
                self.frame = CGRectMake(location.x, location.y-125, self.frame.size.width, self.frame.size.height);
                _viewFore.frame = CGRectMake(0, self.frame.size.height-25, 60, 25);
            }else{
                self.frame = CGRectMake(location.x, location.y, self.frame.size.width, self.frame.size.height);
            }
        }
    }
    
    
}
@end
