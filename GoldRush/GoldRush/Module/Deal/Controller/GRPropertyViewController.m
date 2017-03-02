//
//  GRPropertyViewController.m
//  GoldRush
//
//  Created by Jack on 2016/12/18.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRPropertyViewController.h"
#import "PropertyConstant.h"

@interface GRPropertyViewController ()<proHeaderDelegate,CloseAlterDelegate,stopAlterDelegate,GRChart_EndViewDatasource,UITableViewDelegate,UITableViewDataSource,GRProProductDetailTableViewCellDelegate,ProductClickDelegate,alarmDelegate>
@property (nonatomic,strong) GRAlterCardAlarm                *alarmView;///提醒弹框
@property (nonatomic,strong) GRCloseAlterView                *closeAlterView;///平仓弹框
@property (nonatomic,strong) GRStopAlterView                 *stopAlterView;///止盈止损弹框
@property (nonatomic,strong) GRProHeaderView                 *topView;///导航栏顶部视图
@property (nonatomic,strong) GRPropertyLoopAnimationView     *loopView; ///循环视图
@property (nonatomic,strong) GRDealFooterView                *footer ;///买涨买跌按钮
@property (nonatomic,strong) GROpenPositionViewController    *openVC;///建仓页面
@property(nonatomic, strong) GRBlurEffect                    *blurEffect;///模糊背景
@property (nonatomic,strong) GRProProductBottomView          *bottomView;///规则视图
@property (nonatomic,strong) GRProductAllView                *productView ;//产品列表视图
@property (nonatomic,strong) GRChart_EndView                 *stockChartView; //K线图视图
@property (nonatomic,strong) UIView                          *tableHeaderView;
@property (nonatomic,strong) UITableView                     *tableView;

@property (nonatomic,strong) dispatch_source_t               timer;

@property (nonatomic,strong) GRChart_KLineGruopModel         *gruopModel;//k线图的数据模型
@property (nonatomic, copy)  NSMutableDictionary             *modelAllDict;//所有K线图的数据源
@property (nonatomic,strong) NSMutableArray                  *positionGroupModels;
@property (nonatomic,assign) NSInteger                       currentIndex; ///不同时段相应的值



@property (nonatomic, copy)  NSString                        *type;
@property (nonatomic, copy)  NSString                        *toplimit;//止盈比例
@property (nonatomic, copy)  NSString                        *bottomlimit;//止损比例
@property (nonatomic,assign) NSInteger                       selectTag;  ///选中的行数


@end

@implementation GRPropertyViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.positionGroupModels = [NSMutableArray arrayWithObjects:[NSArray array],[NSArray array],[NSArray array],[NSArray array], nil];
    _productListAry = @[].mutableCopy;
    _modelAllDict = [NSMutableDictionary dictionary];
    [self.view addSubview:self.tableView];


   if (self.clickCurrentProductTag) {
       
   }else{
       self.clickCurrentProductTag = 0;
   }
   self.currentIndex = 0;
   self.stockChartView.backgroundColor = [UIColor backgroundColor];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(holdOrStopPosition:) name:GRPositionHoldOrStopNotification object:nil];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(new_priceNotification:) name:GRPositionNew_PriceSNotification object:nil];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(new_dataNotification:) name:GRPositionNew_DataNotification object:nil];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getPersonalInformation];//获取个人资产
    [self.productListAry removeAllObjects];
    [self getDataCurrent];//四个产品的最新报价
    [self getCurrentPositionList];//持仓情况
}
- (void)setClickCurrentProductTag:(NSInteger)clickCurrentProductTag
{
    _clickCurrentProductTag = clickCurrentProductTag;
    if (self.productView.aryCount != nil && self.productView.aryCount.count > 0) {
        if (!clickCurrentProductTag) {
            clickCurrentProductTag = 0;
        }
        self.productView.index = clickCurrentProductTag;
        NSDictionary *dic = self.productListAry[self.clickCurrentProductTag];
        self.openVC.currentPrice = dic[@"number"];
        self.openVC.productName = dic[@"title"];
        self.openVC.rise = ![dic[@"left"] containsString:@"-"];
    }
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [[UIView alloc] init];
        self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height-49-64)];
        [self updateSubViews];
        //添加尾视图
        [self addFooterView];
        _tableView.tableHeaderView = self.tableHeaderView;
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        if (((NSArray *)self.positionGroupModels[self.clickCurrentProductTag]).count == 0) {
            return 1;
        }else{
           return  ((NSArray *)self.positionGroupModels[self.clickCurrentProductTag]).count;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 44;
    }else{
        if (((NSArray *)self.positionGroupModels[self.clickCurrentProductTag]).count == 0) {
            if (self.clickCurrentProductTag > 0) {
                if ([GRUserDefault getIsLoginJJ]) {
                    return 70;
                }else{
                    return 111;
                }
            }else{
                if ([GRUserDefault getIsLoginHD]) {
                    return 70;
                }else{
                    return 111;
                }
            }
        }else{
            return  45;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.000001;
    }
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        GRProProductTotalTableViewCell *cell = [GRProProductTotalTableViewCell cellWithTableView:tableView];
        if (self.positionGroupModels.count == 0) {
            
        }else{
            cell.aryData = ((NSArray *)self.positionGroupModels[self.clickCurrentProductTag]);
        }
        return cell;
    }else{
       if (((NSArray *)self.positionGroupModels[self.clickCurrentProductTag]).count == 0)  {
            static NSString *login = @"login";
            UITableViewCell *cellLogin = [tableView dequeueReusableCellWithIdentifier:login];
            for (UIView *view in cellLogin.contentView.subviews) {
                [view removeFromSuperview];
            }
            if (cellLogin == nil) {
                cellLogin = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:login];
                cellLogin.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(40, 40, K_Screen_Width-80, 35);
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:17];
            button.layer.cornerRadius = 5.0f;
            button.layer.masksToBounds = YES;
            button.backgroundColor = [UIColor colorWithHexString:@"d43c33"];
            [button addTarget:self action:@selector(currentLoginAction:) forControlEvents:UIControlEventTouchUpInside];
            [cellLogin.contentView addSubview:button];
            if (self.clickCurrentProductTag > 0) {
                if (![GRUserDefault getUserPhone]) {
                    [button setTitle:@"立刻开户" forState:UIControlStateNormal];
                    return cellLogin;
                }else if (![GRUserDefault getIsLoginJJ]) {
                    [button setTitle:@"立刻登录" forState:UIControlStateNormal];
                    return cellLogin;
                }
                else{
                    GRProProductNoTableViewCell *cell = [GRProProductNoTableViewCell cellWithTableView:tableView];
                    return cell;
                }
            }else{
                if (![GRUserDefault getUserPhone]) {
                    [button setTitle:@"立刻开户" forState:UIControlStateNormal];
                    return cellLogin;
                }else if (![GRUserDefault getIsLoginHD]) {
                    [button setTitle:@"立刻登录" forState:UIControlStateNormal];
                    return cellLogin;
                }else{
                    GRProProductNoTableViewCell *cell = [GRProProductNoTableViewCell cellWithTableView:tableView];
                    return cell;
                }
            }
        }else{
            GRProProductDetailTableViewCell *cell = [GRProProductDetailTableViewCell cellWithTableView:tableView];
            cell.tag = indexPath.row;
            cell.delegate = self;
            if (self.clickCurrentProductTag > 0) {
                cell.positionModelJJ = ((NSArray *)self.positionGroupModels[self.clickCurrentProductTag])[indexPath.row];
            }else{
                cell.positionModel = ((NSArray *)self.positionGroupModels[self.clickCurrentProductTag])[indexPath.row];
            }
            return cell;
        }
    }
}

