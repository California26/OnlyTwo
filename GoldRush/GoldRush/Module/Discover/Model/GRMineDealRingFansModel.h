//
//  GRMineDealRingModel.h
//  GoldRush
//
//  Created by Jack on 2017/1/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRMineDealRingFansModel : NSObject

///头像图片
@property (nonatomic, copy) NSString *iconUrl;
///名字
@property (nonatomic, copy) NSString *name;
///是否关注
@property (nonatomic, assign, getter=isFellow) BOOL fellow;

@end
