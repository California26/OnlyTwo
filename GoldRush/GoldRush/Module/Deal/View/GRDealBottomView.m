//
//  GRDealBottomView.m
//  GoldRush
//
//  Created by Jack on 2017/1/5.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRDealBottomView.h"

@implementation GRDealBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //设置子控件
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.backgroundColor = [UIColor whiteColor];
    //注意事项
    UILabel *attention = [[UILabel alloc] init];
    [self addSubview:attention];
    attention.text = @"注意事项";
    attention.textColor = [UIColor colorWithHexString:@"#333333"];
    attention.font = [UIFont systemFontOfSize:13];
    [attention mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(19);
    }];
    
    //线
    UIView *line = [[UIView alloc] init];
    [self addSubview:line];
    line.backgroundColor = [UIColor lightGrayColor];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(13);
        make.right.equalTo(self).offset(-13);
        make.height.equalTo(@1);
        make.top.equalTo(attention.mas_bottom).offset(10);
    }];
    
}

- (void)setAttentionArray:(NSArray<NSString *> *)attentionArray{
    _attentionArray = attentionArray;
    //提示
    for (int i = 0; i < attentionArray.count; i ++) {
        NSString *text = attentionArray[i];
        CGFloat height = [self heightWithText:text];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(28, 48 + (10 + height) * i, K_Screen_Width - 56, height)];
        label.textColor = [UIColor colorWithHexString:@"#666666"];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:12];
        label.text = self.attentionArray[i];
        [self addSubview:label];
    }
}

- (CGFloat)heightWithText:(NSString *)text{
    return [text boundingRectWithSize:CGSizeMake(K_Screen_Width - 56, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil].size.height;
}

@end
