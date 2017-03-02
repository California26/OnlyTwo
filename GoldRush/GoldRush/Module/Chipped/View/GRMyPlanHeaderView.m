//
//  GRMyPlanHeaderView.m
//  GoldRush
//
//  Created by Jack on 2017/1/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRMyPlanHeaderView.h"

@interface GRMyPlanHeaderView ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIButton *button;


@end

@implementation GRMyPlanHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        //title
        UILabel *title = [[UILabel alloc] init];
        [self addSubview:title];
        self.titleLabel = title;
        title.textColor = [UIColor colorWithHexString:@"#333333"];
        title.font = [UIFont systemFontOfSize:15];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(13);
            make.top.equalTo(self).offset(7);
        }];
        
        //按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        self.button = btn;
        [btn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(title.mas_centerY);
            make.right.equalTo(self).offset(-13);
        }];
        
        //线
        UIView *line = [[UIView alloc] init];
        [self addSubview:line];
        line.backgroundColor = [UIColor lightGrayColor];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.bottom.equalTo(self);
            make.height.equalTo(@1);
        }];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleLabel.text = self.title;
    [self.button setTitle:self.btnTitle forState:UIControlStateNormal];
}

- (void)btnClick:(UIButton *)btn{
    if (self.btnClick) {
        self.btnClick(btn.titleLabel.text);
    }
}

@end
