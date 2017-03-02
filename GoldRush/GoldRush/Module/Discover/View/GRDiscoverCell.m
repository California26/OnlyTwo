//
//  GRDiscoverCell.m
//  GoldRush
//
//  Created by Jack on 2016/12/27.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRDiscoverCell.h"
#import "GRDiscover.h"

@interface GRDiscoverCell()

@property (weak, nonatomic)  UIImageView *iconImageView;
@property (weak, nonatomic)  UILabel *textLabel;


@end

@implementation GRDiscoverCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //头像
        UIImageView *icon = [[UIImageView alloc] init];
        self.iconImageView = icon;
        [self.contentView addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.contentView.mas_top).offset(15);
            if (iPhone5) {
                make.width.and.height.equalTo(@60);
            }else{
                make.width.and.height.equalTo(@80);
            }
        }];
        
        //文字
        UILabel *label = [[UILabel alloc] init];
        self.textLabel = label;
        if (iPhone5) {
            label.font = [UIFont systemFontOfSize:12];
        }else{
            label.font = [UIFont systemFontOfSize:15];
        }
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(icon.mas_bottom).offset(8);
        }];
    }
    return self;
}

- (void)setModel:(GRDiscover *)model{
    _model = model;
    
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:[UIImage imageNamed:@""]];
    self.iconImageView.image = [UIImage imageNamed:model.iconUrl];
    self.textLabel.text = model.title;
}


- (void)setDicModel:(NSDictionary *)dicModel
{
    _dicModel = dicModel;
    self.iconImageView.image = [UIImage imageNamed:_dicModel[@"image"]];
    self.textLabel.text = _dicModel[@"title"];
}
@end
