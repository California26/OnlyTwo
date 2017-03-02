//
//  NSData+Extension.h
//  travel
//
//  Created by xlx on 16/4/26.
//  Copyright © 2016年 xlx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData(Extension)

/**
 把 json 数据转换成字典

 @return 解析后的数据字典
 */
- (NSDictionary *)obejctWithData;

@end
