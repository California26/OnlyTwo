//
//  GRAnalystCell.m
//  GoldRush
//
//  Created by Jack on 2016/12/28.
//  Copyright © 2016年 Jack. All rights reserved.
//

#define itemH 130
#define itemW 100
static NSString * const cellID = @"analystCell";

#import "GRAnalystCell.h"
#import "GRAnalystCollectionViewCell.h"

@interface GRAnalystCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

///主mainCollectionView
@property(nonatomic, weak) UICollectionView *mainCollectionView;
///数据源数组
@property(nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation GRAnalystCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置子控件
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView{
    
    // 创建布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 150) collectionViewLayout:layout];
    self.mainCollectionView = collectionView;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.bounces = NO;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = GRColor(239, 239, 240);
    
    // 设置cell尺寸
    layout.itemSize = CGSizeMake(itemW, itemH);
    layout.minimumLineSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(7, 20, 0, 20);
    [self.contentView addSubview:collectionView];
    [collectionView registerNib:[UINib nibWithNibName:@"GRAnalystCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellID];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GRAnalystCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
//    cell.model = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - setter and getter
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"analystCell";
    GRAnalystCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRAnalystCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
