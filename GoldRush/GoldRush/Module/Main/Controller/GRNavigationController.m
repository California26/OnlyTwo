//
//  GRNavigationController.m
//  GoldRush
//
//  Created by Jack on 2016/12/15.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRNavigationController.h"
#import "UIBarButtonItem+GRItem.h"
#import "GRNavigationBar.h"
@interface GRNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>


@end

@implementation GRNavigationController

+ (void)load{
    //拿到全局的导航条
    UINavigationBar *nav = [UINavigationBar appearance];
    
    //拿到想要设置返回样式的图片,以及设置图片的渲染样式和偏移值
    UIImage *backImage = [[[UIImage imageNamed:@"Back_Btn"]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                          imageWithAlignmentRectInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    
    //设置返回样式
    [nav setBackIndicatorImage:backImage];
    [nav setBackIndicatorTransitionMaskImage:backImage];
    
    //如果只做到这样的话,会发现图片是设置好了,但是title还在,下面代码的就是让title产生偏移看不到
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    nav.barTintColor = GRColor(192, 57, 44);
    nav.backgroundColor = GRColor(192, 57, 45);
    nav.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

//- (id)init {
//    self = [super initWithNavigationBarClass:[GRNavigationBar class] toolbarClass:nil];
//    if(self) {
//        // Custom initialization here, if needed.
//    }
//    return self;
//}
//
//- (id)initWithRootViewController:(UIViewController *)rootViewController {
//    self = [super initWithNavigationBarClass:[GRNavigationBar class] toolbarClass:nil];
//    [self.navigationBar setBarTintColor:GRColor(212.0, 60.0, 51.0)];
//    if(self) {
//        self.viewControllers = @[rootViewController];
//    }
//    return self;
//}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


@end
