//
//  GRBankCardCell.h
//  GoldRush
//
//  Created by Jack on 2017/1/20.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRBankCardCell;
@protocol GRBankCardCellDelegate <NSObject>

@optional
- (void)gr_bankCardCell:(GRBankCardCell *)cell selectWhichBank:(UIButton *)btn;

@end

@interface GRBankCardCell : UITableViewCell

@property (nonatomic, weak) id<GRBankCardCellDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
