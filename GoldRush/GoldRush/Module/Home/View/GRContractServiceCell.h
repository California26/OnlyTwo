//
//  GRContractServiceCell.h
//  GoldRush
//
//  Created by Jack on 2017/3/1.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRContractServiceCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *dataDict;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
