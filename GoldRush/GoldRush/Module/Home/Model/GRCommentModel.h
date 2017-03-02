//
//  GRCommentModel.h
//  GoldRush
//
//  Created by Jack on 2016/12/29.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRCommentModel : NSObject

///评论内容
@property (nonatomic, copy) NSString *commentString;
///第一个用户名
@property (nonatomic, copy) NSString *firstUserName;
///第一个用户 ID
@property (nonatomic, copy) NSString *firstUserId;
///第二个用户名
@property (nonatomic, copy) NSString *secondUserName;
///第二个用户 ID
@property (nonatomic, copy) NSString *secondUserId;
///属性内容
@property (nonatomic, copy) NSAttributedString *attributedContent;

@end