#pragma mark 订单统计
- (void)getOrderstatistics
{
    WS(weakself)
    NSMutableDictionary *dicParam = [NSMutableDictionary dictionary];
    [dicParam setObject:@"statistics/order" forKey:@"r"];
    [dicParam setObject:self.productListAry[self.clickCurrentProductTag][@"name"] forKey:@"contract"];
    [dicParam setObject:self.productListAry[self.clickCurrentProductTag][@"domain"] forKey:@"dataSource"];
    [GRNetWorking postWithURLString:@"?r=statistics/order" parameters:dicParam callBack:^(NSDictionary *dict) {
        NSNumber *status = dict[@"status"];
        if ([status isEqualToNumber:@(HttpSuccess)]) {
            NSNumber *rise = dict[@"recordset"][@"buyRiseCount"];
            NSNumber *fall = dict[@"recordset"][@"buyFallCount"];
            if (fall.floatValue == 0 && rise.floatValue == 0) {
                weakself.loopView.riseRate = @"0.5";
            }else{
                weakself.loopView.riseRate = [NSString stringWithFormat:@"%.2f",fall.floatValue/(rise.floatValue + fall.floatValue)];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:dict[@"message"]];
        }
    }];
}

#pragma mark 用户的持仓情况
- (void)getCurrentPositionList
{
    WS(weakself)
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSDictionary *dicparam = @{@"r":@"baibei/user/queryMyBuyList"};
        [GRNetWorking postWithURLString:@"?r=baibei/user/queryMyBuyList" parameters:dicparam callBack:^(NSDictionary *dict) {
            NSNumber *status = dict[@"status"];
            NSArray *ary = [NSArray array];
            if ([status isEqualToNumber:@(HttpSuccess)]) {
                ary = [GRPropertyDealDetail mj_objectArrayWithKeyValuesArray:dict[@"recordset"]];
                [weakself.positionGroupModels replaceObjectAtIndex:0 withObject:ary];
                dispatch_group_leave(group);
            }else if([status isEqualToNumber:@(HttpNoLogin)]){
                dispatch_group_leave(group);
            }else{
                [SVProgressHUD showErrorWithStatus:dict[@"message"]];
                dispatch_group_leave(group);
            }
        }];
        
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSDictionary *dicParam = @{@"r":@"jlmmex/order/getNotLiquidateOrder"};
        [GRNetWorking postWithURLString:@"?r=jlmmex/order/getNotLiquidateOrder" parameters:dicParam callBack:^(NSDictionary *dict) {
            NSNumber *status = dict[@"status"];
            NSMutableArray *aryCU = [NSMutableArray array];
            NSMutableArray *aryOIL = [NSMutableArray array];
            NSMutableArray *aryXAG = [NSMutableArray array];
            if ([status isEqualToNumber:@(HttpSuccess)]) {
                for (NSDictionary *dicSmall in dict[@"recordset"][@"list"]) {
                    GRJJHoldPositionModel *model = [GRJJHoldPositionModel mj_objectWithKeyValues:dicSmall];
                    if ([dicSmall[@"productNo"] isEqualToString:JJ_ContactCU]) {
                        [aryCU addObject:model];
                    }else if ([dicSmall[@"productNo"] isEqualToString:JJ_ContactOIL])
                    {
                        [aryOIL addObject:model];
                    }else{
                        [aryXAG addObject:model];
                    }
                }
                [weakself.positionGroupModels replaceObjectAtIndex:1 withObject:aryCU];
                [weakself.positionGroupModels replaceObjectAtIndex:2 withObject:aryOIL];
                [weakself.positionGroupModels replaceObjectAtIndex:3 withObject:aryXAG];
                dispatch_group_leave(group);
            }else if([status isEqualToNumber:@(HttpNoLogin)]){
                dispatch_group_leave(group);
            }else{
                [SVProgressHUD showErrorWithStatus:dict[@"message"]];
                dispatch_group_leave(group);
            }
        }];
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [weakself.tableView reloadData];
    });

    
}

