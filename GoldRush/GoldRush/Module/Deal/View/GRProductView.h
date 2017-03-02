//
//  GRProductView.h
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/3.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRProductView : UIView

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *number;
@property (nonatomic)        BOOL isUpOrDown;//yes 红色 no 绿色

@property (nonatomic,assign) BOOL isClose;//yes 休市中 no 没有休市中




@end
