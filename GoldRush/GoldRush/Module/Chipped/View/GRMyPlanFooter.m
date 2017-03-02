//
//  GRMyPlanFooter.m
//  GoldRush
//
//  Created by Jack on 2017/1/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRMyPlanFooter.h"

@interface GRMyPlanFooter ()

@property (nonatomic, weak) UILabel *profitLabel;
@property (nonatomic, weak) UILabel *suggestionLabel;

@end

@implementation GRMyPlanFooter

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        //盈利
        UILabel *profit = [[UILabel alloc] init];
        [self addSubview:profit];
        profit.textColor = [UIColor colorWithHexString:@"#d43c33"];
        profit.font = [UIFont systemFontOfSize:15];
        profit.text = @"盈利(元):20400.0元";
        
        //建议
        UILabel *suggestion = [[UILabel alloc] init];
        [self addSubview:suggestion];
        suggestion.textColor = [UIColor colorWithHexString:@"#666666"];
        suggestion.font = [UIFont systemFontOfSize:10];
        suggestion.text = @"操作建议:银仓短期头部部成型,下行概率增大.";
        
        //评价
        UIButton *comment = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:comment];
        comment.layer.cornerRadius = 10;
        comment.layer.masksToBounds = YES;
        [comment setTitle:@"评价" forState:UIControlStateNormal];
        comment.backgroundColor = GRColor(251, 153, 45);
        [comment addTarget:self action:@selector(commentClick) forControlEvents:UIControlEventTouchUpInside];
        comment.titleLabel.textColor = [UIColor whiteColor];
        comment.titleLabel.font = [UIFont systemFontOfSize:10];
        
        //布局
        [profit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.equalTo(@13);
        }];
        
        [suggestion mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@13);
            make.top.equalTo(profit.mas_bottom).offset(10);
        }];
        
        [comment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-13);
            make.top.equalTo(self).offset(7);
            make.width.equalTo(@70);
            make.height.equalTo(@20);
        }];
    }
    return self;
}


#pragma mark - event response
- (void)commentClick{
    
}


@end
