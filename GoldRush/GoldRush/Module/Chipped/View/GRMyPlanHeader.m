//
//  GRMyPlanHeader.m
//  GoldRush
//
//  Created by Jack on 2017/1/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRMyPlanHeader.h"

@interface GRMyPlanHeader ()

@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation GRMyPlanHeader

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        //标题
        UILabel *title = [[UILabel alloc] init];
        self.titleLabel = title;
        [self addSubview:title];
        title.textColor = [UIColor colorWithHexString:@"#333333"];
        title.font = [UIFont systemFontOfSize:12];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(13);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        //line
        UIView *line = [[UIView alloc] init];
        [self addSubview:line];
        line.backgroundColor = [UIColor lightGrayColor];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.equalTo(@1);
            make.bottom.equalTo(self);
        }];
        
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = self.title;
}

@end
