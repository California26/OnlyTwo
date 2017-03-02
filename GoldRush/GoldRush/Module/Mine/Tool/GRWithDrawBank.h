//
//  GRWithDrawBank.h
//  GoldRush
//
//  Created by Jack on 2017/2/17.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRWithDrawBank;
@protocol GRWithDrawBankDelegate <NSObject>

@optional
- (void)gr_withDrawBankView:(GRWithDrawBank *)view didSelectedBank:(NSString *)bankName;

@end

@interface GRWithDrawBank : UIPickerView

///
@property (nonatomic, weak) id<GRWithDrawBankDelegate> bankDelegate;


///数据源数组
@property (nonatomic, strong) NSArray *dataArray;

@end
