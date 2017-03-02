//
//  GROutDateThicket.h
//  GoldRush
//
//  Created by Jack on 2017/1/17.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GROutDateThicket : NSObject

///抵金券金额
@property (nonatomic, copy) NSString *money;
///到期时间
@property (nonatomic, copy) NSString *expire;

@end
