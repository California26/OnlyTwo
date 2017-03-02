//
//  GRCreateCostBtn.h
//  GoldRush
//
//  Created by Jack on 2017/1/4.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRCreateCostBtn : UIButton

///产品介绍
@property (nonatomic, copy) NSString *product;
///行情
@property (nonatomic, copy) NSString *market;

///是否显示券
@property (nonatomic, assign) BOOL isShowTicket;


@end
