//
//  GRRankCollectionViewCell.h
//  GoldRush
//
//  Created by Jack on 2016/12/23.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRProfit;
@interface GRRankCollectionViewCell : UICollectionViewCell
///模型数据
@property(nonatomic, strong) GRProfit *model;

@end
