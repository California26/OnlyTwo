//
//  GROpenPositionViewController.m
//  GoldRush
//
//  Created by Jack on 2017/1/4.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GROpenPositionViewController.h"

#import "GRDealHeader.h"
#import "GRDealMiddleView.h"
#import "GRDealBottomView.h"
#import "GRPurchaseView.h"

#import "GRHDProductModel.h"        ///恒大产品模型
#import "GRHDThicketsModel.h"       ///恒大赢家券模型

#import "GRJJProductModel.h"        ///吉交所产品模型

#import "GRJJThicketsModel.h"       ///吉交所赢家券模型


@interface GROpenPositionViewController ()<GRPurchaseViewDelegate,GRDealMiddleViewDelegate,GRDealHeaderDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
///参照 view
@property (nonatomic, weak) UIView *contentView;
///是否显示券
@property (nonatomic, assign) BOOL isShow;
///头部产品列表
@property (nonatomic, weak) GRDealHeader *productView;
///购置 view
@property (nonatomic, weak) GRPurchaseView *purchaseView;
///中间设置 view
@property (nonatomic, weak) GRDealMiddleView *settingView;
///购买价钱
@property (nonatomic, assign) NSString *handPrice;
///手续费
@property (nonatomic, assign) NSString *fee;
///购买手数
@property (nonatomic, assign) NSInteger handCount;
///产品数组
@property (nonatomic, strong) NSMutableArray *productJJArray;
@property (nonatomic, strong) NSMutableArray *productHDArray;
///产品ID
@property (nonatomic, copy) NSString *productId;
///产品
@property (nonatomic, copy) NSString *contract;
///买涨/跌
@property (nonatomic, copy) NSString *type;
///止盈
@property (nonatomic, copy) NSString *stopProfit;
///止损
@property (nonatomic, copy) NSString *stopLoss;

@property (nonatomic, strong) NSDictionary *thicketJJDict;

///吉交所可用赢家券数量
@property (nonatomic, copy) NSString *thicketJJ;
///吉交所选中的产品模型
@property (nonatomic, strong) GRJJProductModel *selectedJJModel;

///恒大券的数量
@property (nonatomic, copy) NSString *thicketHD;

///恒大赢家券数组
@property (nonatomic, strong) NSMutableArray *thicketHDArray;

///恒大选中的产品模型
@property (nonatomic, strong) GRHDProductModel *selectedHDModel;

@end

@implementation GROpenPositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建头部 View
    [self createTopView];
    
    //创建滚动 view
    [self createScrollView];
    
    //创建子视图
    [self createChildView];
    
    //创建购买 view
    [self createPurchaseView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //请求恒大产品列表
    if ([self.productName isEqualToString:HD_ProductName]) {
        [self requestHDproductList];
        self.settingView.HDOrJJ = NO;
    }else{
        [self requestJJproductList];
        self.settingView.HDOrJJ = YES;
    }
    
    self.productView.defaultSelected = @"selected";
    self.handCount = 1;
    self.isShow = NO;
    
}

