//
//  GRDealViewController.m
//  GoldRush
//
//  Created by Jack on 2016/12/18.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRDealViewController.h"
//#import "GRLikeModel.h"
//#import "GRCommentModel.h"
#import "GRHomeCycleImage.h"

#import "UIBarButtonItem+GRItem.h"
/** 自定义 cell */
#import "GRSystemCell.h"
/** 自定义第三组的尾视图 */
//#import "GRSecondRankFooterView.h"
/** 广告 cell */
#import "GRADImageCell.h"
/** KLine 图 cell */
#import "GRKLineCell.h"
/** 第二组的尾视图 */
#import "GRNewHandSchoolFooterView.h"
#import <SDCycleScrollView.h>

/** 控制器 */
#import "GRNewHandViewController.h"
#import "GRMessageCenterViewController.h"
#import "GRDealADViewController.h"
#import "GRTabBarController.h"
#import "GRPropertyViewController.h"
#import "GRContractServiceViewController.h"
#import "GRHTMLViewController.h"

@interface GRDealViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

///主 tableview
@property(nonatomic, strong) UITableView *mainTableView;

///最新价数组
@property (nonatomic, strong) NSMutableArray *priceArray;

///图片数组
@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation GRDealViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //请求最新报价数据
    [self requestNewPrice];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    //设置导航栏
    [self initNavigationBar];
    //初始化 tableview
    [self initTableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushTheNewestPrice:) name:GRPositionNew_PriceSNotification object:nil];
    
    ///检查版本更新
//    [self checkAPPVersion];
    
    //请求轮播图接口
    [self requestList];
}

///检查版本更新
- (void)checkAPPVersion{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSDictionary *paraDict = @{@"r":@"upgrade/check",
                               @"currentVersion":version};
    [GRNetWorking postWithURLString:@"?r=upgrade/check" parameters:paraDict callBack:^(NSDictionary *dict) {
        NSNumber *code = dict[@"status"];
        if ([code isEqualToNumber:@(HttpSuccess)]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"有新版本啦" message:@"检查到有新版本，是否升级？" delegate:self cancelButtonTitle:@"前往更新" otherButtonTitles:nil, nil];
            alert.tag = 1011;
            [alert show];
        }else{
            [SVProgressHUD showWithStatus:dict[@"message"]];
        }
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1011 || alertView.tag == 1012) {
        if ([@"" isEqualToString:@"1"]) {   ///强制更新
            if (buttonIndex == 0) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@""]];
                exit(0);
            }
        } else {
            if (buttonIndex == 1) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@""]];
            }
        }
    }
}

#pragma mark - 通知方法
- (void)pushTheNewestPrice:(NSNotification *)notification{
    NSDictionary *dict = notification.userInfo;
    NSNumber *newPrice;
    if (dict.count) {
        for (int i = 0; i < self.priceArray.count; i++) {
            ///昨日收盘价
            NSNumber *lastPrice = self.priceArray[i][@"lastPrice"];
            ///上一次当前价钱
            NSNumber *prePrice = self.priceArray[i][@"theNewestPrice"];
            NSMutableDictionary *newPriceDict = [NSMutableDictionary dictionaryWithDictionary:self.priceArray[i]];
            if (0 == i) {
                newPrice = dict[@"baibei"][HD_Contact][@"current"];
                if (newPrice != nil) {
                    [newPriceDict setObject:newPrice forKey:@"theNewestPrice"];
                    if (newPrice.floatValue != prePrice.floatValue) {
                        [newPriceDict setObject:@YES forKey:@"isChange"];
                    }else{
                        [newPriceDict setObject:@NO forKey:@"isChange"];
                    }
                }else{
                    [newPriceDict setObject:@0 forKey:@"theNewestPrice"];
                }
            }else if (1 == i){
                newPrice = dict[@"jlmmex"][JJ_ContactCU][@"current"];
                if (newPrice != nil) {
                    [newPriceDict setObject:newPrice forKey:@"theNewestPrice"];
                    if (newPrice.floatValue != prePrice.floatValue) {
                        [newPriceDict setObject:@YES forKey:@"isChange"];
                    }else{
                        [newPriceDict setObject:@NO forKey:@"isChange"];
                    }
                }else{
                    [newPriceDict setObject:@0 forKey:@"theNewestPrice"];
                }
            }else if (2 == i){
                newPrice = dict[@"jlmmex"][JJ_ContactOIL][@"current"];
                if (newPrice != nil) {
                    [newPriceDict setObject:newPrice forKey:@"theNewestPrice"];
                    if (newPrice.floatValue != prePrice.floatValue) {
                        [newPriceDict setObject:@YES forKey:@"isChange"];
                    }else{
                        [newPriceDict setObject:@NO forKey:@"isChange"];
                    }
                }else{
                    [newPriceDict setObject:@0 forKey:@"theNewestPrice"];
                }
            }else if (3 == i){
                newPrice = dict[@"jlmmex"][JJ_ContactXAG][@"current"];
                if (newPrice != nil) {
                    [newPriceDict setObject:newPrice forKey:@"theNewestPrice"];
                    if (newPrice.floatValue != prePrice.floatValue) {
                        [newPriceDict setObject:@YES forKey:@"isChange"];
                    }else{
                        [newPriceDict setObject:@NO forKey:@"isChange"];
                    }
                }else{
                    [newPriceDict setObject:@0 forKey:@"theNewestPrice"];
                }
            }
            if (newPrice != nil) {
                [newPriceDict setObject:[NSString stringWithFormat:@"%.2f",newPrice.floatValue - lastPrice.floatValue] forKey:@"profitAndLoss"];
                [newPriceDict setObject:[NSString stringWithFormat:@"%.2f",(newPrice.floatValue - lastPrice.floatValue)/lastPrice.floatValue * 100] forKey:@"profitAndLossRate"];
                [self.priceArray replaceObjectAtIndex:i withObject:newPriceDict];
            }
        }
    }
    WS(weakSelf)
    NSIndexPath *index = [NSIndexPath indexPathForRow:1 inSection:1];
    GRKLineCell *cell = [self.mainTableView cellForRowAtIndexPath:index];
    dispatch_async(dispatch_get_main_queue(), ^{
        cell.dataArray = weakSelf.priceArray;
    });
}

