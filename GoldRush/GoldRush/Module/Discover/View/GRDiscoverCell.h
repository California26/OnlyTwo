//
//  GRDiscoverCell.h
//  GoldRush
//
//  Created by Jack on 2016/12/27.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GRDiscover;
@interface GRDiscoverCell : UICollectionViewCell
///模型
@property(nonatomic, strong) GRDiscover *model;

@property (nonatomic,strong) NSDictionary *dicModel;
@end
