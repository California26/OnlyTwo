//
//  GRIntroduceHeaderView.m
//  GoldRush
//
//  Created by Jack on 2017/1/10.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRIntroduceHeaderView.h"

@interface GRIntroduceHeaderView ()

@property (nonatomic, weak) UILabel *titleLabel;       ///标题

@end

@implementation GRIntroduceHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //标题
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        label.font = [UIFont systemFontOfSize:16];
        label.textAlignment = NSTextAlignmentCenter;
        self.titleLabel = label;
        
        //布局
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    
    self.titleLabel.text = title;
}

@end