#pragma mark 获得4个产品的所有数据源
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
                weakSelf.footer.isClose = NO;
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
//                dispatch_source_cancel(_timer);
                weakSelf.footer.isClose = YES;
                weakSelf.loopView.riseRate = @"0.5";
                weakSelf.productView.isClose = YES;
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
        weakSelf.productView.aryCount = weakSelf.productListAry;
        weakSelf.productView.index = weakSelf.clickCurrentProductTag;
        [weakSelf getOrderstatistics];//订单统计
        
        NSDictionary *dic = weakSelf.productListAry[weakSelf.clickCurrentProductTag];
        weakSelf.openVC.currentPrice = dic[@"number"];
        weakSelf.openVC.productName = dic[@"title"];
        weakSelf.openVC.rise = ![dic[@"left"] containsString:@"-"];
    });
}

- (GRChart_EndView *)stockChartView
{
    if (!_stockChartView) {
        _stockChartView = [GRChart_EndView new];
        _stockChartView.itemModels = @[
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"分时图" type:Y_StockChartcenterViewTypeTimeLine],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"5分" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"15分" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"30分" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"60分" type:Y_StockChartcenterViewTypeKline],
                                       ];
        
        _stockChartView.dataSource = self;
        _stockChartView.frame = CGRectMake(0, 69, K_Screen_Width, K_Screen_Height-277);
        _stockChartView.backgroundColor = [UIColor orangeColor];
            [self.tableHeaderView addSubview:self.stockChartView];
        
    }
    return _stockChartView;
}
//分时图按钮
- (id)stockDatasWithIndex:(NSInteger)index
{
    NSString *type;
    switch (index) {
        case 0:
        {
            type = @"分时图";
        }
            break;
        case 1:
        {
            type = @"5分";
        }
            break;
        case 2:
        {
            type = @"15分";
        }
            break;
        case 3:
        {
            type = @"30分";
        }
            break;
        case 4:
        {
            type = @"60分";
        }
            break;
        case 5:
        {
            type = @"日线图";
        }
            break;
        default:
            break;
    }
    self.currentIndex = index;
    self.type = type;
    NSDictionary *dicTemp =[self.modelAllDict objectForKey:[NSString stringWithFormat:@"%ld",(long)self.clickCurrentProductTag]];
    if (![dicTemp objectForKey:type]) {
        [self creatTempDataSource];
    }else{
        return ((GRChart_KLineGruopModel*)[dicTemp objectForKey:type]).models;
    }
    return nil;
}
//不同时间请求数据
- (void)creatTempDataSource
{
//    timeInterval = 60*15;
    if (self.currentIndex == 0) {
        [self createKChartSourceWithType:0];
    }else if (self.currentIndex == 1)
    {
        [self createKChartSourceWithType:1];
    }else if (self.currentIndex == 2)
    {
        [self createKChartSourceWithType:2];
    }else if (self.currentIndex == 3)
    {
        [self createKChartSourceWithType:3];
    }else if(self.currentIndex == 4){
        [self createKChartSourceWithType:4];
    }else{
        [self createKChartSourceWithType:7];
    }
}

#pragma mark K线图数据
- (void)createKChartSourceWithType:(NSInteger)tag
{
    tag = tag + 1;
//    self.stockChartView.stringYesterDayData = self.productListAry[self.clickCurrentProductTag][@"yesterday"];
    WS(weakself)
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *productType ;
    NSString *productName;
    NSString *dateString;
    [dic setObject:@"kline/get" forKey:@"r"];
    if (self.clickCurrentProductTag > 0) {
        productType = @"jlmmex";
        productName = ContactS[self.clickCurrentProductTag];
    }else{
        productType = @"baibei";
        productName = HD_Contact;
    }
    dateString = [GRUtils getCurrentDate];
    if (tag == 1) {
        [dic setObject:[dateString stringByAppendingString:@" 06:00:00"] forKey:@"startTime"];
    }
    [dic setObject:productType forKey:@"dataSource"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)tag] forKey:@"type"];
    [dic setObject:productName forKey:@"contract"];
    [GRNetWorking postWithURLString:@"?r=kline/get" parameters:dic callBack:^(NSDictionary *dict) {
        NSNumber *code = dict[@"status"];
        if ([code isEqualToNumber:@(HttpSuccess)]) {
            NSMutableArray *arytemp = [NSMutableArray arrayWithArray:dict[@"recordset"][@"data"]];
            NSMutableArray *aryModel = [NSMutableArray array];
            if (tag == 1) {
                for (NSInteger i = 0; i < arytemp.count; i++) {
                    NSMutableArray *smallAry = [NSMutableArray array];
                    [smallAry addObject:arytemp[i]];
                    NSString *stringDate = dict[@"recordset"][@"time"][i];
                    [smallAry addObject:stringDate];
                    [aryModel addObject:smallAry];
                }
            }else{
                for (NSInteger i = 0; i < arytemp.count; i++) {
                    NSMutableArray *smallAry = [NSMutableArray arrayWithArray:arytemp[i]];
                    NSString *stringDate = dict[@"recordset"][@"time"][i];
                    [smallAry addObject:stringDate];
                    [aryModel addObject:smallAry];
                }
            }
            GRChart_KLineGruopModel *groupModel = [GRChart_KLineGruopModel objectWithArray:[aryModel mutableCopy]];
            weakself.gruopModel = groupModel;
            NSDictionary *modelDict = @{weakself.type:groupModel};
            [weakself.modelAllDict setObject:modelDict forKey:[NSString stringWithFormat:@"%ld",(long)weakself.clickCurrentProductTag]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.stockChartView reloadData];
            });
        }

    }];
}
- (void)updateSubViews
{
    _topView = [[GRProHeaderView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 44)];
    _topView.delegate = self;
    _topView.money = 0.00;
    _topView.count = 0;
    self.navigationItem.titleView = self.topView;
    _productView = [[GRProductAllView alloc] initWithFrame:CGRectMake(0,0, K_Screen_Width, 69)];
    self.productView.delegate = self;
    [self.tableHeaderView addSubview:self.productView];
    _bottomView = [[GRProProductBottomView alloc] initWithFrame:CGRectMake(0, K_Screen_Height-49-20-64, K_Screen_Width, 20)];
    _bottomView.productName = HD_ProductName;
    [self.tableHeaderView addSubview:self.bottomView];
    //循环动画
    _loopView = [[GRPropertyLoopAnimationView alloc] initWithFrame:CGRectMake(0, K_Screen_Height - 49 - 55 - 30 - 64-5, K_Screen_Width, 10)];
    [self.tableHeaderView addSubview:self.loopView];
}


