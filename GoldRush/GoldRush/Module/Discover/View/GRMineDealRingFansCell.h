//
//  GRMineDealRingFansCell.h
//  GoldRush
//
//  Created by Jack on 2017/1/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRMineDealRingFansModel;
@interface GRMineDealRingFansCell : UITableViewCell

///粉丝模型数据
@property (nonatomic, strong) GRMineDealRingFansModel *fansModel;

///关注按钮点击
@property (nonatomic, copy) void(^fellowBlock)();

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
