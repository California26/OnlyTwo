//
//  GRHTMLViewController.m
//  GoldRush
//
//  Created by Jack on 2016/12/27.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRHTMLViewController.h"

@interface GRHTMLViewController ()

@property(nonatomic, strong) UIWebView *webView;

@end

@implementation GRHTMLViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setUpChildControl];
}


- (void)setUpChildControl{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height - 64)];
    [self.view addSubview:self.webView];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL *url = [NSURL URLWithString:self.url];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}


@end
