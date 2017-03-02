//
//  GRProductClickView.h
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/3.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRProductClickView : UIView

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *number;
@property (nonatomic,assign) BOOL isUpOrDown;//yes 红色 no 绿色
@property (nonatomic,strong) NSString *stringLeft;
@property (nonatomic,strong) NSString *stringRight;
@property (nonatomic,assign) BOOL isClose;


@end
