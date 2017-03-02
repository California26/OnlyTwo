//
//  PopView.m
//  PopScrollerView
//
//  Created by Jack on 2016/12/20.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "PopView.h"

@interface PopView ()

///标题
@property (nonatomic, weak) UILabel *label;
/// 描述
@property (nonatomic, weak) UILabel *descLabel;
///主 view
@property(nonatomic, strong) UIView *mainView;

@end

@implementation PopView

- (nullable instancetype)initWithFrame:(CGRect)frame withTitle:(nullable NSString *)title{
    if (self = [super initWithFrame:frame]) {
        self.headTitle = title;
        //添加子控件
        [self setup];
        
    }
    return self;
}

- (void)setup{
    UIView *cover = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIColor *color = [UIColor blackColor];
    cover.backgroundColor = [color colorWithAlphaComponent:0.6];
    [self addSubview:cover];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCover)];
    [cover addGestureRecognizer:tap];
    cover.userInteractionEnabled = YES;
    
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    self.mainView.center = CGPointMake(K_Screen_Width * 0.5, K_Screen_Height * 0.5);
    self.mainView.backgroundColor = [UIColor whiteColor];
    self.mainView.layer.cornerRadius = 5.0f;
    self.mainView.layer.masksToBounds = YES;
    //边界
    self.mainView.layer.borderColor = [UIColor blackColor].CGColor;
    self.mainView.layer.borderWidth = 1.0;
    [cover addSubview:self.mainView];
    
    UILabel *title = [[UILabel alloc] init];
    self.label = title;
    title.textAlignment = NSTextAlignmentCenter;
    [self.mainView addSubview:title];
    title.font = [UIFont systemFontOfSize:21.0];
    title.backgroundColor = [UIColor orangeColor];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(self.mainView);
        make.height.equalTo(@44);
    }];
    
    UILabel *desc = [[UILabel alloc] init];
    self.descLabel = desc;
    desc.numberOfLines = 0;
    desc.textAlignment = NSTextAlignmentCenter;
    [self.mainView addSubview:desc];
    desc.text = @"参与此计划需要哈贵账户当前可用资金大于等于5000元哦!~~~~";
    [desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainView.mas_left).offset(20);
        make.right.equalTo(self.mainView.mas_right).offset(-20);
        make.top.equalTo(title.mas_bottom).offset(20);
    }];
    
    UIButton *recharge = [UIButton buttonWithType:UIButtonTypeCustom];
    [recharge setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    recharge.layer.cornerRadius = 10;
    recharge.layer.masksToBounds = YES;
    recharge.layer.borderColor = [UIColor blackColor].CGColor;
    recharge.layer.borderWidth = 1.0;
    [self.mainView addSubview:recharge];
    [recharge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(desc.mas_bottom).offset(10);
        make.centerX.equalTo(self.mainView.mas_centerX);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    [recharge setTitle:@"去充值" forState:UIControlStateNormal];
    [recharge addTarget:self action:@selector(rechargeClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *warn = [[UILabel alloc] init];
    warn.numberOfLines = 0;
    warn.textAlignment = NSTextAlignmentCenter;
    [self.mainView addSubview:warn];
    warn.text = @"行情随时变化,请注意交易风险!!";
    [warn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainView.mas_left).offset(20);
        make.right.equalTo(self.mainView.mas_right).offset(-20);
        make.top.equalTo(recharge.mas_bottom).offset(20);
    }];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.label.text = self.headTitle;
}

- (void)tapCover{
    [self removeFromSuperview];
}

//充值点击
- (void)rechargeClick:(UIButton *)btn{
    if (self.rechargeBlock) {
        self.rechargeBlock();
    }
}


@end
