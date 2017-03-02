//
//  GRADImageCell.h
//  GoldRush
//
//  Created by Jack on 2016/12/23.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface GRADImageCell : UITableViewCell

///图片数组
@property(nonatomic, copy) NSString *imageName;

///图片点击事件
@property (nonatomic, copy) void (^imageClick)(void);


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
