//
//  GRBankViewController.h
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/11.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GRBankViewControllerDelegate <NSObject>

@optional
- (void)gr_notficationRechargeVCShowRechargrOrWithDraw:(NSString *)title;

@end

@interface GRBankViewController : UIViewController

@property (nonatomic, weak) id<GRBankViewControllerDelegate> delegate;

///按钮上的文字
@property (nonatomic,strong) NSString *stringType;
///充值/提现金额
@property (nonatomic,strong) NSString *stringMoney;

@end
