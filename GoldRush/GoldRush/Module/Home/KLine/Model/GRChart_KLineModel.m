//
//  GRChart_KLineModel.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/13.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRChart_KLineModel.h"

#import "GRChart_KLineGruopModel.h"
@implementation GRChart_KLineModel

- (GRChart_KLineModel *)previousKLineModel
{
    if (!_previousKLineModel) {
        _previousKLineModel = [GRChart_KLineModel new];
    }
    return _previousKLineModel;
}

- (GRChart_KLineGruopModel *)parentGruopModel
{
    if (!_parentGruopModel) {
        _parentGruopModel = [GRChart_KLineGruopModel new];
    }
    return _parentGruopModel;
}

- (void)initWithArray:(NSArray *)arr
{
//    NSAssert(arr.count == 6, @"数组长度不够");
    if (arr.count == 0) {
        return;
    }
    if (self) {
        if (arr.count == 2) {
            _date = arr[1];
            if ([arr[0] isKindOfClass:[NSNumber class]]) {
                _minuteNumber = arr[0];
            }else{
                _minuteNumber = @([arr[0] floatValue]);
            }
        }else{
            if ([arr[0] isKindOfClass:[NSNumber class]]) {
                _open = arr[0];
            }else{
                _open = @([arr[0] floatValue]);
            }
            
            if ([arr[1] isKindOfClass:[NSNumber class]]) {
                _close = arr[1];
            }else{
                _close = @([arr[1] floatValue]);
            }
            
            if ([arr[2] isKindOfClass:[NSNumber class]]) {
                _low = arr[2];
            }else{
                _low = @([arr[2] floatValue]);
            }
            
            if ([arr[3] isKindOfClass:[NSNumber class]]) {
                _hight = arr[3];
            }else{
                _hight = @([arr[3] floatValue]);
            }
            _date = arr[4];
        }
    }
    
}

@end
