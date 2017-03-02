//
//  GRNewsViewController.m
//  GoldRush
//
//  Created by Jack on 2017/2/15.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRNewsViewController.h"
#import "GRNewsTopButtonVIew.h"             ///头部按钮 view


@interface GRNewsViewController ()<GRNewsTopButtonVIewDelegate>

@end

@implementation GRNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //创建子视图
    [self createViews];
}

//创建子视图
- (void)createViews{
    self.view.backgroundColor = defaultBackGroundColor;
    GRNewsTopButtonVIew *buttonView = [[GRNewsTopButtonVIew alloc] initWithFrame:CGRectMake(0, 64, K_Screen_Width, 50)];
    buttonView.delegate = self;
//    [self.view addSubview:buttonView];
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height)];
    [self.view addSubview:web];
    NSURL *url = [NSURL URLWithString:@"https://taojin.6789.net/?r=news"];
    [web loadRequest:[NSURLRequest requestWithURL:url]];
}

#pragma mark - GRNewsTopButtonVIewDelegate
- (void)gr_clickNewTopButton:(UIButton *)btn{

    

}

@end
