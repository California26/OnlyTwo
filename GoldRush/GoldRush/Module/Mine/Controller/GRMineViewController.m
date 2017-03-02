//
//  GRMineViewController.m
//  GoldRush
//
//  Created by Jack on 2016/12/18.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRMineViewController.h"
#import "UIBarButtonItem+GRItem.h"

/** 登陆注册 */
#import "GRLogInViewController.h"
#import "GRSupplementAssetsViewController.h"
/** 设置 */
#import "GRSettingViewController.h"
#import "GRMineHTMLViewController.h"
#import "GRFeedBackQuesionViewController.h"
#import "GRPersonSettingViewController.h"
#import "GRHDRegisterViewController.h"              ///设置交易密码/开户
#import "GRThicketsViewController.h"                ///抵金券
#import "GRMessageCenterViewController.h"           ///消息中心
#import "GRJJTestGetCodeViewController.h"

/** 自定义 cell */
#import "GRHeaderCell.h"
#import "GRMineCell.h"
#import "GRPropertyCell.h"

/** 头尾视图 */
#import "GROpenAccountView.h"
#import "GRContactPopView.h"

/** 模型 */
#import "GRSettingItem.h"
#import "GRPropertyDealDetail.h"
#import "GRJJHoldPositionModel.h"
#import "GRCalculateProfitLoss.h"
#import <UINavigationController+FDFullscreenPopGesture.h>

@interface GRMineViewController ()<UITableViewDelegate,
                                   UITableViewDataSource,
                                   GRHeaderCellDelegate>{
    CGFloat profitJJ, buyMoney, profitHD;
}

@property(nonatomic, weak) UITableView *mainTableView;              ///主 tableview
@property (nonatomic, strong) GRContactPopView *popView;            ///联系客服弹出 view
@property (nonatomic, strong) NSArray *dataArray;                    ///数据源数组
@property (nonatomic, strong) UIImage *selectedHeaderImage;         ///选中的头像图片

@property (nonatomic, copy) NSString *totalHD;                      ///恒大总资产
@property (nonatomic, copy) NSString *thicketHD;                    ///恒大抵金券
@property (nonatomic, copy) NSString *totalJJ;                      ///吉交总资产
@property (nonatomic, copy) NSString *thicketJJ;                    ///吉交抵金券

@property (nonatomic, strong) UIView *statusView;                   ///头部导航栏
@property (nonatomic, assign) BOOL isRequest;                       ///是否请求数据

@property (nonatomic, strong) NSMutableArray *holdPositionArray;    ///吉交所持仓数据
@property (nonatomic, strong) NSMutableArray *holdHDArray;          ///恒大持仓情况

@end

@implementation GRMineViewController

#pragma mark life cycle

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    //检测是否登陆
    if (self.isRequest) {
        [self isLogin];
    }else{
        ///恒大登陆检测
        if ([GRUserDefault getIsLoginHD]) {
            ///恒大资产
            [self requestHDProperty];
        }else{
            self.totalHD = @"0.00";
            self.thicketHD = @"0";
        }
        if ([GRUserDefault getIsLoginJJ]) {
            ///吉交所资产
            [self requestHttpJJ];
        }else{
            self.totalJJ = @"0.00";
            self.thicketJJ = @"0";
        }
        [self.mainTableView reloadData];
    }
    
    if ([GRUserDefault getUserPhone]) {
        //从沙盒拿
        NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
        UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
        
        if (savedImage) {
            self.selectedHeaderImage = savedImage;
            [self.mainTableView reloadData];
        }else{
            NSString *url = [GRUserDefault getValueForKey:@"header-icon"];
            self.selectedHeaderImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
            [self.mainTableView reloadData];
        }
    }else{
        self.selectedHeaderImage = [UIImage imageNamed:@"Header_Icon_Default"];
        [self.mainTableView reloadData];
    }
}

- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始数据
    [self initData];

    //初始化 tableview
    [self initTableView];
    
    //注册通知是否请求数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isRequestData:) name:GRAccountIsLoginNotification object:nil];
    
    //最新价通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushTheNewestPrice:) name:GRPositionNew_PriceSNotification object:nil];

}

