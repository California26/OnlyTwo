//
//  NSData+Extension.m
//  travel
//
//  Created by xlx on 16/4/26.
//  Copyright © 2016年 xlx. All rights reserved.
//

#import "NSData+Extension.h"

@implementation NSData(Extension)

- (NSDictionary *)obejctWithData{
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:&error];
    NSLog(@"解析数据时错误:%@",error);
    return json;
}

@end
