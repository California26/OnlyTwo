//
//  GRProProductTableViewCell.h
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/18.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRProProductTableViewCell : UITableViewCell

@property (nonatomic,strong) NSString *productName;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
