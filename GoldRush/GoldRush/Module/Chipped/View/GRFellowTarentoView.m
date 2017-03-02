//
//  GRFellowTarentoView.m
//  GoldRush
//
//  Created by Jack on 2017/1/9.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRFellowTarentoView.h"

@implementation GRFellowTarentoView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = GRColor(240, 240, 240);
        //标题
        UILabel *title = [[UILabel alloc] init];
        [self addSubview:title];
        title.text = @"我关注的达人";
        title.textColor = [UIColor colorWithHexString:@"#333333"];
        title.textAlignment = NSTextAlignmentLeft;
        
        //建仓人数
        UILabel *number = [[UILabel alloc] init];
        [self addSubview:number];
        number.text = @"1人建仓";
        number.textAlignment = NSTextAlignmentRight;
        number.textColor = [UIColor colorWithHexString:@"#666666"];
        number.font = [UIFont systemFontOfSize:15];
        
        //布局
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(13);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        [number mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-13);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        
    }
    return self;
}

@end
