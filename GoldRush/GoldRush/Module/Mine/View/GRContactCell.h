//
//  GRContactCell.h
//  GoldRush
//
//  Created by Jack on 2017/2/20.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRContactCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *dict;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
