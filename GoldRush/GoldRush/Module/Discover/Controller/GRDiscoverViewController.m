//
//  GRDiscoverViewController.m
//  GoldRush
//
//  Created by Jack on 2016/12/18.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRDiscoverViewController.h"

//#import <SDCycleScrollView.h>           ///轮播图
//#import "GRIviteFriendCell.h"           ///请求好友
#import "GRDiscoverMiddleCell.h"        ///中间的 cell
#import "GRDiscover.h"                  ///数据模型
#import "GRHotEvents.h"                 ///活动模型
#import "GRHotEventsCell.h"             ///活动的 cell
#import "GRHotEventHeader.h"            ///活动的头部视图
//#import "GRDealRingViewController.h"        ///交易圈
#import "GRNewsViewController.h"        ///新闻资讯

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

#define CarouselHeight 160


@interface GRDiscoverViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, weak) UITableView *mainTableView;

@property(nonatomic, strong) NSMutableArray *dataArray;     ///数据源数组
@property(nonatomic, strong) NSMutableArray *eventArray;    ///活动的数组

@end

@implementation GRDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"发现";
    
    
    //初始化tableview
    [self initTableView];
    
    //添加数据
    self.dataArray = [GRDiscover mj_objectArrayWithKeyValuesArray:@[@{@"title":@"邀请好友",
                                                               @"iconUrl":@"Discover_Deal_Inivate",
                                                               @"desc":@"邀请好友注册,最高奖励5000元"},
                                                             @{@"title":@"新闻资讯",
                                                               @"iconUrl":@"Discover_Business_News",
                                                               @"desc":@"全球财经贵金属资讯动态"}]];
    
    self.eventArray = [GRHotEvents mj_objectArrayWithKeyValuesArray:@[@{@"imageUrl":@"Discover_AD",
                                                                           @"title":@"交易送奖券",
                                                                           @"time":@"2017-01-01~2017-02-01",
                                                                           @"status":@" 进行中"
                                                                           },
                                                                         @{@"imageUrl":@"Discover_AD",
                                                                           @"title":@"交易送奖券",
                                                                           @"time":@"2017-01-01~2017-02-01",
                                                                           @"status":@" 进行中"
                                                                           },
                                                                         @{@"imageUrl":@"Discover_AD",
                                                                           @"title":@"交易送奖券",
                                                                           @"time":@"2017-01-01~2017-02-01",
                                                                           @"status":@" 进行中"
                                                                           }]];
}

- (void)initTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height - 49 - 64) style:UITableViewStyleGrouped];
    self.mainTableView = tableView;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0){
        return self.dataArray.count;
    } else{
        return self.eventArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        GRDiscoverMiddleCell *cell = [GRDiscoverMiddleCell cellWithTableView:tableView];
        cell.model = self.dataArray[indexPath.row];
        return cell;
    }else{
        GRHotEventsCell *cell = [GRHotEventsCell cellWithTableView:tableView];
        cell.hotEvent = self.eventArray[indexPath.row];
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 64;
    }else{
        return 156;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1){
        return 30;
    }else{
        return .001;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 0.0001;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1){
        GRHotEventHeader *header = [[GRHotEventHeader alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 30)];
        return header;
    } else{
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self shareSDK];
    }else if (indexPath.section == 0 && indexPath.row == 1){
        GRNewsViewController *newsVC = [[GRNewsViewController alloc] init];
        newsVC.title = @"资讯";
        [self.navigationController pushViewController:newsVC animated:YES];
    }
}

///shareSDK
- (void)shareSDK{
//    /1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"banner"]];
//    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容" images:imageArray url:[NSURL URLWithString:@"http://mob.com"] title:@"分享标题" type:SSDKContentTypeAuto];
        //有的平台要客户端分享需要加此方法，例如微博
//        [shareParams SSDKEnableUseClientShare];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
        [ShareSDK showShareActionSheet:nil
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
}

#pragma mark - setter and getter
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)eventArray{
    if (!_eventArray) {
        _eventArray = [NSMutableArray array];
    }
    return _eventArray;
}

@end