#pragma mark - 通知方法
- (void)pushTheNewestPrice:(NSNotification *)notification{
    NSDictionary *dict = notification.userInfo;
    if ([GRUserDefault getIsLoginJJ]) {
        WS(weakSelf)
        self.totalJJ = [NSString stringWithFormat:@"%.2f",self.totalJJ.floatValue - profitJJ];
        self.holdPositionArray = [GRCalculateProfitLoss calculateJJProfitLossWithArray:self.holdPositionArray withNotificationDict:dict];
        CGFloat loss = 0.0f;
        for (GRJJHoldPositionModel *model in self.holdPositionArray) {
            loss += model.profitOrLoss.floatValue;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.totalJJ = [NSString stringWithFormat:@"%.2f",self.totalJJ.floatValue + loss];
            [weakSelf.mainTableView reloadData];
        });
    }
    if ([GRUserDefault getIsLoginHD]) {
        self.totalHD = [NSString stringWithFormat:@"%.2f",self.totalHD.floatValue - profitHD];
        self.holdHDArray = [GRCalculateProfitLoss calculateHDProfitLossWithArray:self.holdHDArray withNotificationDict:dict];
        CGFloat loss = 0.0f;
        for (GRPropertyDealDetail *model in self.holdHDArray) {
            loss += model.plAmount.floatValue;
        }
        WS(weakSelf)
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.totalHD = [NSString stringWithFormat:@"%.2f",weakSelf.totalHD.floatValue + loss];
            [weakSelf.mainTableView reloadData];
        });
    }
}

- (void)isRequestData:(NSNotification *)notification{
    NSDictionary *dict = notification.object;
    if ([dict[@"isRequest"] isEqualToString:@"NO"]) {
        self.isRequest = NO;
    }else{
        self.isRequest = YES;
    }
}

///检测是否登陆
- (void)isLogin{
    if ([GRUserDefault getUserPhone]) {
        [self.mainTableView reloadData];
        ///恒大登陆检测
        [self requestHttpHD];
        if ([GRUserDefault getIsLoginHD]) {
            ///恒大资产
            [self requestHDProperty];
        }else{
            self.totalHD = @"0.00";
            self.thicketHD = @"0";
        }
        if ([GRUserDefault getIsLoginJJ]) {
            ///吉交所资产
            [self requestHttpJJ];
        }else{
            self.totalJJ = @"0.00";
            self.thicketJJ = @"0";
        }
        [self.mainTableView reloadData];
    }else{
        self.totalHD = @"0.00";
        self.thicketHD = @"0";
        
        self.totalJJ = @"0.00";
        self.thicketJJ = @"0";
        
        [self.mainTableView reloadData];
    }
}

- (void)initData{
    self.navigationItem.title = @"个人中心";
    self.isRequest = YES;
    
    GRSettingItem *message = [GRSettingItem itemWithIcon:@"Mine_Message_Warn" title:@"消息提醒" destVcClass:[ GRMessageCenterViewController class]];
    GRSettingItem *help = [GRSettingItem itemWithIcon:@"Mine_Help_Center" title:@"帮助中心" destVcClass:[GRMineHTMLViewController class]];
    GRSettingItem *online = [GRSettingItem itemWithIcon:@"Mine_Contact_Service" title:@"联系客服"];
    GRSettingItem *hotline = [GRSettingItem itemWithIcon:@"Mine_Risk" title:@"风险提示" destVcClass:[GRMineHTMLViewController class]];
    GRSettingItem *about = [GRSettingItem itemWithIcon:@"Mine_Suggestion" title:@"意见反馈" destVcClass:[GRFeedBackQuesionViewController class]];
    
    GRSettingItem *risk = [GRSettingItem itemWithIcon:@"Mine_About_Us" title:@"关于我们" destVcClass:[GRMineHTMLViewController class]];
    self.dataArray = @[message,help,online,hotline,about,risk];
}

