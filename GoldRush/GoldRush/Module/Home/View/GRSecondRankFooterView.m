//
//  GRSecondRankFooterView.m
//  GoldRush
//
//  Created by Jack on 2016/12/23.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRSecondRankFooterView.h"
/** 自定义 cell */
#import "GRRankCollectionViewCell.h"
/** 模型 */
#import "GRProfit.h"

#import "GRProfitRankViewController.h"
#import "GRNavigationController.h"

#define itemH 80
#define itemW 100
static CGFloat const margin = 1;
static NSString * const cellID = @"rank";
@interface GRSecondRankFooterView ()<UICollectionViewDelegate,UICollectionViewDataSource>

///主mainCollectionView
@property(nonatomic, weak) UICollectionView *mainCollectionView;
///数据源数组
@property(nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation GRSecondRankFooterView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加子控件
        [self setupChildView];
        //请求数据
        [self requestData];
        
    }
    return self;
}

- (void)requestData{
    GRProfit *model = [GRProfit mj_objectWithKeyValues:@{@"nickName":@"全民1",
                                                         @"url" : @"New_hand",
                                                         @"profit" : @"123456元",
                                                         @"rank" : @"1"}];
    for (int i = 0; i < 10; i ++) {
        [self.dataArray addObject:model];
    }
    [self.mainCollectionView reloadData];
}

- (void)setupChildView{
    // 创建布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
    self.mainCollectionView = collectionView;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.bounces = NO;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    
    // 设置cell尺寸
    layout.itemSize = CGSizeMake(itemW, itemH);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    [self addSubview:collectionView];
    [collectionView registerNib:[UINib nibWithNibName:@"GRRankCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellID];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GRRankCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GRLog(@"第%zd个 item 被点击",indexPath.row);
    GRProfitRankViewController *rank = [[GRProfitRankViewController alloc] init];
    [self.navigationController pushViewController:rank animated:YES];
}

#pragma mark - setter and getter
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
