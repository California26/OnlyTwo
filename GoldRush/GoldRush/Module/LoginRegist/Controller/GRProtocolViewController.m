//
//  GRProtocolViewController.m
//  GoldRush
//
//  Created by Jack on 2016/12/21.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRProtocolViewController.h"

@interface GRProtocolViewController ()

@property(nonatomic, strong) UIWebView *webView;

@end

@implementation GRProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpChildControl];
}

- (void)setUpChildControl{
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor colorWithHexString:@"#d43c33"];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(64);
    }];
    
    UILabel *title = [[UILabel alloc] init];
    [topView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView).offset(20);
        make.left.equalTo(topView).offset(100);
        make.right.equalTo(topView).offset(-100);
        make.height.mas_equalTo(44);
    }];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = self.text;
    title.font = [UIFont systemFontOfSize:16];
    title.textColor = [UIColor colorWithHexString:@"#ffffff"];
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [topView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).offset(13);
        make.height.and.with.equalTo(@44);
        make.top.equalTo(topView).offset(20);
    }];
    [backBtn setImage:[UIImage imageNamed:@"Back_Btn"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, K_Screen_Width, K_Screen_Height - 64)];
    [self.view addSubview:self.webView];
    NSURL *url = [NSURL URLWithString:self.url];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];

}

//返回点击事件
- (void)backClick:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
