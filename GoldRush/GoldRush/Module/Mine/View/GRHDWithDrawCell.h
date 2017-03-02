//
//  GRHDWithDrawCell.h
//  GoldRush
//
//  Created by Jack on 2017/2/18.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRHDWithDrawCell;
@protocol GRHDWithDrawCellDlegate <NSObject>

@optional
- (void)gr_HDWithDrawCell:(GRHDWithDrawCell *)cell didEndEditing:(UITextField *)field;
- (void)gr_HDWithDrawCell:(GRHDWithDrawCell *)cell shouldBeginEditing:(UITextField *)field;

@end

@interface GRHDWithDrawCell : UITableViewCell

///
@property (nonatomic, weak) id<GRHDWithDrawCellDlegate> delegate;
///输入框标题
@property (nonatomic, copy) NSString *title;
///placeholder
@property (nonatomic, copy) NSString *placeholder;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
