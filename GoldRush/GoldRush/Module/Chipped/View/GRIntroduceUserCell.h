//
//  GRIntroduceUserCell.h
//  GoldRush
//
//  Created by Jack on 2017/1/10.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRDocumentary;
@interface GRIntroduceUserCell : UITableViewCell

///数据模型
@property(nonatomic, strong) GRDocumentary *documentModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
