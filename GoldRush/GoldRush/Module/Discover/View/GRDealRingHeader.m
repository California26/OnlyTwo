//
//  GRDealRingHeader.m
//  GoldRush
//
//  Created by Jack on 2017/1/13.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRDealRingHeader.h"
#import "GRDealRingHeaderModel.h"       ///用户数据模型

@interface GRDealRingHeader ()

@property (nonatomic, weak) UIImageView *backgroundImageView;           ///背景图片
@property (nonatomic, weak) UIImageView *iconImageView;                 ///用户头像
@property (nonatomic, weak) UILabel *userPhoneLabel;                    ///用户账号


@end

@implementation GRDealRingHeader

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //设置子控件
        //背景图
        UIImageView *background = [[UIImageView alloc] init];
        [self addSubview:background];
        background.userInteractionEnabled = YES;
        self.backgroundImageView = background;
        
        //头像
        UIImageView *icon = [[UIImageView alloc] init];
        [self addSubview:icon];
        icon.layer.cornerRadius = 20;
        icon.layer.masksToBounds = YES;
        self.iconImageView = icon;
        icon.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeader:)];
        [icon addGestureRecognizer:tap];
        
        //用户账号
        UILabel *phone = [[UILabel alloc] init];
        [self addSubview:phone];
        self.userPhoneLabel = phone;
        phone.textColor = [UIColor whiteColor];
        phone.font = [UIFont systemFontOfSize:15];
        
        //布局
        [background mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-13);
            make.bottom.equalTo(self).offset(-10);
            make.width.height.equalTo(@40);
        }];
        
        [phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(icon.mas_centerY);
            make.right.equalTo(icon.mas_left).offset(-10);
        }];
        
    }
    return self;
}

#pragma event response
- (void)tapHeader:(UITapGestureRecognizer *)tap{
    if (self.tapBlock) {
        self.tapBlock();
    }
}

#pragma mark - setter and getter
- (void)setModel:(GRDealRingHeaderModel *)model{
    _model = model;
    
    self.backgroundImageView.image = [UIImage imageNamed:model.backgroundUrl];
    self.userPhoneLabel.text = model.phone;
    self.iconImageView.image = [UIImage imageNamed:model.iconUrl];
}

@end
