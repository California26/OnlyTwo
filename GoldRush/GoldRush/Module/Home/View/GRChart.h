//
//  GRChart.h
//  GoldRush
//
//  Created by 徐孟林 on 2016/12/21.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRChart : UIView

@property (nonatomic) BOOL isPinGesture; //yes 添加手势 no 不添加手势

@property (nonatomic) BOOL timeQuantum; //时间段 no 分时 yes 其他时间段

@property (nonatomic,strong) NSDictionary *dicSource;
@property (nonatomic,strong) NSDictionary *dicSource60;


@end
