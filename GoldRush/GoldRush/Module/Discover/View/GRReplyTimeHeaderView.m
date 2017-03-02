//
//  GRReplyTimeHeaderView.m
//  GoldRush
//
//  Created by Jack on 2017/1/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRReplyTimeHeaderView.h"

@interface GRReplyTimeHeaderView ()

@property (nonatomic, weak) UILabel *timeLabel;         ///时间 label

@end

@implementation GRReplyTimeHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        //时间
        UILabel *time = [[UILabel alloc] init];
        [self addSubview:time];
        self.timeLabel = time;
        
        //布局
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self).offset(13);
        }];
        
    }
    return self;
}

- (void)setTime:(NSString *)time{
    _time = time;
    
    self.timeLabel.text = time;
}

@end
