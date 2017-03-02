//
//  GRJudgeBnakType.m
//  GoldRush
//
//  Created by Jack on 2017/2/4.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRJudgeBnakType.h"

@implementation GRJudgeBnakType

+ (NSString *)returnBankName:(NSString *)idCard{
    
    if(idCard == nil || idCard.length < 16 || idCard.length > 24){
        return @"卡号不合法";
    }
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"BankType" ofType:@"plist"];
    NSDictionary* resultDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSArray *bankBin = resultDic.allKeys;
    
    //6位Bin号
    NSString* cardbin_6 = [idCard substringWithRange:NSMakeRange(0, 7)];
    //8位Bin号
    NSString* cardbin_8 = [idCard substringWithRange:NSMakeRange(0, 9)];
    
    NSString *strBin6 = [cardbin_6 stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *strBin8 = [cardbin_8 stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([bankBin containsObject:strBin6]) {
        return [resultDic objectForKey:strBin6];
    }else if ([bankBin containsObject:strBin8]){
        return [resultDic objectForKey:strBin8];
    }else{
        return @"没有当前银行卡信息";
    }
    return @"";
    
}

@end