///恒大的产品
- (void)requestHDproductList{
    NSDictionary *dict = @{@"r":@"baibei/product/getList"};
    WS(weakSelf)
    [GRNetWorking postWithURLString:@"?r=baibei/product/getList" parameters:dict callBack:^(NSDictionary *dict) {
        NSString *code = dict[@"status"];
        if (code.integerValue == HttpSuccess) {
            NSArray *array = dict[@"recordset"];
            for (NSDictionary *dict in array) {
                GRHDProductModel *model = [GRHDProductModel mj_objectWithKeyValues:dict];
                [weakSelf.productHDArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.productView.productArray = weakSelf.productHDArray;
                //默认是选中第一个产品的价钱
                GRHDProductModel *model = weakSelf.productHDArray.firstObject;
                weakSelf.selectedHDModel = model;
                weakSelf.handPrice = [NSString stringWithFormat:@"%.0f",model.price];
                weakSelf.fee = [NSString stringWithFormat:@"%.2f",model.fee];
                weakSelf.purchaseView.charge = [NSString stringWithFormat:@"%.2f",model.fee];
                weakSelf.purchaseView.price = [NSString stringWithFormat:@"%.2f",model.price + model.fee];
                weakSelf.productId = [NSString stringWithFormat:@"%zd",model.productId];
                weakSelf.contract = model.contract;
                weakSelf.stopLoss = @"0";
                weakSelf.stopProfit = @"0";
                weakSelf.handCount = 1;
            });
        }else if([dict[@"message"] isEqualToString:@"baibei"]){
            [GRUserDefault removeHDLogin];
            GRHDLoginViewController *loginHD = [[GRHDLoginViewController alloc] init];
            [self presentViewController:loginHD animated:YES completion:nil];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
    }];
    
    //获取不同(可用)券的数量
    NSDictionary *paramDict = @{@"r":@"baibei/user/couponsCount"};
    [GRNetWorking postWithURLString:@"?r=baibei/user/couponsCount" parameters:paramDict callBack:^(NSDictionary *dict) {
        NSString *code = dict[@"status"];
        if (code.integerValue == HttpSuccess) {
            NSArray *array = dict[@"recordset"];
            
            [weakSelf.thicketHDArray removeAllObjects];
            for (NSDictionary *dict in array) {
                GRHDThicketsModel *model = [GRHDThicketsModel mj_objectWithKeyValues:dict];
                [weakSelf.thicketHDArray addObject:model];
                
                if (model.couponId == 7 && weakSelf.handPrice.integerValue == 8) {
                    weakSelf.thicketHD = [NSString stringWithFormat:@"%zd",model.num];
                }else if (model.couponId == 8 && weakSelf.handPrice.integerValue == 200){
                    weakSelf.thicketHD = [NSString stringWithFormat:@"%zd",model.num];
                }else if (model.couponId == 9 && weakSelf.handPrice.integerValue == 80){
                    weakSelf.thicketHD = [NSString stringWithFormat:@"%zd",model.num];
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.settingView.thicketCount = weakSelf.thicketHD.integerValue;
            });
        }else if([dict[@"message"] isEqualToString:@"baibei"]){
            [GRUserDefault removeHDLogin];
            GRHDLoginViewController *loginHD = [[GRHDLoginViewController alloc] init];
            [self presentViewController:loginHD animated:YES completion:nil];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
    }];

}

///吉交所产品
- (void)requestJJproductList{
    WS(weakSelf)
    NSDictionary *paraDict = @{@"r":@"jlmmex/order/getallprds"};
    [GRNetWorking postWithURLString:@"?r=jlmmex/order/getallprds" parameters:paraDict callBack:^(NSDictionary *dict) {
        NSString *code = dict[@"status"];
        if (code.integerValue == HttpSuccess) {
            [weakSelf.productJJArray removeAllObjects];
            NSArray *array = dict[@"recordset"];
            for (NSDictionary *dict in array) {
                GRJJProductModel *model = [GRJJProductModel mj_objectWithKeyValues:dict];
                if ([weakSelf.productName isEqualToString:@"吉微银"] && [model.productNo isEqualToString:JJ_ContactXAG]) {
                    [weakSelf.productJJArray addObject:model];
                }else if ([weakSelf.productName isEqualToString:@"吉微铜"] && [model.productNo isEqualToString:JJ_ContactCU]){
                    [weakSelf.productJJArray addObject:model];
                }else if ([weakSelf.productName isEqualToString:@"吉微油"] && [model.productNo isEqualToString:JJ_ContactOIL]){
                    [weakSelf.productJJArray addObject:model];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.productView.productArray = weakSelf.productJJArray;
                //默认是选中第一个产品的价钱
                GRJJProductModel *model = weakSelf.productJJArray.firstObject;
                weakSelf.selectedJJModel = model;
                weakSelf.handPrice = [NSString stringWithFormat:@"%@",model.unitPrice];
                weakSelf.fee = [NSString stringWithFormat:@"%.2f",model.tradeFee.floatValue];
                weakSelf.purchaseView.charge = [NSString stringWithFormat:@"%.2f",model.tradeFee.floatValue];
                weakSelf.purchaseView.price = [NSString stringWithFormat:@"%.2f",model.unitPrice.floatValue + model.tradeFee.floatValue];
                weakSelf.productId = [NSString stringWithFormat:@"%@",model.productID];
                weakSelf.stopLoss = @"0";
                weakSelf.stopProfit = @"0";
                weakSelf.settingView.type = model.unitPrice;
                weakSelf.handCount = 1;
            });
        }else if ([dict[@"message"] isEqualToString:@"jlmmex"]){
            GRJJLoginViewController *loginVC = [[GRJJLoginViewController alloc] init];
            [self presentViewController:loginVC animated:YES completion:nil];
            [GRUserDefault removeJJLogin];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
    }];
    
    ///用户资产统计
    NSDictionary *paramaDict = @{@"r":@"jlmmex/user/property"};
    [GRNetWorking postWithURLString:@"?r=jlmmex/user/property" parameters:paramaDict callBack:^(NSDictionary *dict) {
        NSString *code = dict[@"status"];
        if (code.integerValue == HttpSuccess) {
            if ([dict[@"recordset"][@"tickets"] isKindOfClass:[NSDictionary class]]) {
                weakSelf.thicketJJDict = dict[@"recordset"][@"tickets"];
                weakSelf.thicketJJ = [NSString stringWithFormat:@"%@",weakSelf.thicketJJDict[weakSelf.handPrice]];
            }
            
        }else if ([dict[@"message"] isEqualToString:@"jlmmex"]){
            GRJJLoginViewController *loginVC = [[GRJJLoginViewController alloc] init];
            [self presentViewController:loginVC animated:YES completion:nil];
            [GRUserDefault removeJJLogin];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.settingView.thicketCount = weakSelf.thicketJJ.integerValue;
        });
    }];
}

//创建 scrollview
- (void)createScrollView{
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height)];
    [self.view addSubview:scroll];
    scroll.backgroundColor = GRColor(240, 240, 240);
    self.scrollView = scroll;
    
    UIView *content = [[UIView alloc] init];
    self.contentView = content;
    [scroll addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scroll);
        make.width.equalTo(scroll);
    }];
}

