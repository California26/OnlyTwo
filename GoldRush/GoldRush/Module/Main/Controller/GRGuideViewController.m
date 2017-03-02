//
//  GRGuideViewController.m
//  GoldRush
//
//  Created by Jack on 2017/2/27.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRGuideViewController.h"
#import "GRTabBarController.h"

@interface GRGuideViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation GRGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpUI];
    
}

- (void)setUpUI{
    for (int i=0; i<3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"GoldRush_Guide_%d",i+1]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(K_Screen_Width * i, 0, K_Screen_Width, K_Screen_Height)];
        // 在最后一页创建按钮
        if (i == 2) {
            UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 60)];
            if (iPhone5) {
                tip.center = CGPointMake(K_Screen_Width * 0.5, K_Screen_Height * 0.5 + 100);
            }else{
                tip.center = CGPointMake(K_Screen_Width * 0.5, K_Screen_Height * 0.5 + 150);
            }
            tip.textColor = [UIColor whiteColor];
            tip.textAlignment = NSTextAlignmentCenter;
            tip.text = @"开启你的赚钱之旅";
            tip.font = [UIFont systemFontOfSize:25];
            [imageView addSubview:tip];
            
            // 必须设置用户交互 否则按键无法操作
            imageView.userInteractionEnabled = YES;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(K_Screen_Width / 3, CGRectGetMaxY(tip.frame) + 15, K_Screen_Width / 3, K_Screen_Height / 16);
            [button setTitle:@"立即体验" forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:20];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.layer.borderWidth = 1;
            button.layer.cornerRadius = K_Screen_Height / 32;
            button.clipsToBounds = YES;
            button.layer.borderColor = [UIColor whiteColor].CGColor;
            [button addTarget:self action:@selector(clickImmediateExperience:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
        }
        imageView.image = image;
        [self.view addSubview:self.pageControl];
        [self.mainScrollView addSubview:imageView];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 计算当前在第几页
    self.pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x / K_Screen_Width);
}

#pragma mark - event response
- (void)clickImmediateExperience:(UIButton *)button{
    [GRUserDefault setKey:@"isFirst" Value:@YES];
    // 切换根视图控制器
    self.view.window.rootViewController = [[GRTabBarController alloc] init];
}

#pragma mark - setter and getter
- (UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _mainScrollView.contentSize = CGSizeMake(K_Screen_Width * 3, K_Screen_Height);
        _mainScrollView.bounces = NO;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.delegate = self;
        [self.view addSubview:_mainScrollView];
    }
    return _mainScrollView;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, K_Screen_Height - 60, K_Screen_Width, 10)];
        _pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"#d8d8d8"];
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"#8598a7"];
        _pageControl.numberOfPages = 3;
    }
    return _pageControl;
}

@end
