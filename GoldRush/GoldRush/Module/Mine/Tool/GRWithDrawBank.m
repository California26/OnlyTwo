//
//  GRWithDrawBank.m
//  GoldRush
//
//  Created by Jack on 2017/2/17.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRWithDrawBank.h"

@interface GRWithDrawBank ()<UIPickerViewDelegate,UIPickerViewDataSource>

@end

@implementation GRWithDrawBank

- (instancetype)init{
    self = [super init];
    if (self){
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}


#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView{
    return 1;
}

//该方法返回值决定该控件指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.dataArray[row];
}

//选择指定列、指定列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (self.bankDelegate && [self.bankDelegate respondsToSelector:@selector(gr_withDrawBankView:didSelectedBank:)]) {
        [self.bankDelegate gr_withDrawBankView:self didSelectedBank:self.dataArray[row]];
    }
}

//指定列的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    // 宽度
    return 300;;
}



@end