//底部 view
- (void)addFooterView{
    _footer = [[GRDealFooterView alloc] init];
    WS(weakSelf)
    self.openVC = [[GROpenPositionViewController alloc] init];
    _footer.riseClick = ^(UIButton *btn){
        if (self.clickCurrentProductTag > 0)
        {
            if (![GRUserDefault getUserPhone]) {
                GRLogInViewController *login = [[GRLogInViewController alloc] init];
                [weakSelf presentViewController:login animated:YES completion:nil];
            }else if (![GRUserDefault getIsLoginJJ]) {
                GRJJLoginViewController *loginJJ = [[GRJJLoginViewController alloc] init];
                [weakSelf presentViewController:loginJJ animated:YES completion:nil];
            }else{
                weakSelf.openVC.stringResultTitle = @"买涨下单";
                [weakSelf.navigationController pushViewController:weakSelf.openVC animated:YES];
            }
            
        }else{
            if (![GRUserDefault getUserPhone]) {
                GRLogInViewController *login = [[GRLogInViewController alloc] init];
                [weakSelf presentViewController:login animated:YES completion:nil];
            }else if (![GRUserDefault getIsLoginHD]) {
                GRHDLoginViewController *HDLogin = [[GRHDLoginViewController alloc] init];
                [weakSelf presentViewController:HDLogin animated:YES completion:nil];
            }else{
                weakSelf.openVC.stringResultTitle = @"买涨下单";
                [weakSelf.navigationController pushViewController:weakSelf.openVC animated:YES];
            }
        }
    };
    _footer.fallClick = ^(UIButton *btn)
    {
        if (self.clickCurrentProductTag > 0)
        {
            if (![GRUserDefault getUserPhone]) {
                GRLogInViewController *login = [[GRLogInViewController alloc] init];
                [weakSelf presentViewController:login animated:YES completion:nil];
            }else if (![GRUserDefault getIsLoginJJ]) {
                GRJJLoginViewController *loginJJ = [[GRJJLoginViewController alloc] init];
                [weakSelf presentViewController:loginJJ animated:YES completion:nil];
            }else{
                weakSelf.openVC.stringResultTitle = @"买跌下单";
                [weakSelf.navigationController pushViewController:weakSelf.openVC animated:YES];
            }
            
        }else{
            if (![GRUserDefault getUserPhone]) {
                GRLogInViewController *login = [[GRLogInViewController alloc] init];
                [weakSelf presentViewController:login animated:YES completion:nil];
            }else if (![GRUserDefault getIsLoginHD]) {
                GRHDLoginViewController *HDLogin = [[GRHDLoginViewController alloc] init];
                [weakSelf presentViewController:HDLogin animated:YES completion:nil];
            }else{
                weakSelf.openVC.stringResultTitle = @"买跌下单";
                [weakSelf.navigationController pushViewController:weakSelf.openVC animated:YES];
            }
        }
    };
    
    [self.tableHeaderView addSubview:self.footer];
    _footer.backgroundColor = [UIColor whiteColor];
    _footer.frame = CGRectMake(0, K_Screen_Height-55-49-20 - 64, K_Screen_Width, 55);
    
}

