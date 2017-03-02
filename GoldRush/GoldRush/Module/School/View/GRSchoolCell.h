//
//  GRSchoolCell.h
//  GoldRush
//
//  Created by Jack on 2017/2/23.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRSchoolCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *dataDict;

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
