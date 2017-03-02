//
//  GRReleaseViewController.m
//  GoldRush
//
//  Created by Jack on 2017/1/9.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRReleaseViewController.h"

@interface GRReleaseViewController ()

@end

@implementation GRReleaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = GRColor(240, 240, 240);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, K_Screen_Width, 20)];
    label.text = @"您暂无发布合买资格";
    label.font = [UIFont boldSystemFontOfSize:17];
    label.textColor = [UIColor colorWithHexString:@"#333333"];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}


@end
