//
//  GRNoNetWorkViewController.m
//  GoldRush
//
//  Created by Jack on 2017/2/16.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRNoNetWorkViewController.h"

@interface GRNoNetWorkViewController ()

@end

@implementation GRNoNetWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 64)];
    [self.view addSubview:view];
    view.backgroundColor = mainColor;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 64)];
    [view addSubview:label];
    label.text = @"全民淘金";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    UIImageView *icon = [[UIImageView alloc] init];
    [self.view addSubview:icon];
    icon.contentMode = UIViewContentModeCenter;
    icon.image = [UIImage imageNamed:@"No_Internet"];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
    }];
    
    UILabel *desc = [[UILabel alloc] init];
    [self.view addSubview:desc];
    desc.text = @"网络连接错误~";
    [desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(icon.mas_bottom).offset(10);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn setTitle:@"重新加载!" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 8;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    btn.layer.borderWidth = 1;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(desc.mas_bottom).offset(20);
        make.width.equalTo(@120);
        make.height.equalTo(@30);
    }];
}

- (void)btnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gr_noNetworkDidClickBtn:)]) {
        [self.delegate gr_noNetworkDidClickBtn:btn];
    }
}



@end