#pragma mark 获取个人信息
- (void)getPersonalInformation
{
    if (self.clickCurrentProductTag > 0) {//吉交所
        ///用户资产统计
        NSDictionary *paramDict = @{@"r":@"jlmmex/user/property"};
        [GRNetWorking postWithURLString:@"?r=jlmmex/user/property" parameters:paramDict callBack:^(NSDictionary *dict) {
            NSString *code = dict[@"status"];
            NSString *totalJJ,*thicketJJ;
            if (code.integerValue == HttpSuccess) {
                NSString *balance = dict[@"recordset"][@"balance"];
                NSString *profitLoss = dict[@"recordset"][@"profitLoss"];
                NSString *tradeDeposit = dict[@"recordset"][@"tradeDeposit"];
                
                totalJJ = [NSString stringWithFormat:@"%.2f",profitLoss.floatValue + balance.floatValue + tradeDeposit.floatValue];
                if ([dict[@"recordset"][@"tickets"] isKindOfClass:[NSDictionary class]]) {
                    NSArray *array = [dict[@"recordset"][@"tickets"] allValues];
                    NSInteger thickets = 0;
                    for (NSString *index in array) {
                        thickets += index.integerValue;
                    }
                    thicketJJ = [NSString stringWithFormat:@"%zd",thickets];
                }
            }else if([dict[@"message"] isEqualToString:@"jlmmex"]){
                [GRUserDefault removeJJLogin];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                _topView.money = totalJJ.floatValue;
                _topView.count = thicketJJ.integerValue;
            });
        }];
    }else{//恒大
        ///用户资产统计
        NSDictionary *paramDict = @{@"r":@"baibei/user/property"};
        [GRNetWorking postWithURLString:@"?r=baibei/user/property" parameters:paramDict callBack:^(NSDictionary *dict) {
            NSNumber *code = dict[@"status"];
            NSString *totalHD,*thicketHD;
            if ([code isEqualToNumber:@(HttpSuccess)]) {
                NSString *balance = dict[@"recordset"][@"balance"];
                NSString *profitLoss = dict[@"recordset"][@"profitLoss"];
                NSString *tradeDeposit = dict[@"recordset"][@"tradeDeposit"];
                
                totalHD = [NSString stringWithFormat:@"%.2f",profitLoss.floatValue + balance.floatValue + tradeDeposit.floatValue];
                NSInteger thickets = 0;
                if ([dict[@"recordset"][@"tickets"] isKindOfClass:[NSDictionary class]]) {
                    NSArray *array = [dict[@"recordset"][@"tickets"] allValues];
                    for (NSString *index in array) {
                        thickets += index.integerValue;
                    }
                }
                thicketHD = [NSString stringWithFormat:@"%zd",thickets];
            }else if([dict[@"message"] isEqualToString:@"baibei"]){
                [GRUserDefault removeHDLogin];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                _topView.money = totalHD.floatValue;
                _topView.count = thicketHD.integerValue;
            });
        }];
    }
}

