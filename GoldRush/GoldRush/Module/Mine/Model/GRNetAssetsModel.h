//
//  GRNetAssetsModel.h
//  GoldRush
//
//  Created by Jack on 2017/1/20.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRNetAssetsModel : NSObject

///净资产
@property (nonatomic, copy) NSString *netAsset;
///持仓盈亏
@property (nonatomic, copy) NSString *profitLoss;
///建仓成本
@property (nonatomic, copy) NSString *buildCost;
///可用资金
@property (nonatomic, copy) NSString *available;

@end
