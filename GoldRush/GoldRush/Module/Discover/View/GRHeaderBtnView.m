//
//  GRHeaderBtnView.m
//  GoldRush
//
//  Created by Jack on 2017/1/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#define btnWidth (K_Screen_Width / self.titleArray.count)

#import "GRHeaderBtnView.h"

@interface GRHeaderBtnView ()

@property (nonatomic, weak) UIButton *selectedBtn;      ///选中的按钮
@property (nonatomic, weak) UIImageView *lineImageView; ///按钮下面的线

@end

@implementation GRHeaderBtnView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)btnClick:(UIButton *)btn{
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.lineImageView.center = CGPointMake(btn.centerX, 39);
    }];
    
    if (self.btnClick) {
        self.btnClick(btn);
    }
}

- (void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    //创建按钮
    for (int i = 0; i < titleArray.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        btn.frame = CGRectMake(btnWidth * i, 0, btnWidth, 40);
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (0 == i) {
            [self btnClick:btn];
            UIImageView *line = [[UIImageView alloc] init];
            line.image = [UIImage imageNamed:@"Discover_Selected_Bton_image"];
            [self addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(btn.mas_centerX);
                make.bottom.equalTo(self).offset(1);
            }];
            self.lineImageView = line;
        }
        btn.tag = 5678 + i;
    }
}

- (void)setIndex:(NSInteger)index{
    _index = index;
    
    UIButton *btn = [self viewWithTag:5678 + index];
    [self btnClick:btn];
}

@end
