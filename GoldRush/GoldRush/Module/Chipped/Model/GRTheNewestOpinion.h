//
//  GRTheNewestOpinion.h
//  GoldRush
//
//  Created by Jack on 2017/1/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRTheNewestOpinion : NSObject

///头像
@property (nonatomic, copy) NSString *iconName;
///名字
@property (nonatomic, copy) NSString *name;
///时间
@property (nonatomic, copy) NSString *time;
///标题
@property (nonatomic, copy) NSString *title;
///内容详情
@property (nonatomic, copy) NSString *desc;
///照片数组
@property (nonatomic, strong) NSArray *picNamesArray;
///是否点赞
@property (nonatomic, assign, getter = isLiked) BOOL liked;

///点赞数
@property (nonatomic, assign) NSInteger likeCount;
///评论数
@property (nonatomic, assign) NSInteger commentCount;

@end
