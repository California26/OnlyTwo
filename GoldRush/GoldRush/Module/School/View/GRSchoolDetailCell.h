//
//  GRSchoolDetailCell.h
//  GoldRush
//
//  Created by Jack on 2017/2/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRSchoolDetailCell : UITableViewCell

@property (nonatomic, copy) NSString *imageName;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
