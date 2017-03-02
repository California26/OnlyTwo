//
//  GRJDRechargeViewController.h
//  GoldRush
//
//  Created by Jack on 2017/2/17.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRJDRechargeViewController : UIViewController

///充值金额
@property (nonatomic, copy) NSString *money;

///传输过来的数据
@property (nonatomic, strong) NSDictionary *dataDict;

@end
