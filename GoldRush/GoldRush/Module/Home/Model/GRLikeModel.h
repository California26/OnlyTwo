//
//  GRLikeModel.h
//  GoldRush
//
//  Created by Jack on 2016/12/29.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRLikeModel : NSObject

///用户名
@property (nonatomic, copy) NSString *userName;
///用户 ID
@property (nonatomic, copy) NSString *userId;
///属性内容
@property (nonatomic, copy) NSAttributedString *attributedContent;

@end
