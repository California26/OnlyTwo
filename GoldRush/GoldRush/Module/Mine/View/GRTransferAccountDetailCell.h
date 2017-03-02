//
//  GRTransferAccountDetailCell.h
//  GoldRush
//
//  Created by Jack on 2017/1/11.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRTransferAccountJJDetail,GRTransferAccountHDDetail;
@interface GRTransferAccountDetailCell : UITableViewCell

@property(nonatomic, strong) GRTransferAccountJJDetail *detailModelJJ;

@property (nonatomic, strong) GRTransferAccountHDDetail *detailModelHD;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
