//
//  GRMessageCenterModel.h
//  GoldRush
//
//  Created by Jack on 2017/1/17.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRMessageCenterModel : NSObject

///信息主体
@property (nonatomic, copy) NSString *message;
///时间
@property (nonatomic, copy) NSString *time;
///是否展开
@property (nonatomic, assign) BOOL isUnFold;
///行高
@property (nonatomic, assign) CGFloat cellHeight;

@end
