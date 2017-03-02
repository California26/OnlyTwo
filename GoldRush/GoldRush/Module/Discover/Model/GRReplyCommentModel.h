//
//  GRReplyCommentModel.h
//  GoldRush
//
//  Created by Jack on 2017/1/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRReplyCommentModel : NSObject

///头像
@property (nonatomic, copy) NSString *iconName;
///名字
@property (nonatomic, copy) NSString *fromName;
///回复谁
@property (nonatomic, copy) NSString *toName;
///时间
@property (nonatomic, copy) NSString *time;
///内容详情
@property (nonatomic, copy) NSString *desc;


@property (nonatomic, copy) NSString *all;

@end
