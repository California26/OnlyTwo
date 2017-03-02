//
//  GRTabBarController.m
//  GoldRush
//
//  Created by Jack on 2016/12/15.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRTabBarController.h"

/** 自定义导航控制器 */
#import "GRNavigationController.h"

/** 子控制器 */
#import "GRDealViewController.h"
#import "GRPropertyViewController.h"
#import "GRChippedViewController.h"
#import "GRDiscoverViewController.h"
#import "GRMineViewController.h"
#import "GRChippedAnalystViewController.h"
#import "GRSchoolViewController.h"

@interface GRTabBarController ()
@property (nonatomic,strong) NSMutableArray                  *productListAry;//产品列表数据

@property (nonatomic,strong) GRPropertyViewController *propertyVC;
@end

@implementation GRTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.productListAry = [NSMutableArray array];
    //设置 TabBarcontroller 下面的子控制器
    [self setup];
    
}

#pragma  mark - 设置子控制器
- (void)setup{
    //添加子控制器
    GRDealViewController *dealVC = [[GRDealViewController alloc] init];
    [self addChildViewController:dealVC withTitle:@"首页" withImage:@"Tabbar_Home_Default" withSelectedImage:@"Tabbar_Home_Selected"];
    
    GRSchoolViewController *schoolVC = [[GRSchoolViewController alloc] init];
    [self addChildViewController:schoolVC withTitle:@"学堂" withImage:@"Tabbar_School_Default" withSelectedImage:@"Tabbar_School_Selected"];
    
    self.propertyVC = [[GRPropertyViewController alloc] init];
    [self addChildViewController:self.propertyVC withTitle:@"交易" withImage:@"Tabbar_Deal_Default" withSelectedImage:@"Tabbar_Deal_Selected"];
    self.propertyVC.tabBarItem.imageInsets = UIEdgeInsetsMake(-12, 0, 12, 0);
    
    GRDiscoverViewController *discoverVC = [[GRDiscoverViewController alloc] init];
    [self addChildViewController:discoverVC withTitle:@"发现" withImage:@"Tabbar_Discover_Default" withSelectedImage:@"Tabbar_Discover_Selected"];
    
    GRMineViewController *mineVC = [[GRMineViewController alloc] init];
    [self addChildViewController:mineVC withTitle:@"我" withImage:@"Tabbar_Mine_Default" withSelectedImage:@"Tabbar_Mine_Selected"];
    
}

#pragma mark - private method
- (void)addChildViewController:(UIViewController *)childVC withTitle:(NSString *)title withImage:(NSString *)imageName withSelectedImage:(NSString *)selectedImageName{
    GRNavigationController *nav = [[GRNavigationController alloc] initWithRootViewController:childVC];
    nav.tabBarItem.title = title;
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:selectedImage];
    
    self.tabBar.barTintColor = [UIColor blackColor];

    //未选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
    
    //选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:GRColor(212.0, 60.0, 51.0)} forState:UIControlStateSelected];
    [self addChildViewController:nav];
}

