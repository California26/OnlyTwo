//
//  GRChippedPlanView.m
//  GoldRush
//
//  Created by Jack on 2016/12/31.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRChippedPlanView.h"

@implementation GRChippedPlanView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //设置 UI
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    UIView *lineLeft = [[UIView alloc] init];
    [self addSubview:lineLeft];
    lineLeft.backgroundColor = GRColor(220, 220, 220);
    
    UIView *lineRight = [[UIView alloc] init];
    [self addSubview:lineRight];
    lineRight.backgroundColor = GRColor(220, 220, 220);    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"分析师计划怎么玩";
    label.textColor = [UIColor colorWithHexString:@"#333333"];
    label.font = [UIFont systemFontOfSize:12];
    [self addSubview:label];
    
    [lineLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left);
        make.height.equalTo(@1);
        make.right.equalTo(label.mas_left).offset(-10);
    }];
    
    [lineRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(label.mas_right).offset(10);
        make.height.equalTo(@1);
        make.right.equalTo(self.mas_right);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

@end
