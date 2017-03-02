//
//  GRGRHotEvents.h
//  GoldRush
//
//  Created by Jack on 2017/1/12.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRHotEvents : NSObject

///图片
@property (nonatomic, copy) NSString *imageUrl;
///活动标题
@property (nonatomic, copy) NSString *title;
///时间
@property (nonatomic, copy) NSString *time;
///活动状态
@property (nonatomic, copy) NSString *status;


@end