- (void)getDataCurrent
{
    WS(weakSelf)
    dispatch_group_t gruop = dispatch_group_create();
    dispatch_group_enter(gruop);
    dispatch_group_async(gruop, dispatch_get_global_queue(0, 0), ^{
        NSDictionary *dicparam = @{@"r":@"baibei/forward/queryQuote"};
        [GRNetWorking postWithURLString:@"?r=baibei/forward/queryQuote" parameters:dicparam callBack:^(NSDictionary *dict) {
            NSMutableDictionary *dic_New;
            NSNumber *code = dict[@"status"];
            if ([code isEqualToNumber:@(HttpSuccess)]) {
                NSArray *aryTemp = dict[@"recordset"];
                NSDictionary *dictTemp = aryTemp.firstObject;
                if ([dictTemp[HD_Contact] isKindOfClass:[NSDictionary class]]) {
                    NSString *number = dictTemp[HD_Contact][@"quote"];
                    NSString *yesterday = dictTemp[HD_Contact][@"preClose"];
                    CGFloat leftNumber = number.floatValue - yesterday.floatValue;
                    NSDictionary *dicNew = @{@"title":HD_ProductName,
                                             @"number":number,
                                             @"left":[NSString stringWithFormat:@"%.2f",leftNumber],
                                             @"right":[NSString stringWithFormat:@"%.2f%%",(leftNumber/(yesterday.floatValue))*100],
                                             @"today":dictTemp[HD_Contact][@"open"],
                                             @"yesterday":yesterday,
                                             @"Highest":dictTemp[HD_Contact][@"high"],
                                             @"lowest":dictTemp[HD_Contact][@"low"],
                                             @"name":HD_Contact,
                                             @"domain":@"baibei"};
                    dic_New = [NSMutableDictionary dictionaryWithDictionary:dicNew];
                }else{
                    NSDictionary *dicNew = @{@"title":HD_ProductName,
                                             @"number":@"0",
                                             @"left":@"0",
                                             @"right":@"0",
                                             @"today":@"0",
                                             @"yesterday":@"0",
                                             @"Highest":@"0",
                                             @"lowest":@"0",
                                             @"name":HD_Contact,
                                             @"domain":@"baibei"};
                    dic_New = [NSMutableDictionary dictionaryWithDictionary:dicNew];
                }
                dispatch_group_leave(gruop);
            }else{
                NSDictionary *dicNew = @{@"title":HD_ProductName,
                                         @"number":@"0",
                                         @"left":@"0",
                                         @"right":@"0",
                                         @"today":@"0",
                                         @"yesterday":@"0",
                                         @"Highest":@"0",
                                         @"lowest":@"0",
                                         @"name":HD_Contact,
                                         @"domain":@"baibei"};
                dic_New = [NSMutableDictionary dictionaryWithDictionary:dicNew];
                dispatch_group_leave(gruop);
            }
            [weakSelf.productListAry insertObject:dic_New atIndex:0];
        }];
    });
    dispatch_group_enter(gruop);
    dispatch_group_async(gruop, dispatch_get_global_queue(0, 0), ^{
        NSDictionary *dicparam2 = @{@"r":@"jlmmex/price/quote"};
        [GRNetWorking postWithURLString:@"?r=jlmmex/price/quote" parameters:dicparam2 callBack:^(NSDictionary *dict) {
            NSNumber *code = dict[@"status"];
            if ([code isEqualToNumber:@(HttpSuccess)]) {
                NSArray *ary = dict[@"recordset"];
                NSArray *aryTitle = @[@"吉微铜",@"吉微油",@"吉微银"];
                for (int i = 0; i<ary.count; i++) {
                    NSDictionary *dictTemp = ary[i];
                    CGFloat leftNumber = ((NSNumber *)dictTemp[@"latestPrice"]).floatValue - ((NSNumber *)dictTemp[@"priceAtEndLastday"]).floatValue;
                    NSDictionary *dicNew = @{@"title":aryTitle[i],
                                             @"number":[NSString stringWithFormat:@"%@",dictTemp[@"latestPrice"]],
                                             @"left":[NSString stringWithFormat:@"%.2f",leftNumber],
                                             @"right":[NSString stringWithFormat:@"%.2f%%",(leftNumber / ((NSNumber *)dictTemp[@"priceAtEndLastday"]).floatValue)*100],
                                             @"today":[NSString stringWithFormat:@"%@",dictTemp[@"priceAtBeginning"]],
                                             @"yesterday":[NSString stringWithFormat:@"%@",dictTemp[@"priceAtEndLastday"]],
                                             @"Highest":[NSString stringWithFormat:@"%@",dictTemp[@"highestPrice"]],
                                             @"lowest":[NSString stringWithFormat:@"%@",dictTemp[@"latestPrice"]],
                                             @"name":dictTemp[@"productContract"],
                                             @"domain":@"jlmmex"};//添加产品name
                    NSMutableDictionary *dic_new = [NSMutableDictionary dictionaryWithDictionary:dicNew];
                    [weakSelf.productListAry addObject:dic_new];
                }
                dispatch_group_leave(gruop);
            }else{
                NSArray *arySource = @[[NSMutableDictionary dictionaryWithDictionary:@{@"title":@"吉微铜",@"number":@"0",@"left":@"0",@"right":@"0",@"today":@"0",@"yesterday":@"0",@"Highest":@"0",@"lowest":@"0",@"domain":@"jlmmex"}],
                                       [NSMutableDictionary dictionaryWithDictionary:@{@"title":@"吉微油",@"number":@"0",@"left":@"0",@"right":@"0",@"today":@"0",@"yesterday":@"0",@"Highest":@"0",@"lowest":@"0",@"domain":@"jlmmex"}],
                                       [NSMutableDictionary dictionaryWithDictionary:@{@"title":@"吉微银",@"number":@"0",@"left":@"0",@"right":@"0",@"today":@"0",@"yesterday":@"0",@"Highest":@"0",@"lowest":@"0",@"domain":@"jlmmex"}]];
                for (NSMutableDictionary *smallDic in arySource) {
                    [weakSelf.productListAry addObject:smallDic];
                }
                dispatch_group_leave(gruop);
                [SVProgressHUD showErrorWithStatus:dict[@"message"]];
            }
        }];
    });
    dispatch_group_notify(gruop, dispatch_get_main_queue(), ^{
        self.propertyVC.productListAry = self.productListAry;
    });
//    dispatch_group_notify(gruop, <#dispatch_queue_t  _Nonnull queue#>, <#^(void)block#>)
}
@end