//吉交所用户资产
- (void)requestHttpJJ{
    WS(weakSelf)
    ///用户资产统计
    NSDictionary *paramDict = @{@"r":@"jlmmex/user/property"};
    [GRNetWorking postWithURLString:@"?r=jlmmex/user/property" parameters:paramDict callBack:^(NSDictionary *dict) {
        NSString *code = dict[@"status"];
        if (code.integerValue == HttpSuccess) {
            
            NSString *balance = dict[@"recordset"][@"balance"];
            NSString *profitLoss = dict[@"recordset"][@"profitLoss"];
            profitJJ = profitLoss.floatValue;
            NSString *tradeDeposit = dict[@"recordset"][@"tradeDeposit"];
            
            weakSelf.totalJJ = [NSString stringWithFormat:@"%.2f",balance.floatValue + tradeDeposit.floatValue + profitLoss.floatValue];
            
            if ([dict[@"recordset"][@"tickets"] isKindOfClass:[NSDictionary class]]) {
                NSArray *array = [dict[@"recordset"][@"tickets"] allValues];
                NSInteger thickets = 0;
                for (NSString *index in array) {
                    thickets += index.integerValue;
                }
                weakSelf.thicketJJ = [NSString stringWithFormat:@"%zd",thickets];
            }
        }else if ([dict[@"message"] isEqualToString:@"jlmmex"]){
            GRJJLoginViewController *loginVC = [[GRJJLoginViewController alloc] init];
            [self presentViewController:loginVC animated:YES completion:nil];
            [GRUserDefault removeJJLogin];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.mainTableView reloadData];
        });
    }];
    
    //获取用户持仓单列表
    NSDictionary *parDict = @{@"r":@"jlmmex/order/getNotLiquidateOrder"};
    [GRNetWorking postWithURLString:@"?r=jlmmex/order/getNotLiquidateOrder" parameters:parDict callBack:^(NSDictionary *dict) {
        NSNumber *code = dict[@"status"];
        if (code.integerValue == HttpSuccess) {
            [weakSelf.holdPositionArray removeAllObjects];
            NSArray *array = dict[@"recordset"][@"list"];
            for (NSDictionary *dictModel in array) {
                GRJJHoldPositionModel *model = [GRJJHoldPositionModel mj_objectWithKeyValues:dictModel];
                [self.holdPositionArray addObject:model];
            }
        }else if ([dict[@"message"] isEqualToString:@"jlmmex"]){
            GRJJLoginViewController *loginVC = [[GRJJLoginViewController alloc] init];
            [self presentViewController:loginVC animated:YES completion:nil];
            [GRUserDefault removeJJLogin];
        } else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.mainTableView reloadData];
        });
    }];
}

//恒大注册检测
- (void)requestHttpHD{
    WS(weakSelf)
    //检查手机号是否可以注册
    NSDictionary *parameDict = @{@"r":@"baibei/user/verifyMobile"};
    [GRNetWorking postWithURLString:@"?r=baibei/user/verifyMobile" parameters:parameDict callBack:^(NSDictionary *dict) {
        NSNumber *status = dict[@"status"];
        if ([status isEqualToNumber:@(HttpPhoneExist)]) {
            [GRUserDefault setKey:@"isRegistHD" Value:@(YES)];
            if (![GRUserDefault getIsLoginHD]) {
                GRHDLoginViewController *loginHDVC = [[GRHDLoginViewController alloc] init];
                [self presentViewController:loginHDVC animated:YES completion:nil];
            }
        }else if([status isEqualToNumber:@(HttpSuccess)]){
            
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
            [GRUserDefault removeAllKey];
            ///删除图片
            [self deleteFile];
            self.selectedHeaderImage = [UIImage imageNamed:@"Header_Icon_Default"];
            self.totalHD = @"0.00";
            self.thicketHD = @"0";
            self.totalJJ = @"0.00";
            self.thicketJJ = @"0";
        }
        dispatch_async(dispatch_get_main_queue(), ^{
           [weakSelf.mainTableView reloadData];
        });
    }];
}

