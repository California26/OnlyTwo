//
//  GRSettingItem.h
//  GoldRush
//
//  Created by Jack on 2016/12/27.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRSettingItem : NSObject

@property (copy, nonatomic) NSString *icon;             ///图标
@property (copy, nonatomic) NSString *title;            ///标题
@property (copy, nonatomic) NSString *subTitle;         ///子标题
@property (assign, nonatomic) Class destVcClass;        ///点击这行cell需要跳转的控制器

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;

@end
