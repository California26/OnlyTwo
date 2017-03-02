//
//  GRRechargePayTypeCell.h
//  GoldRush
//
//  Created by Jack on 2017/2/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRRechargePayTypeCell;
@protocol GRRechargePayTypeCellDelegate <NSObject>

@optional
- (void)gr_rechargePayTypeCell:(GRRechargePayTypeCell *)cell selectWhichPayType:(UIButton *)btn;
- (void)gr_textFieldDidEndEditing:(UITextField *)textField;

@end

@interface GRRechargePayTypeCell : UITableViewCell

@property (nonatomic, weak) id<GRRechargePayTypeCellDelegate> delegate;

///是否显示输入框
@property (nonatomic, assign,getter=isShowField) BOOL showField;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

///支付方式
@property (nonatomic, strong) NSDictionary *payTypeDict;

@end