- (void)requestList{
    WS(weakSelf)
    NSDictionary *paraDict = @{@"r":@"slide/getList",
                               @"cid":@"1"};
    [GRNetWorking postWithURLString:@"?r=slide/getList" parameters:paraDict callBack:^(NSDictionary *dict) {
        NSString *code = dict[@"status"];
        if (code.integerValue == HttpSuccess) {
            NSArray *dataArray = dict[@"recordset"];
            for (NSDictionary *imageDict in dataArray) {
                GRHomeCycleImage *model = [GRHomeCycleImage mj_objectWithKeyValues:imageDict];
                [weakSelf.imageArray addObject:model];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.mainTableView reloadData];
        });
    }];
}

//初始化导航栏
- (void)initNavigationBar{
    self.navigationItem.title = @"全民淘金";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem backItemWithimage:[UIImage imageNamed:@"Message"] highImage:[UIImage imageNamed:@"Message"] target:self action:@selector(messageClick:) title:nil];
}

//初始化 tableview
- (void)initTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height - 49 - 64) style:UITableViewStyleGrouped];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
}

//获取最新报价
- (void)requestNewPrice{
    WS(weakSelf)
    dispatch_group_t gruop = dispatch_group_create();
    dispatch_group_enter(gruop);
    ///恒大数据
    NSDictionary *paradict = @{@"r":@"baibei/forward/queryQuote"};
    [GRNetWorking postWithURLString:@"?r=baibei/forward/queryQuote" parameters:paradict callBack:^(NSDictionary *dict) {
        NSNumber *code = dict[@"status"];
        if ([code isEqualToNumber:@(HttpSuccess)]) {
            NSArray *priceArray = dict[@"recordset"];
            NSDictionary *priceDict = priceArray.firstObject;
            if ([priceDict[HD_Contact] isKindOfClass:[NSDictionary class]]) {
                NSString *newPrice = priceDict[HD_Contact][@"quote"];
                NSString *preClose = priceDict[HD_Contact][@"preClose"];
                
                [weakSelf.priceArray insertObject:@{@"theNewestPrice":[NSNumber numberWithDouble:newPrice.floatValue],
                                                    @"profitAndLoss":[NSString stringWithFormat:@"%.2f",(newPrice.floatValue - preClose.floatValue)],
                                                    @"profitAndLossRate":[NSString stringWithFormat:@"%.2f",(newPrice.floatValue - preClose.floatValue) / preClose.floatValue * 100],
                                                    @"lastPrice":preClose,
                                                    @"isChange":@NO} atIndex:0];
            }else{
                [weakSelf.priceArray insertObject:@{@"theNewestPrice":@(0),
                                                    @"profitAndLoss":@"0",
                                                    @"profitAndLossRate":@"0",
                                                    @"lastPrice":@"0",
                                                    @"isChange":@NO} atIndex:0];
            }
        }else if([dict[@"recordset"] isEqualToString:@""]){
            [weakSelf.priceArray insertObject:@{@"theNewestPrice":@(0),
                                                @"profitAndLoss":@"0",
                                                @"profitAndLossRate":@"0",
                                                @"lastPrice":@"0",
                                                @"isChange":@NO} atIndex:0];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
        dispatch_group_leave(gruop);
    }];
    
    dispatch_group_enter(gruop);
    NSDictionary *paramDict = @{@"r":@"jlmmex/price/quote"};
    //吉交所数据
    [GRNetWorking postWithURLString:@"?r=jlmmex/price/quote" parameters:paramDict callBack:^(NSDictionary *dict) {
        NSNumber *code = dict[@"status"];
        if ([code isEqualToNumber:@(HttpSuccess)]) {
            NSArray *array = dict[@"recordset"];
            if (array) {
                for (NSDictionary *priceDict in array) {
                    NSNumber *newPrice = priceDict[@"latestPrice"];
                    NSNumber *lastPrice = priceDict[@"priceAtEndLastday"];
                    [weakSelf.priceArray addObject:@{@"theNewestPrice":newPrice,
                                                     @"profitAndLoss":[NSString stringWithFormat:@"%.2f",(newPrice.floatValue - lastPrice.floatValue)],
                                                     @"profitAndLossRate":[NSString stringWithFormat:@"%.2f",(newPrice.floatValue - lastPrice.floatValue) / lastPrice.floatValue * 100],
                                                     @"lastPrice":lastPrice,
                                                     @"isChange":@NO}];
                }
            }
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
        dispatch_group_leave(gruop);
    }];
    
    dispatch_group_notify(gruop, dispatch_get_main_queue(), ^{
        [weakSelf.mainTableView reloadData];
    });
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else if (section == 1) {
        return 2;
    }else{
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1 && indexPath.row == 1){
        GRKLineCell *cell = [GRKLineCell cellWithTableView:tableView];
        if (self.priceArray) {
            cell.dataArray = self.priceArray;
        }
        cell.btnClick = ^(NSInteger index){
            GRTabBarController *tabbarVC = (GRTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            tabbarVC.selectedIndex = 2;
            UINavigationController *navigationVC = (UINavigationController *)tabbarVC.selectedViewController;
            GRPropertyViewController *propertyVC = (GRPropertyViewController *)navigationVC.topViewController;
            propertyVC.clickCurrentProductTag = index;
        };
        return cell;
    }else if(indexPath.section == 1){
        GRSystemCell *cell = [GRSystemCell cellWithTableView:tableView];
        cell.text = @"交易商品";
        return cell;
    }else if(indexPath.section == 2 && indexPath.row == 0){
        GRSystemCell *cell = [GRSystemCell cellWithTableView:tableView];
        cell.text = @"新手专享";
        return cell;
    }else {
        GRADImageCell *cell = [GRADImageCell cellWithTableView:tableView];
        WS(weakSelf)
        cell.imageClick = ^(){
            GRDealADViewController *ADVC = [[GRDealADViewController alloc] init];
            ADVC.title = @"全民学堂";
            [weakSelf.navigationController pushViewController:ADVC animated:YES];
        };
        cell.imageName = @"banner";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        NSMutableArray *array = [NSMutableArray array];
//        NSMutableArray *titleArray = [NSMutableArray array];
        for (GRHomeCycleImage *model in self.imageArray) {
            [array addObject:model.image];
//            [titleArray addObject:model.title];
        }
        SDCycleScrollView *header = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, K_Screen_Width, 150) imageURLStringsGroup:array];
        header.backgroundColor = [UIColor whiteColor];
        header.delegate = self;
//        header.titlesGroup = titleArray;
        return header;
    }else{
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1){
        GRNewHandSchoolFooterView *footer = [[GRNewHandSchoolFooterView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 100)];
        WS(weakSelf)
        footer.newHandClick = ^(NSString *type){
            if ([type isEqualToString:@"联系客服"]) {
                GRContractServiceViewController *contractVC = [[GRContractServiceViewController alloc] init];
                contractVC.title = type;
                [weakSelf.navigationController pushViewController:contractVC animated:YES];
            }else if ([type isEqualToString:@"新手学堂"]){
                GRNewHandViewController *newHandVC = [[GRNewHandViewController alloc] init];
                newHandVC.title = type;
                [weakSelf.navigationController pushViewController:newHandVC animated:YES];
            }else if ([type isEqualToString:@"行情资讯"]){
                GRHTMLViewController *newHandVC = [[GRHTMLViewController alloc] init];
                newHandVC.title = type;
                newHandVC.url = @"https://dev.taojin.6789.net/?r=news";
                [weakSelf.navigationController pushViewController:newHandVC animated:YES];
            } else{
                GRHTMLViewController *newHandVC = [[GRHTMLViewController alloc] init];
                newHandVC.title = type;
                newHandVC.url = @"";
                [weakSelf.navigationController pushViewController:newHandVC animated:YES];
            }
        };
        return footer;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 150;
    }else if (section == 1){
        return 0.001;
    }else{
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 110;
    } else{
        return 0.00001;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ((indexPath.section == 1 && indexPath.row == 0) || (indexPath.section == 2 && indexPath.row == 0)) {
        return 30;
    } else if(indexPath.section == 1 && indexPath.row == 1){
        return 110;
    }else{
        return 90;
    }
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    GRHomeCycleImage *model = self.imageArray[index];
    if (!model.targetType) {    ///可点击
        
    }
}

#pragma mark - event response
- (void)messageClick:(UIBarButtonItem *)item{
    GRMessageCenterViewController *message = [[GRMessageCenterViewController alloc] init];
    message.title = @"消息中心";
    message.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:message animated:YES];
}

#pragma mark - setter and getter
- (NSMutableArray *)priceArray{
    if (!_priceArray) {
        _priceArray = [NSMutableArray array];
    }
    return _priceArray;
}

- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GRPositionNew_PriceSNotification object:nil];
    [SDCycleScrollView clearImagesCache];
}

@end