///恒大资产
- (void)requestHDProperty{
    WS(weakSelf)
    ///用户资产统计
    NSDictionary *paramDict = @{@"r":@"baibei/user/property"};
    [GRNetWorking postWithURLString:@"?r=baibei/user/property" parameters:paramDict callBack:^(NSDictionary *dict) {
        NSNumber *code = dict[@"status"];
        if ([code isEqualToNumber:@(HttpSuccess)]) {
            NSString *balance = dict[@"recordset"][@"balance"];
            NSString *profitLoss = dict[@"recordset"][@"profitLoss"];
            profitHD = profitLoss.floatValue;
            NSString *tradeDeposit = dict[@"recordset"][@"tradeDeposit"];
            
            weakSelf.totalHD = [NSString stringWithFormat:@"%.2f",profitLoss.floatValue + balance.floatValue + tradeDeposit.floatValue];
            NSInteger thickets = 0;
            if ([dict[@"recordset"][@"tickets"] isKindOfClass:[NSDictionary class]]) {
                NSArray *array = [dict[@"recordset"][@"tickets"] allValues];
                for (NSString *index in array) {
                    thickets += index.integerValue;
                }
            }
            weakSelf.thicketHD = [NSString stringWithFormat:@"%zd",thickets];
        }else if([dict[@"message"] isEqualToString:@"baibei"]){
            [GRUserDefault removeHDLogin];
            GRHDLoginViewController *loginHD = [[GRHDLoginViewController alloc] init];
            [self presentViewController:loginHD animated:YES completion:nil];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.mainTableView reloadData];
        });
    }];
    
    //获取恒大持仓情况
    [GRNetWorking postWithURLString:@"?r=baibei/user/queryMyBuyList" parameters:@{@"r":@"baibei/user/queryMyBuyList"} callBack:^(NSDictionary *dict) {
        NSString *code = dict[@"status"];
        if (code.integerValue == HttpSuccess) {
            [weakSelf.holdHDArray removeAllObjects];
            for (NSDictionary *detailDict in dict[@"recordset"]) {
                GRPropertyDealDetail *model = [GRPropertyDealDetail mj_objectWithKeyValues:detailDict];
                [weakSelf.holdHDArray addObject:model];
            }
        }else if([dict[@"message"] isEqualToString:@"baibei"]){
            [GRUserDefault removeHDLogin];
            GRHDLoginViewController *loginHD = [[GRHDLoginViewController alloc] init];
            [self presentViewController:loginHD animated:YES completion:nil];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.mainTableView reloadData];
        });
    }];
}

