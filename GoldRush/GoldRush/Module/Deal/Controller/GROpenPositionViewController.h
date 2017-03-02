//
//  GROpenPositionViewController.h
//  GoldRush
//
//  Created by Jack on 2017/1/4.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ResultActionDelegate <NSObject>

- (void)successResultAction;

@end

@interface GROpenPositionViewController : UIViewController

///买涨/跌
@property (nonatomic,strong) NSString *stringResultTitle;

///当前价格是涨/跌
@property (nonatomic, assign, getter=isRise) BOOL rise;

///当前报价
@property (nonatomic, copy) NSString *currentPrice;
///当前产品名字
@property (nonatomic, copy) NSString *productName;

@property (nonatomic,assign) id<ResultActionDelegate> delegate;

@end