//创建子视图
- (void)createChildView{
    GRDealHeader *head = [[GRDealHeader alloc] init];
    head.isRise = self.isRise;
    head.productName = self.productName;
    head.productPrice = self.currentPrice;
    self.productView = head;
    WS(weakSelf)
    head.delegate = self;
    [self.contentView addSubview:head];
    head.backgroundColor = [UIColor whiteColor];
    [head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_top).offset(10);
        make.width.equalTo(self.scrollView.mas_width);
        make.left.and.right.equalTo(self.scrollView);
        if (iPhone6P) {
            make.height.equalTo(@225);
        }else if (iPhone6){
            make.height.equalTo(@210);
        }else{
            make.height.equalTo(@190);
        }
    }];
    
    GRDealMiddleView *middle = [[GRDealMiddleView alloc] init];
    [self.contentView addSubview:middle];
    middle.backgroundColor = [UIColor whiteColor];
    middle.layer.cornerRadius = 10.0;
    middle.layer.masksToBounds = YES;
    [middle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView).offset(13);
        make.top.equalTo(head.mas_bottom).offset(10);
        make.right.equalTo(self.scrollView).offset(-13);
        make.height.equalTo(@180);
    }];
    self.settingView = middle;
    middle.delegate = self;
    middle.numberBlock = ^(NSInteger count){
        weakSelf.handCount = count;
        if (weakSelf.isShow) {
            weakSelf.purchaseView.price = [NSString stringWithFormat:@"%.2f",(weakSelf.handPrice.floatValue + weakSelf.fee.floatValue) * (weakSelf.handCount - 1)];
            weakSelf.purchaseView.charge = [NSString stringWithFormat:@"%.2f",weakSelf.fee.floatValue * (weakSelf.handCount - 1)];
        }else{
            weakSelf.purchaseView.price = [NSString stringWithFormat:@"%.2f",(weakSelf.handPrice.floatValue + weakSelf.fee.floatValue ) * count];
            weakSelf.purchaseView.charge = [NSString stringWithFormat:@"%.2f",weakSelf.fee.floatValue * weakSelf.handCount];
        }
    };
    middle.stopProfit = ^(NSInteger stopProfit){
        weakSelf.stopProfit = [NSString stringWithFormat:@"%zd",stopProfit];
    };
    middle.stopLoss = ^(NSInteger stopLoss){
        weakSelf.stopLoss = [NSString stringWithFormat:@"%zd",stopLoss];
    };
    
    GRDealBottomView *bottom = [[GRDealBottomView alloc] init];
    [self.contentView addSubview:bottom];
    bottom.attentionArray = @[@"1.只能持仓一笔,需平仓才能建仓",@"2.持仓不支持过夜,收盘自动平仓"];
    [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(middle.mas_bottom).offset(10);
        make.left.and.right.equalTo(self.scrollView);
        make.height.equalTo(@100);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottom.mas_bottom).offset(10 + 40);
    }];
}

