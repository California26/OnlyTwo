//
//  GRAddBankViewController.h
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/11.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRAddBankViewController : UIViewController

///将银行卡信息上传到上一页
@property (nonatomic, copy) void(^passBankCardBlock)(NSString *bankType,NSString *bankCardNum);

///按钮上的文字
@property (nonatomic, copy) NSString *btnTitle;

///充值金额
@property (nonatomic, copy) NSString *money;

@end
