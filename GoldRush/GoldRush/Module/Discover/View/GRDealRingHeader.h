//
//  GRDealRingHeader.h
//  GoldRush
//
//  Created by Jack on 2017/1/13.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRDealRingHeaderModel;
@interface GRDealRingHeader : UIView

///用户模型数据
@property(nonatomic, strong) GRDealRingHeaderModel *model;
///头像点击事件
@property (nonatomic, copy) void(^tapBlock)();

@end
