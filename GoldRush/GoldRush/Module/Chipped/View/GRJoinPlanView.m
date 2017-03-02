//
//  GRJoinPlanView.m
//  GoldRush
//
//  Created by Jack on 2017/1/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRJoinPlanView.h"

@interface GRJoinPlanView ()

@property (nonatomic, weak) UILabel *numberLabel;


@end

@implementation GRJoinPlanView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //顶部 label
        UILabel *number = [[UILabel alloc] init];
        [self addSubview:number];
        self.numberLabel = number;
        number.text = @"今日名额仅剩98人";
        number.backgroundColor = [UIColor colorWithHexString:@"#ffffcc"];
        number.textColor = [UIColor colorWithHexString:@"#333333"];
        number.font = [UIFont systemFontOfSize:10];
        number.textAlignment = NSTextAlignmentCenter;
        [number mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.top.equalTo(self);
            make.height.equalTo(@10);
        }];
        
        //下部按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview: btn];
        btn.backgroundColor = [UIColor colorWithHexString:@"#ff5500"];
        btn.titleLabel.font = [UIFont systemFontOfSize:20];
        [btn setTitle:@"开户激活,加入计划" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(number.mas_bottom);
        }];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.numberLabel.text = [NSString stringWithFormat:@"今日名额仅剩%@人",self.number];
}

#pragma mark - private method
- (void)btnClick:(UIButton *)btn{
    
}

@end
