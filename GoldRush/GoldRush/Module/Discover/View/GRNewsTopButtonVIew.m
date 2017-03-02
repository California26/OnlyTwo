//
//  GRNewsTopButtonVIew.m
//  GoldRush
//
//  Created by Jack on 2017/2/15.
//  Copyright © 2017年 Jack. All rights reserved.
//

#define ButtonWidth (K_Screen_Width / 3)

#import "GRNewsTopButtonVIew.h"

@interface GRNewsTopButtonVIew ()

@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, weak) UIButton *selectedBtn;
@property (nonatomic, weak) UIImageView *lineImageView;

@end

@implementation GRNewsTopButtonVIew

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createTopButton];
    }
    return self;
}

#pragma mark - private method
- (void)createTopButton{
    for (int i = 0; i < self.titleArray.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:20];
        [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(ButtonWidth * i, 0, ButtonWidth, 50);
        [btn setTitleColor:mainColor forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(newsClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (0 == i) {
            [self newsClick:btn];
            UIImageView *line = [[UIImageView alloc] init];
            line.image = [UIImage imageNamed:@"Discover_Selected_Bton_image"];
            [self addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(btn.mas_centerX);
                make.bottom.equalTo(btn.mas_bottom).offset(1);
            }];
            self.lineImageView = line;
        }
    }
}

#pragma mark - event response
//点击顶部按钮
- (void)newsClick:(UIButton *)btn{
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.lineImageView.center = CGPointMake(btn.centerX, 49);
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(gr_clickNewTopButton:)]) {
        [self.delegate gr_clickNewTopButton:btn];
    }
}

#pragma mark - setter and getter
- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithArray:@[@"财经",@"贵金属",@"策略"]];
    }
    return _titleArray;
}

@end
