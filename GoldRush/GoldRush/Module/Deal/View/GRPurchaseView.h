//
//  GRPurchaseView.h
//  GoldRush
//
//  Created by Jack on 2017/1/5.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GRPurchaseViewDelegate <NSObject>

@optional
///下单
- (void)resultButtonAction;

@end

@interface GRPurchaseView : UIView


///实付款
@property (nonatomic, copy) NSString *price;
///手续费
@property (nonatomic, copy) NSString *charge;

@property (nonatomic) id <GRPurchaseViewDelegate> delegate;

@property (nonatomic,strong) NSString *stringResultTitle;

@end
