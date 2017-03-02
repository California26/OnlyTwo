//
//  GRHotEventHeader.m
//  GoldRush
//
//  Created by Jack on 2017/1/12.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRHotEventHeader.h"

@implementation GRHotEventHeader

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //标题
        UILabel *title = [[UILabel alloc] init];
        [self addSubview:title];
        title.textColor = [UIColor colorWithHexString:@"#333333"];
        title.font = [UIFont systemFontOfSize:15];
        title.text = @"热门活动";
        
        //线
        UIView *line = [[UIView alloc] init];
        [self addSubview:line];
        line.backgroundColor = [UIColor lightGrayColor];
        
        //布局
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self).offset(13);
            make.top.bottom.equalTo(self);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self);
            make.height.equalTo(@1);
        }];
        
    }
    return self;
}


@end
