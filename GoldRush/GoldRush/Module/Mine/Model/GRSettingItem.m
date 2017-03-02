//
//  GRSettingItem.m
//  GoldRush
//
//  Created by Jack on 2016/12/27.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRSettingItem.h"

@implementation GRSettingItem
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass{
    GRSettingItem *item = [[GRSettingItem alloc] init];
    item.icon = icon;
    item.title = title;
    item.destVcClass = destVcClass;
    return item;
}

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title{
    GRSettingItem *item = [[GRSettingItem alloc] init];
    item.icon = icon;
    item.title = title;
    return item;
}

@end
