//
//  GRHeaderCell.h
//  GoldRush
//
//  Created by Jack on 2016/12/26.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GRHeaderCellDelegate <NSObject>

@optional
- (void)gr_headerCellClickHeader;

@end

@interface GRHeaderCell : UITableViewCell

///
@property (nonatomic, weak) id<GRHeaderCellDelegate> delegate;

///选中的头像图片
@property (nonatomic, weak) UIImage *selectedImage;

///是否登陆成功
@property (nonatomic, assign) BOOL isSucceed;

///登陆按钮点击
@property (nonatomic, copy) void(^loginBlock)();

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