//创建购买 view
- (void)createPurchaseView{
    GRPurchaseView *purchase = [[GRPurchaseView alloc] init];
    self.purchaseView = purchase;
    self.purchaseView.delegate = self;
    self.purchaseView.stringResultTitle = self.stringResultTitle;
    [self.view addSubview:purchase];
    [self.view bringSubviewToFront:purchase];
    purchase.price = self.handPrice;
    [purchase mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.right.equalTo(self.view);
        make.height.equalTo(@40);
    }];
}

//创建头部 View
- (void)createTopView{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 38)];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor colorWithHexString:@"#ffffff"];
    title.font = [UIFont boldSystemFontOfSize:18];
    title.text = @"建仓";
    self.navigationItem.titleView = title;
}

#pragma mark - peivate method
- (void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - GRDealHeaderDelegate
- (void)gr_dealHeaderView:(GRDealHeader *)view didProductBtn:(UIButton *)btn{
    view.isUseTicket = self.isShow;
    if ([self.productName isEqualToString:HD_ProductName]) {    ///恒大
        if (self.productHDArray.count) {
            GRHDProductModel *model = self.productHDArray[btn.tag - 3456];
            self.selectedHDModel = model;
            self.handPrice = [btn.titleLabel.text substringFromIndex:1];
            
            for (GRHDThicketsModel *model in self.thicketHDArray) {
                if (model.couponId == 7 && self.handPrice.integerValue == 8) {
                    self.thicketHD = [NSString stringWithFormat:@"%zd",model.num];
                }else if (model.couponId == 8 && self.handPrice.integerValue == 200){
                    self.thicketHD = [NSString stringWithFormat:@"%zd",model.num];
                }else if (model.couponId == 9 && self.handPrice.integerValue == 80){
                    self.thicketHD = [NSString stringWithFormat:@"%zd",model.num];
                }
            }
            self.settingView.thicketCount = self.thicketHD.integerValue;
            
            //判断是否显示用券信息
            if (self.thicketHD.integerValue == 0) {
                view.isUseTicket = NO;
                self.isShow = NO;
            }else{
                if (self.isShow) {
                    view.isUseTicket = YES;
                }else{
                    view.isUseTicket = NO;
                }
            }
            if (self.isShow) {
                self.purchaseView.price = [NSString stringWithFormat:@"%.2f",(self.handPrice.floatValue + model.fee) * (self.handCount - 1)];
                self.purchaseView.charge = [NSString stringWithFormat:@"%.2f",model.fee * (self.handCount - 1)];
            }else{
                self.purchaseView.price = [NSString stringWithFormat:@"%.2f",(self.handPrice.floatValue + model.fee) * self.handCount];
                self.purchaseView.charge = [NSString stringWithFormat:@"%.2f",model.fee * self.handCount];
            }
            self.fee = [NSString stringWithFormat:@"%.2f",model.fee];
            self.productId = [NSString stringWithFormat:@"%zd",model.productId];
            self.contract = model.contract;
        }
    }else{      ///吉交所
        if (self.productJJArray.count) {
            GRJJProductModel *model = self.productJJArray[btn.tag - 3456];
            self.handPrice = [btn.titleLabel.text substringFromIndex:1];
            self.settingView.type = model.unitPrice;
            
            self.thicketJJ = [NSString stringWithFormat:@"%@",self.thicketJJDict[self.handPrice]];
            self.settingView.thicketCount = self.thicketJJ.integerValue;
            //判断是否显示用券信息
            if (self.thicketJJ.integerValue == 0) {
                view.isUseTicket = NO;
                self.isShow = NO;
            }else{
                if (self.isShow) {
                    view.isUseTicket = YES;
                }else{
                    view.isUseTicket = NO;
                }
            }
            
            if (self.isShow) {
                self.purchaseView.price = [NSString stringWithFormat:@"%.2f",(self.handPrice.floatValue + model.tradeFee.floatValue) * (self.handCount - 1)];
                self.purchaseView.charge = [NSString stringWithFormat:@"%.2f",model.tradeFee.floatValue * (self.handCount - 1)];
            }else{
                self.purchaseView.price = [NSString stringWithFormat:@"%.2f",(self.handPrice.floatValue + model.tradeFee.floatValue) * self.handCount];
                self.purchaseView.charge = [NSString stringWithFormat:@"%.2f",model.tradeFee.floatValue * self.handCount];
            }
            self.purchaseView.charge = [NSString stringWithFormat:@"%.2f",model.tradeFee.floatValue * self.handCount];
            self.fee = [NSString stringWithFormat:@"%.2f",model.tradeFee.floatValue];
            self.productId = [NSString stringWithFormat:@"%@",model.productID];
        }
    }
}

#pragma mark - GRDealMiddleViewDelegate
- (void)gr_dealMiddleView:(GRDealMiddleView *)view didClickSwitch:(UISwitch *)switchBtn{
    if ([self.productName isEqualToString:HD_ProductName]){
        if (self.thicketHD.integerValue) {
            self.productView.isUseTicket = switchBtn.isOn;
            self.isShow = switchBtn.isOn;
            if (self.isShow) {
                self.purchaseView.price = [NSString stringWithFormat:@"%.2f",(self.handPrice.floatValue + self.selectedHDModel.fee) * (self.handCount - 1)];
                self.purchaseView.charge = [NSString stringWithFormat:@"%.2f",self.fee.floatValue * (self.handCount - 1)];
                view.thicketCount = self.thicketHD.integerValue;
            }else{
                self.purchaseView.price = [NSString stringWithFormat:@"%.2f",(self.handPrice.floatValue + self.selectedHDModel.fee) * self.handCount];
                self.purchaseView.charge = [NSString stringWithFormat:@"%.2f",self.fee.floatValue * self.handCount];
                view.thicketCount = self.thicketHD.integerValue;
            }
        }else{
            [SVProgressHUD showInfoWithStatus:@"当前没有可使用的赢家券"];
        }
    }else{
        if (self.thicketJJ.integerValue) {
            self.productView.isUseTicket = switchBtn.isOn;
            self.isShow = switchBtn.isOn;
            if (self.isShow) {
                self.purchaseView.price = [NSString stringWithFormat:@"%.2f",(self.handPrice.floatValue + self.selectedJJModel.tradeFee.floatValue) * (self.handCount - 1)];
                self.purchaseView.charge = [NSString stringWithFormat:@"%.2f",self.fee.floatValue * (self.handCount - 1)];
                view.thicketCount = self.thicketJJ.integerValue;
            }else{
                self.purchaseView.price = [NSString stringWithFormat:@"%.2f",(self.handPrice.floatValue + self.selectedJJModel.tradeFee.floatValue) * self.handCount];
                self.purchaseView.charge = [NSString stringWithFormat:@"%.2f",self.fee.floatValue * self.handCount];
                view.thicketCount = self.thicketJJ.integerValue;
            }
        }else{
            [SVProgressHUD showInfoWithStatus:@"当前没有可使用的赢家券"];
        }
    }
}

#pragma mark - GRPurchaseViewDelegate
- (void)resultButtonAction{
    [self.scrollView endEditing:YES];
    ///恒大建仓
    if ([self.productName isEqualToString:HD_ProductName]) {
        if ([self.stringResultTitle isEqualToString:@"买涨下单"]) {
            self.type = @"2";
        }else{
            self.type = @"1";
        }
        NSDictionary *dict = @{@"productId":self.productId,
                               @"contract":self.contract,
                               @"type":self.type,
                               @"sl":[NSString stringWithFormat:@"%zd",self.handCount],
                               @"isJuan":[NSString stringWithFormat:@"%d",self.isShow],
                               @"toplimit":self.stopProfit,
                               @"bottomlimit":self.stopLoss,
                               @"r":@"baibei/trade/createOrder"};
        [GRNetWorking postWithURLString:@"?r=baibei/trade/createOrder" parameters:dict callBack:^(NSDictionary *dict) {
            NSString *code = dict[@"status"];
            if (code.integerValue == HttpSuccess) {
                [self.delegate successResultAction];
                [SVProgressHUD showSuccessWithStatus:@"建仓成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:GRPositionHoldOrStopNotification object:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else if([dict[@"message"] isEqualToString:@"baibei"]){
                [GRUserDefault removeHDLogin];
                GRHDLoginViewController *loginHD = [[GRHDLoginViewController alloc] init];
                [self presentViewController:loginHD animated:YES completion:nil];
            }else{
                [SVProgressHUD showInfoWithStatus:dict[@"message"]];
            }
        }];
    }else{          /// 吉交所建仓
        if ([self.stringResultTitle isEqualToString:@"买涨下单"]) {
            self.type = @"1";
        }else{
            self.type = @"2";
        }
        NSDictionary *paraDict = @{@"productId":self.productId,
                               @"tradeType":self.type,
                               @"amount":[NSString stringWithFormat:@"%zd",self.handCount],
                               @"useTicket":[NSString stringWithFormat:@"%d",self.isShow],
                               @"targetProfit":self.stopProfit,
                               @"stopLoss":self.stopLoss,
                               @"r":@"jlmmex/order/create"};
        [GRNetWorking postWithURLString:@"?r=jlmmex/order/create" parameters:paraDict callBack:^(NSDictionary *dict) {
            NSString *code = dict[@"status"];
            if (code.integerValue == HttpSuccess) {
                [self.delegate successResultAction];
                [SVProgressHUD showSuccessWithStatus:@"建仓成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:GRPositionHoldOrStopNotification object:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else if ([dict[@"message"] isEqualToString:@"jlmmex"]){
                GRJJLoginViewController *loginVC = [[GRJJLoginViewController alloc] init];
                [self presentViewController:loginVC animated:YES completion:nil];
                [GRUserDefault removeJJLogin];
            }else{
                [SVProgressHUD showInfoWithStatus:dict[@"message"]];
            }
        }];
    }

}

#pragma mark - setter and getter
- (NSMutableArray *)productJJArray{
    if (!_productJJArray) {
        _productJJArray = [NSMutableArray array];
    }
    return _productJJArray;
}

- (NSMutableArray *)productHDArray{
    if (!_productHDArray) {
        _productHDArray = [NSMutableArray array];
    }
    return _productHDArray;
}

- (void)setRise:(BOOL)rise{
    _rise = rise;
    
    self.productView.isRise = self.isRise;
}

- (void)setProductName:(NSString *)productName{
    _productName = productName;
    self.productView.productName = productName;
}

- (void)setCurrentPrice:(NSString *)currentPrice{
    _currentPrice = currentPrice;
    self.productView.productPrice = currentPrice;
}

- (void)setStringResultTitle:(NSString *)stringResultTitle{
    _stringResultTitle = stringResultTitle;
    self.purchaseView.stringResultTitle = stringResultTitle;
}

- (NSMutableArray *)thicketHDArray{
    if (!_thicketHDArray) {
        _thicketHDArray = [NSMutableArray array];
    }
    return _thicketHDArray;
}

@end
