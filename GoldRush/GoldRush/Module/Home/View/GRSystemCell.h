//
//  GRSystemCell.h
//  GoldRush
//
//  Created by Jack on 2016/12/29.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRSystemCell : UITableViewCell

///文字数组
@property(nonatomic, copy) NSString *text;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
