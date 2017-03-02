//
//  GRUserInfoModel.h
//  GoldRush
//
//  Created by Jack on 2017/1/19.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRUserInfoModel : NSObject

///用户 ID
@property (nonatomic, assign) NSInteger id;
/// 注册时间
@property (nonatomic, copy) NSString *createdTime;
///性别
@property (nonatomic, assign) NSInteger sex;
///会员单位 ID
@property (nonatomic, assign) NSInteger memberUnitsId;
/// 用户类型
@property (nonatomic, assign) NSInteger userType;
///手机号
@property (nonatomic, assign) NSInteger mobile;
///用户 ID
@property (nonatomic, assign) NSInteger userId;
/// 用户状态
@property (nonatomic, assign) NSInteger flag;
///令牌
@property (nonatomic, copy) NSString *token;
///
@property (nonatomic, assign) NSInteger orgId;
///微信 ID
@property (nonatomic, copy) NSString *wid;

@property (nonatomic, copy) NSString *pwd;

@end
