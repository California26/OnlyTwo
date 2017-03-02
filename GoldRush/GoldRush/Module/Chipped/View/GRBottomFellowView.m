//
//  GRBottomFellowView.m
//  GoldRush
//
//  Created by Jack on 2017/1/10.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRBottomFellowView.h"

@implementation GRBottomFellowView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //关注按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        [btn setTitle:@"取消关注" forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 8;
        btn.backgroundColor = [UIColor colorWithHexString:@"#f39800"];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:@"＋关注" forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(fellowClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //线
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        
        //布局
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(self);
            make.width.equalTo(@200);
            make.height.equalTo(@30);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.equalTo(@1);
        }];
    }
    return self;
}

- (void)fellowClick:(UIButton *)btn{
    if (self.fellowBlock) {
        self.fellowBlock();
    }
}

@end