#pragma mark proheaderDelegate 充值
- (void)rechargeAction{
    if ([GRUserDefault getUserPhone].length != 0) {
        if (self.clickCurrentProductTag > 0) {
            if ([GRUserDefault getIsRegistJJ]) {
                if ([GRUserDefault getIsLoginJJ]) {//已登录吉交所
                    GRRechargeViewController *rechargeVC = [[GRRechargeViewController alloc] init];
                    rechargeVC.title = @"吉交充值";
                    rechargeVC.charge = YES;
                    [self.navigationController pushViewController:rechargeVC animated:YES];
                }else{
                    GRJJLoginViewController *jjLogin = [[GRJJLoginViewController alloc] init];
                    [self presentViewController:jjLogin animated:YES completion:nil];
                }
            }else{
                GRTabBarController *tabbarVC = (GRTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                tabbarVC.selectedIndex = 4;
            }
        }else{
            if ([GRUserDefault getIsRegistHD]) {
                if ([GRUserDefault getIsLoginHD]) {//已登录恒大的
                    GRRechargeViewController *rechargeVC = [[GRRechargeViewController alloc] init];
                    rechargeVC.title = @"恒大充值";
                    rechargeVC.charge = YES;
                    [self.navigationController pushViewController:rechargeVC animated:YES];
                }else{
                    GRHDLoginViewController *loginHD = [[GRHDLoginViewController alloc] init];
                    [self presentViewController:loginHD animated:YES completion:nil];
                }
            }else{
                GRTabBarController *tabbarVC = (GRTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                tabbarVC.selectedIndex = 4;
            }
        }
    }else{
        GRTabBarController *tabbarVC = (GRTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        tabbarVC.selectedIndex = 4;
    }
}
#pragma mark  提醒按钮
- (void)warnAction
{
    //弹框提示
    self.blurEffect = [[GRBlurEffect alloc] init];
    self.alarmView = [[GRAlterCardAlarm alloc] initWithFrame:CGRectMake(13, 206, K_Screen_Width - 26, 203)];
    self.alarmView.delegate = self;
    WS(weakSelf)
    NSDictionary *dicparam = @{@"r":@"product/getPriceNotice",
                               @"dataSource":self.productListAry[self.clickCurrentProductTag][@"domain"],
                               @"contract":self.productListAry[self.clickCurrentProductTag][@"name"]};
    [GRNetWorking postWithURLString:@"?r=product/getPriceNotice" parameters:dicparam callBack:^(NSDictionary *dict) {
        NSNumber *status = dict[@"status"];
        if ([status isEqualToNumber:@(HttpSuccess)]) {
            if ([dict[@"recordset"] isKindOfClass:[NSDictionary class]]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.alarmView.stringSetPrice = dict[@"recordset"][@"price"];
                });
            }else{
                weakSelf.alarmView.stringSetPrice = @"0.00";
            }
        }
    }];
    self.alarmView.stringLastPrice = self.productListAry[self.clickCurrentProductTag][@"number"];
//    [UIView animateWithDuration:3.0 animations:^{
        [self.blurEffect addEffectiVieAndAlterView:self.alarmView];
//    }];
}

#pragma mark CloseAlterDelegate  平仓
- (void)closeAlterButton:(UIButton *)sender{
    UIView *viewTemp = sender.superview;
    if (sender.tag == 101) {
        if (self.clickCurrentProductTag > 0) {
            GRJJHoldPositionModel *model = [self.positionGroupModels objectAtIndex:self.clickCurrentProductTag][self.selectTag];
            NSDictionary *dicparam = @{@"r":@"jlmmex/order/liquidate",
                                       @"orderId":model.orderID};
            [GRNetWorking postWithURLString:@"?r=jlmmex/order/liquidate" parameters:dicparam callBack:^(NSDictionary *dict) {
                NSNumber *status = dict[@"status"];
                if ([status isEqualToNumber:@(HttpSuccess)]) {
                    [SVProgressHUD showSuccessWithStatus:dict[@"message"]];
                    [[NSNotificationCenter defaultCenter] postNotificationName:GRPositionHoldOrStopNotification object:nil];
                }else if([dict[@"message"] isEqualToString:@"jlmmex"]){
                    [GRUserDefault removeJJLogin];
                }
            }];
        }else{
            GRPropertyDealDetail *model = self.positionGroupModels[self.clickCurrentProductTag][self.selectTag];
            NSDictionary *dicParam = @{@"r":@"baibei/trade/closeOrder",
                                       @"orderId":model.orderId,
                                       @"contract":HD_Contact};
            [GRNetWorking postWithURLString:@"?r=baibei/trade/closeOrder" parameters:dicParam callBack:^(NSDictionary *dict) {
                NSNumber *status = dict[@"status"];
                if ([status isEqualToNumber:@(HttpSuccess)]) {
                    [SVProgressHUD showSuccessWithStatus:dict[@"message"]];
                    [[NSNotificationCenter defaultCenter] postNotificationName:GRPositionHoldOrStopNotification object:nil];
                }else if([dict[@"message"] isEqualToString:@"baibei"]){
                    [GRUserDefault removeHDLogin];
                }
            }];
        }
    }
    [viewTemp.superview removeFromSuperview];
}

#pragma mark stopAlterDelegate
- (void)stopAlterButton:(UIButton *)sender{
    [self.tableView endEditing:YES];
    UIView *viewTemp = sender.superview;
    if (sender.tag == 101) {
        if (self.toplimit == nil) {
            self.toplimit = @"0";
        }
        if (self.bottomlimit == nil) {
            self.bottomlimit = @"0";
        }
        if (self.clickCurrentProductTag > 0) {
            GRJJHoldPositionModel *model = self.positionGroupModels[self.clickCurrentProductTag][self.selectTag];
            NSDictionary *dicParam = @{@"r":@"?r=jlmmex/order/setPriceLimit",
                                       @"orderId":model.orderID,
                                       @"targetProfit":self.toplimit,
                                       @"stopLoss":self.bottomlimit};
            [GRNetWorking postWithURLString:@"?r=jlmmex/order/setPriceLimit" parameters:dicParam callBack:^(NSDictionary *dict) {
                NSNumber *status = dict[@"status"];
                if ([status isEqualToNumber:@(HttpSuccess)]) {
                    [SVProgressHUD showSuccessWithStatus:dict[@"message"]];
                    [[NSNotificationCenter defaultCenter] postNotificationName:GRPositionHoldOrStopNotification object:nil];
                }else if([dict[@"message"] isEqualToString:@"jlmmex"]){
                    [GRUserDefault removeJJLogin];
                }
            }];
        }else{
            GRPropertyDealDetail *model = self.positionGroupModels[self.clickCurrentProductTag][self.selectTag];
            NSDictionary *dicParam = @{@"r":@"baibei/trade/updateOrder",
                                       @"orderId":model.orderId,
                                       @"contract":HD_Contact,
                                       @"toplimit":self.toplimit,
                                       @"bottomlimit":self.bottomlimit};
            [GRNetWorking postWithURLString:@"?r=baibei/trade/updateOrder" parameters:dicParam callBack:^(NSDictionary *dict) {
                NSNumber *status = dict[@"status"];
                if ([status isEqualToNumber:@(HttpSuccess)]) {
                    [SVProgressHUD showSuccessWithStatus:dict[@"message"]];
                    [[NSNotificationCenter defaultCenter] postNotificationName:GRPositionHoldOrStopNotification object:nil];
                }else if([dict[@"message"] isEqualToString:@"baibei"]){
                    [GRUserDefault removeHDLogin];
                }
            }];
        }
    }
    [viewTemp.superview removeFromSuperview];
}

- (void)getWinOrLoseNumber:(UIView *)view number:(NSInteger)number
{
    [self.view endEditing:YES];
    if (view.tag == 100) {
        self.toplimit = [NSString stringWithFormat:@"%ld",(long)number];
    }else{
        self.bottomlimit = [NSString stringWithFormat:@"%ld",(long)number];
    }
}
#pragma mark GRProProductDetailTableViewCellDelegate
- (void)proProductDetailTableViewCellButtonStopAction:(NSInteger)sender
{
    self.selectTag = sender;
    self.blurEffect = [[GRBlurEffect alloc] init];
    if (self.clickCurrentProductTag > 0) {
        GRJJHoldPositionModel *model = self.positionGroupModels[self.clickCurrentProductTag][sender];
        self.closeAlterView = [[GRCloseAlterView alloc] initWithFrame:CGRectMake(13, -206, K_Screen_Width - 26, 203) stringKinds:self.productListAry[self.clickCurrentProductTag][@"name"] stringNew:self.productListAry[self.clickCurrentProductTag][@"number"] stringWin:[NSString stringWithFormat:@"%.2f",model.profitOrLoss.floatValue]];
    }else{
        GRPropertyDealDetail *model = self.positionGroupModels[self.clickCurrentProductTag][sender];
        self.closeAlterView = [[GRCloseAlterView alloc] initWithFrame:CGRectMake(13, -206, K_Screen_Width - 26, 203) stringKinds:HD_Contact stringNew:self.productListAry.firstObject[@"number"] stringWin:model.plAmount];
        [self.view addSubview:self.closeAlterView];
    }
    self.closeAlterView.delegate = self;
    [self.blurEffect addEffectiVieAndAlterView:self.closeAlterView];
    
}
#pragma mark   止盈止损
- (void)proProductDetailTableViewCellButtonAction:(NSInteger)sender
{
    self.selectTag = sender;
    self.blurEffect = [[GRBlurEffect alloc] init];
    _stopAlterView = [[GRStopAlterView alloc] initWithFrame:CGRectMake(13, -206, K_Screen_Width - 26, 203)];
    _stopAlterView.delegate = self;
    if (self.clickCurrentProductTag > 0) {
        GRJJHoldPositionModel *model = self.positionGroupModels[self.clickCurrentProductTag][sender];
        self.toplimit = [NSString stringWithFormat:@"%.0f",model.targetProfit.floatValue * 100];
        self.bottomlimit = [NSString stringWithFormat:@"%.0f",model.stopLoss.floatValue * 100];
        _stopAlterView.topLimit = model.targetProfit;
        _stopAlterView.bottomLimit = model.stopLoss;
    }else{
        GRPropertyDealDetail *model = self.positionGroupModels[self.clickCurrentProductTag][sender];
        self.toplimit = [NSString stringWithFormat:@"%.0f",model.topLimit.floatValue * 100];
        self.bottomlimit = [NSString stringWithFormat:@"%.0f",model.bottomLimit.floatValue * 100];
        _stopAlterView.topLimit = model.topLimit;
        _stopAlterView.bottomLimit = model.bottomLimit;
    }
    [self.blurEffect addEffectiVieAndAlterView:self.stopAlterView];
}

#pragma mark ProductClickDelegate切换不同的产品
- (void)clickProductAction:(NSInteger)tag
{
    GRLog(@"tag ======= %ld",(long)tag);
    NSAssert(self.productListAry.count == 4, @"数组长度不够");
    self.clickCurrentProductTag = tag;
    //买涨买跌需要传的参数
    NSDictionary *dic = self.productListAry[tag];
    self.openVC.productName = dic[@"title"];
    self.openVC.currentPrice = dic[@"number"];
    self.openVC.rise = ![dic[@"left"] containsString:@"-"];
    self.productView.index = self.clickCurrentProductTag;
    self.currentIndex = 0;
    self.stockChartView.segmentView.selectedIndex = self.currentIndex;
    [self creatTempDataSource];
    _bottomView.productName = dic[@"title"];
    [self.tableView reloadData];
    [self getPersonalInformation];
    [self getOrderstatistics];//订单统计
}
#pragma mark alarmDelegate提醒
- (void)buttonAction:(UIButton *)sender changePrice:(NSString *)text lastPrice:(NSString *)lastPrice
{
    UIView *viewTemp = sender.superview;
    if (sender.tag == 101) {
        NSString *stringName;
        if (self.clickCurrentProductTag > 0) {
            stringName = @"jlmmex";
        }else{
            stringName = @"baibei";
        }
        NSString *string1;
        CGFloat old = lastPrice.floatValue;
        CGFloat change = text.floatValue;
        if (change > old) {
            string1 = @"gt";
        }else{
            string1 = @"lt";
        }
        NSDictionary *dicParam = @{@"r":@"product/priceNotice",
                                   @"dataSource":stringName,
                                   @"contract":ContactS[self.clickCurrentProductTag],
                                   @"compare":string1,
                                   @"price":text};
        [GRNetWorking postWithURLString:@"?r=product/priceNotice" parameters:dicParam callBack:^(NSDictionary *dict) {
            NSNumber *status = dict[@"status"];
            if ([status isEqualToNumber:@(HttpSuccess)]) {
                [SVProgressHUD showSuccessWithStatus:@"设置成功"];
            }else{
                [SVProgressHUD showErrorWithStatus:dict[@"message"]];
            }
        }];
    }
    [viewTemp.superview removeFromSuperview];
}

#pragma mark 没有登陆
- (void)currentLoginAction:(UIButton *)sender
{
    GRTabBarController *tabbarVC = (GRTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    tabbarVC.selectedIndex = 4;
}
#pragma mark notification
- (void)holdOrStopPosition:(NSNotification *)notification
{
    [self getCurrentPositionList];
    [self getOrderstatistics];
}
- (void)new_priceNotification:(NSNotification *)notification
{
    NSDictionary *dic = notification.userInfo;
    if (self.productListAry.count == 0) {
        return;
    }else{
        for (int i = 0; i<self.productListAry.count; i++) {
            NSMutableDictionary *dic_old = self.productListAry[i];
            NSString *string = dic_old[@"yesterday"];
            CGFloat yesterday = string.floatValue;
            NSNumber *numberNew = dic[dic_old[@"domain"]][dic_old[@"name"]][@"current"];
            NSNumber *high = dic[dic_old[@"domain"]][dic_old[@"name"]][@"high"];
            NSNumber *low = dic[dic_old[@"domain"]][dic_old[@"name"]][@"low"];
            if (numberNew != nil) {
                [dic_old setObject:[NSString stringWithFormat:@"%@",numberNew] forKey:@"number"];
                [dic_old setObject:[NSString stringWithFormat:@"%@",high] forKey:@"Highest"];
                [dic_old setObject:[NSString stringWithFormat:@"%@",low] forKey:@"lowest"];
                [dic_old setObject:[NSString stringWithFormat:@"%.2f",numberNew.floatValue - yesterday] forKey:@"left"];
                [dic_old setObject:[NSString stringWithFormat:@"%.2f%%",(numberNew.floatValue - yesterday)/yesterday*100] forKey:@"right"];
                [self.productListAry replaceObjectAtIndex:i withObject:dic_old];
            }
        }
        self.productView.aryCount = self.productListAry;
        NSDictionary *dicTarget = self.productListAry[self.clickCurrentProductTag];
        self.openVC.currentPrice = dicTarget[@"number"];
        self.openVC.productName = dicTarget[@"title"];
        BOOL rise = [(NSString *)dicTarget[@"left"] containsString:@"-"];
        self.openVC.rise = !rise;
        
        NSMutableArray *ary = [GRCalculateProfitLoss calculateHDProfitLossWithArray:self.positionGroupModels.firstObject withNotificationDict:dic];
        [self.positionGroupModels replaceObjectAtIndex:0 withObject:ary];
        [self.tableView reloadData];
    }
}

- (void)new_dataNotification:(NSNotification *)notification
{
    NSDictionary *dic = notification.userInfo;
    [self.modelAllDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key1, id  _Nonnull obj1, BOOL * _Nonnull stop) {
        NSString *string1 ,*string2;
        NSString *stringDomain = key1;
        switch (stringDomain.intValue) {
            case 0:
                string1 = HD_Domain;
                string2 = HD_Contact;
                break;
            case 1:
                string1 = JJ_Domain;
                string2 = JJ_ContactCU;
                break;
            case 2:
                string1 = JJ_Domain;
                string2 = JJ_ContactOIL;
                break;
            case 3:
                string1 = JJ_Domain;
                string2 = JJ_ContactXAG;
                break;
            default:
                break;
        }
        NSString *strinKey = dic.allKeys.firstObject;
        if (![strinKey containsString:string1]) {
            return ;
        }
        else{
            if (![strinKey containsString:string2]) {
                return;
            }
        }
        NSDictionary *smallDic = obj1;
        [smallDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key2, id  _Nonnull obj2, BOOL * _Nonnull stop) {
            NSString *stringType;
            NSString *stringKey = key2;
            NSString *need_Key;
            GRChart_KLineGruopModel *groupModel = smallDic[stringKey];
            GRChart_KLineModel *model_Old = groupModel.models.lastObject;
            NSMutableArray *aryAdd_Model = [NSMutableArray arrayWithArray:groupModel.models];
            NSArray *aryNew_Model;
            if ([stringKey isEqualToString:@"分时图"]) {
                stringType = @"1";
                need_Key = [NSString stringWithFormat:@"%@_%@_%@",string1,string2,stringType];
                NSString *stringTime =  dic[need_Key][@"time"];
                NSNumber *new_datas = [dic[need_Key][@"data"] objectAtIndex:0];
                aryNew_Model = [NSArray arrayWithObjects:new_datas,stringTime, nil];
            }else if ([stringKey isEqualToString:@"5分"])
            {
                stringType = @"2";
                need_Key = [NSString stringWithFormat:@"%@_%@_%@",string1,string2,stringType];
                NSString *stringTime =  dic[need_Key][@"time"];
                NSArray *new_datas = dic[need_Key][@"data"];
                aryNew_Model = [NSArray arrayWithObjects:new_datas,stringTime, nil];
            }else if ([stringKey isEqualToString:@"15分"])
            {
                stringType = @"3";
                need_Key = [NSString stringWithFormat:@"%@_%@_%@",string1,string2,stringType];
                NSString *stringTime =  dic[need_Key][@"time"];
                NSArray *new_datas = dic[need_Key][@"data"];
                aryNew_Model = [NSArray arrayWithObjects:new_datas,stringTime, nil];
            }else if ([stringKey isEqualToString:@"30分"])
            {
                stringType = @"4";
                need_Key = [NSString stringWithFormat:@"%@_%@_%@",string1,string2,stringType];
                NSString *stringTime =  dic[need_Key][@"time"];
                NSArray *new_datas = dic[need_Key][@"data"];
                aryNew_Model = [NSArray arrayWithObjects:new_datas,stringTime, nil];
            }else{
                stringType = @"5";
                need_Key = [NSString stringWithFormat:@"%@_%@_%@",string1,string2,stringType];
                NSString *stringTime =  dic[need_Key][@"time"];
                NSArray *new_datas = dic[need_Key][@"data"];
                aryNew_Model = [NSArray arrayWithObjects:new_datas,stringTime, nil];
            }
            
            if (aryNew_Model.count == 0) {
                return ;
            }
            GRChart_KLineModel *model = [GRChart_KLineModel new];
            [model initWithArray:aryNew_Model];
            [aryAdd_Model addObject:model];
            
            groupModel.models = aryAdd_Model;
            NSDictionary *dic_new = @{self.type : groupModel};
            [self.modelAllDict setObject:dic_new forKey:key1];
            NSString *stringNeed1 = self.productListAry[self.clickCurrentProductTag][@"domain"];
            NSString *stringNeed2 = self.productListAry[self.clickCurrentProductTag][@"name"];
            NSString *new_keyNeed = [NSString stringWithFormat:@"%@_%@_%ld",stringNeed1,stringNeed2,self.currentIndex+1];
            
            if ([new_keyNeed isEqualToString:dic.allKeys.firstObject]) {
                NSDate  *dateLast = [GRUtils getTimeIntervalWithString:model_Old.date];
                NSComparisonResult comparisonResult = [[GRUtils getTimeIntervalWithString:dic[need_Key][@"time"]] compare:dateLast];
                if (comparisonResult == NSOrderedDescending) {
                    [self.stockChartView reloadData];
                }else if (comparisonResult == NSOrderedSame)
                {
                    
                }else{
                    [self creatTempDataSource];
                }
            }
        }];
    }];
}

- (void)kaishouArray:(NSNotification *)notifi
{
    NSDictionary *dic = notifi.userInfo;
    
}
#pragma mark -----------
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)dealloc{
//    dispatch_source_cancel(_timer);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
