//
//  GRMineHTMLViewController.m
//  GoldRush
//
//  Created by Jack on 2017/2/22.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRMineHTMLViewController.h"

@interface GRMineHTMLViewController ()

@property(nonatomic, strong) UIWebView *webView;

@end

@implementation GRMineHTMLViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpChildControl];

}

- (void)setUpChildControl{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height - 64)];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    NSURL *url = [NSURL URLWithString:self.url];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}


@end