//初始化 tableview
- (void)initTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height - 49) style:UITableViewStyleGrouped];
    self.mainTableView = tableView;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.mainTableView setSeparatorInset:UIEdgeInsetsZero];
    [self.mainTableView setLayoutMargins:UIEdgeInsetsZero];
    
    [self.view addSubview:self.mainTableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if(section == 1 || section == 2){
        return 1;
    }else{
        return self.dataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        GRHeaderCell *cell = [GRHeaderCell cellWithTableView:tableView];
        cell.delegate = self;
        if ([GRUserDefault getUserPhone]) {
            cell.isSucceed = YES;
        }else{
            cell.isSucceed = NO;
        }
        if (self.selectedHeaderImage) {
            cell.selectedImage = self.selectedHeaderImage;
        }
        cell.loginBlock = ^{
            GRLogInViewController *loginVC = [[GRLogInViewController alloc] init];
            [self presentViewController:loginVC animated:YES completion:nil];
        };
        return cell;
    }else if (indexPath.section == 1 || indexPath.section == 2){
        GRPropertyCell *property = [GRPropertyCell cellWithTableView:tableView];
        GRSupplementAssetsViewController *assestVC = [[GRSupplementAssetsViewController alloc] init];
        GRThicketsViewController *thicketsVC = [[GRThicketsViewController alloc] init];
        if (indexPath.section == 1) {
            assestVC.title = @"恒大资产明细";
            thicketsVC.title = @"恒大抵金券";
            property.money = self.totalHD;
            property.thicket = self.thicketHD;
        }else{
            assestVC.title = @"吉交资产明细";
            thicketsVC.title = @"吉交抵金券";
            property.money = self.totalJJ;
            property.thicket = self.thicketJJ;
        }
        GRHDLoginViewController *loginVCHD = [[GRHDLoginViewController alloc] init];
        GRLogInViewController *loginVC = [[GRLogInViewController alloc] init];
        WS(weakSelf)
        property.totalPropertyBlock = ^{
            if ([GRUserDefault getUserPhone]) {
                if (indexPath.section == 1) {
                    if ([GRUserDefault getIsLoginHD]) {
                        [weakSelf.navigationController pushViewController:assestVC animated:YES];
                    }else{
                        [weakSelf presentViewController:loginVCHD animated:YES completion:nil];
                    }
                }else{
                    if ([GRUserDefault getIsLoginJJ]) {
                        [weakSelf.navigationController pushViewController:assestVC animated:YES];
                    }else{
                        [weakSelf presentViewController:loginVCHD animated:YES completion:nil];
                    }
                }
            }else{
                [weakSelf presentViewController:loginVC animated:YES completion:nil];
            }
        };
        property.discountBlock = ^{
            if ([GRUserDefault getUserPhone]) {
                if (indexPath.section == 1) {
                    if ([GRUserDefault getIsLoginHD]) {
                        [weakSelf.navigationController pushViewController:thicketsVC animated:YES];
                    }else{
                        [weakSelf presentViewController:loginVCHD animated:YES completion:nil];
                    }
                }else{
                    if ([GRUserDefault getIsLoginJJ]) {
                        [weakSelf.navigationController pushViewController:thicketsVC animated:YES];
                    }else{
                        [weakSelf presentViewController:loginVCHD animated:YES completion:nil];
                    }
                }
            }else{
                [weakSelf presentViewController:loginVC animated:YES completion:nil];
            }
        };
        return property;
    } else if(indexPath.section == 3){
        GRMineCell *cell = [GRMineCell cellWithTableView:tableView];
        if (indexPath.row == 0) {
            cell.isMessage = YES;
        }
        cell.item = self.dataArray[indexPath.row];
        return cell;
    }else{
        GRHeaderCell *cell = [GRHeaderCell cellWithTableView:tableView];
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1 || section == 2) {
        GROpenAccountView *account = [[GROpenAccountView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 30)];
        if (section == 1) {
            account.type = @"恒交所";
            account.isSucceedRegister = [GRUserDefault getIsRegistHD];
            account.showBtn = [GRUserDefault getIsLoginHD];
        }else{
            account.type = @"吉交所";
            account.isSucceedRegister = [GRUserDefault getIsRegistJJ];
            account.showBtn = [GRUserDefault getIsLoginJJ];
        }

        account.openBlock = ^(NSString *type){
            if ([GRUserDefault getUserPhone]) {
                if ([type isEqualToString:@"恒交所"]) {
                    if (![GRUserDefault getIsRegistHD]) {
                        GRHDRegisterViewController *accountVC = [[GRHDRegisterViewController alloc] init];
                        accountVC.stringTitle = type;
                        [self presentViewController:accountVC animated:YES completion:nil];
                    }else{
                        GRHDLoginViewController *loginVC = [[GRHDLoginViewController alloc] init];
                        [self presentViewController:loginVC animated:YES completion:nil];
                    }
                }else{          ///吉交所
                    if (![GRUserDefault getIsRegistJJ]) {
                        GRJJTestGetCodeViewController *accountVC = [[GRJJTestGetCodeViewController alloc] init];
                        accountVC.type = @"获取手机验证码";
                        [self presentViewController:accountVC animated:YES completion:nil];
                    }else{
                        GRJJLoginViewController *loginVC = [[GRJJLoginViewController alloc] init];
                        [self presentViewController:loginVC animated:YES completion:nil];
                    }
                }
            }else{
                GRLogInViewController *loginVC = [[GRLogInViewController alloc] init];
                [self presentViewController:loginVC animated:YES completion:nil];
            }
        };
        
        account.loginBlock = ^(NSString *type){
            if ([type isEqualToString:@"恒交所"]) {
                if (![GRUserDefault getIsLoginHD]) {
                    GRHDLoginViewController *loginVC = [[GRHDLoginViewController alloc] init];
                    loginVC.title = type;
                    [self presentViewController:loginVC animated:YES completion:nil];
                }
            }else{
                if (![GRUserDefault getIsLoginJJ]) {
                    GRJJLoginViewController *loginVC = [[GRJJLoginViewController alloc] init];
                    loginVC.title = type;
                    [self presentViewController:loginVC animated:YES completion:nil];
                }
            }
        };
        return account;
    }else{
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 3) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 60)];
        label.text = @"版本归全民淘金所有";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:14];
        return label;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.0000001;
    }else if(section == 1 || section == 2) {
        return 40.0;
    }else{
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 0.0001;
    }else if (section == 3){
        return 60;
    } else{
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 220.0;
    }else if (indexPath.section == 1 || indexPath.section == 2){
        return 50;
    } else{
        return 64.0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 3){
        GRSettingItem *item = self.dataArray[indexPath.row];
        if (item.destVcClass) {
            GRMineHTMLViewController *vc = [[item.destVcClass alloc] init];
            vc.title = item.title;
            if (indexPath.row == 1) {
                vc.url = @"https://dev.taojin.6789.net/?r=help/view&id=6";
            }else if (indexPath.row == 3){
                vc.url = @"https://dev.taojin.6789.net/?r=about/risk";
            }else if (indexPath.row == 5){
                vc.url = @"https://dev.taojin.6789.net/?r=about";
            }
            [self.navigationController pushViewController:vc  animated:YES];
        }else{
            [[UIApplication sharedApplication].keyWindow addSubview:self.popView];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.y;
    if (offset < 30) {
        self.statusView.alpha = 0;
    }else {
        CGFloat alpha = (self.mainTableView.contentOffset.y - 30)/100;
        self.statusView.alpha = alpha;
    }
}

#pragma mark - GRHeaderCellDelegate
- (void)gr_headerCellClickHeader{
    if (![GRUserDefault getUserPhone]) {
        GRLogInViewController *loginVC = [[GRLogInViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
    }else{
        GRPersonSettingViewController *personVC = [[GRPersonSettingViewController alloc] init];
        personVC.settingBack = ^(UIImage *image){
            self.selectedHeaderImage = image;
        };
        [self.navigationController pushViewController:personVC animated:YES];
    }
}

#pragma mark - event response
// 删除沙盒里的文件
- (void)deleteFile {
    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    //文件名
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"currentImage.png"];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    if (!blHave) {
        return ;
    }else {
        BOOL blDele= [fileManager removeItemAtPath:uniquePath error:nil];
        if (blDele) {
            GRLog(@"dele success");
        }else {
            GRLog(@"dele fail");
        }
    }
}

#pragma mark - setter and getter
- (GRContactPopView *)popView{
    if (!_popView) {
        _popView = [[GRContactPopView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _popView;
}

- (UIView *)statusView{
    if (!_statusView) {
        _statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 64)];
        _statusView.backgroundColor = GRColor(192, 57, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, K_Screen_Width, 44)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.text = @"个人中心";
        label.font = [UIFont boldSystemFontOfSize:17];
        [_statusView addSubview:label];
        [self.view addSubview:_statusView];
    }
    return _statusView;
}

- (NSMutableArray *)holdPositionArray{
    if (!_holdPositionArray) {
        _holdPositionArray = [NSMutableArray array];
    }
    return _holdPositionArray;
}

- (NSMutableArray *)holdHDArray{
    if (!_holdHDArray) {
        _holdHDArray = [NSMutableArray array];
    }
    return _holdHDArray;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GRAccountIsLoginNotification object:nil];
}

@end

