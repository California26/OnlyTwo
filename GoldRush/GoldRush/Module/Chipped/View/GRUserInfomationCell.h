//
//  GRUserInfomationCell.h
//  GoldRush
//
//  Created by Jack on 2017/1/7.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>


@class GRDocumentary;
@interface GRUserInfomationCell : UITableViewCell

@property(nonatomic, strong) GRDocumentary *documentModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
