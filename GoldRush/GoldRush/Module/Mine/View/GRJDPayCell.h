//
//  GRJDPayCell.h
//  GoldRush
//
//  Created by Jack on 2017/2/17.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRJDPayCell;
@protocol GRJDPayCellDlegate <NSObject>

@optional
- (void)gr_JDPayCell:(GRJDPayCell *)cell didEndEditing:(UITextField *)field;
- (void)gr_JDPayCell:(GRJDPayCell *)cell shouldBeginEditing:(UITextField *)field;

@end

@interface GRJDPayCell : UITableViewCell

///
@property (nonatomic, weak) id<GRJDPayCellDlegate> delegate;
///输入框标题
@property (nonatomic, copy) NSString *title;
///placeholder
@property (nonatomic, copy) NSString *placeholder;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
