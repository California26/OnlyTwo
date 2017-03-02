//
//  GRTabbar.m
//  GoldRush
//
//  Created by Jack on 2017/1/20.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRTabbar.h"
#import "UIButton+GRButtonLayout.h"

@interface GRTabbar ()

@property (weak, nonatomic) UIButton *dealBtn;

@end

@implementation GRTabbar

#pragma mark - 按钮的布局
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.barTintColor = [UIColor blackColor];
    
    int btnIndex = 0;
    for (UIView *tabBarButton in self.subviews) {
        //判断是否是 tabBarButton
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            //每一个按钮的宽度==tabbar的五分之一
            tabBarButton.width = self.width / 5;
            
            tabBarButton.x = tabBarButton.width * btnIndex;
            
            btnIndex++;
            //如果是索引是2(从0开始的)，直接让索引++，目的就是让消息按钮的位置向右移动，空出来发布按钮的位置
            if (btnIndex == 2) {
                btnIndex++;
            }
        }
    }
    
    self.dealBtn.size = CGSizeMake(self.dealBtn.currentBackgroundImage.size.width, self.dealBtn.currentBackgroundImage.size.height);
    //设置发布按钮的位置
    self.dealBtn.centerX = self.width * 0.5;
    self.dealBtn.centerY = self.height * 0.5 - 17;
    self.dealBtn.titleRect = CGRectMake(0, 45, self.dealBtn.width, 20);
    self.dealBtn.imageRect = CGRectMake(0, 0, self.dealBtn.width, 49);
}

#pragma mark - setter and getter
- (UIButton *)dealBtn{
    if (!_dealBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"交易" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setBackgroundImage:[UIImage imageNamed:@"Tabbar_Deal_Default"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"Tabbar_Deal_Selected"] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        [btn addTarget:self action:@selector(dealClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _dealBtn = btn;
    }
    return _dealBtn;
}

- (void)dealClick{
    if ([self.tabbarDelegate respondsToSelector:@selector(gr_didClickDealBtn:)]) {
        [self.tabbarDelegate gr_didClickDealBtn:self];
    }
}

//重写hitTest方法，去监听发布按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO) {
        
        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.dealBtn];
        
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.dealBtn pointInside:newP withEvent:event]) {
            return self.dealBtn;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
            
            return [super hitTest:point withEvent:event];
        }
    }
    
    else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}

@end
