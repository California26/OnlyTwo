//
//  GRHeaderCell.m
//  GoldRush
//
//  Created by Jack on 2016/12/26.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRHeaderCell.h"

#import "GRLogInViewController.h"

@interface GRHeaderCell ()

@property (strong, nonatomic) UILabel *phoneLabel;
@property (strong, nonatomic) UIButton *loginRegistBtn;

///
@property (nonatomic, weak) UIImageView *iconView;

@end

@implementation GRHeaderCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        //背景图片
        UIImageView *background = [[UIImageView alloc] init];
        [self.contentView addSubview:background];
        [background mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.contentView);
        }];
        background.image = [UIImage imageNamed:@"Mine_Header_Image"];
        background.userInteractionEnabled = YES;
        
        UIImageView *icon = [[UIImageView alloc] init];
        [self.contentView addSubview:icon];
        self.iconView = icon;
        icon.userInteractionEnabled = YES;
        icon.layer.cornerRadius = 30;
        icon.layer.masksToBounds = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [icon addGestureRecognizer:tap];

        icon.image = [UIImage imageNamed:@"Header_Icon_Default"];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(85);
            make.width.height.mas_equalTo(60);
        }];
        
        [self.contentView addSubview:self.loginRegistBtn];
        [self.contentView addSubview:self.phoneLabel];    
    }
    return self;
}

- (void)loginClick:(id)sender {
    if (self.loginBlock) {
        self.loginBlock();
    }
}

- (void)tapClick:(UIGestureRecognizer *)gesture{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gr_headerCellClickHeader)]) {
        [self.delegate gr_headerCellClickHeader];
    }
}

- (void)setIsSucceed:(BOOL)isSucceed{
    _isSucceed = isSucceed;
    if (isSucceed) {
        [self.loginRegistBtn removeFromSuperview];
        [self.contentView addSubview:self.phoneLabel];
        self.phoneLabel.text = [GRUserDefault getUserPhone];
        [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconView.mas_bottom).offset(20);
            make.centerX.equalTo(self.contentView);
        }];
    }else{
        [self.phoneLabel removeFromSuperview];
        [self.contentView addSubview:self.loginRegistBtn];
        [self.loginRegistBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconView.mas_bottom).offset(10);
            make.centerX.equalTo(self.contentView);
            make.width.equalTo(@100);
            make.height.equalTo(@40);
        }];
    }
}

#pragma mark - setter and getter
- (void)setSelectedImage:(UIImage *)selectedImage{
    _selectedImage = selectedImage;
    if (selectedImage) {
        self.iconView.image = selectedImage;
    }
}

- (UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.textColor = [UIColor whiteColor];
        _phoneLabel.font = [UIFont systemFontOfSize:18];
    }
    return _phoneLabel;
}

- (UIButton *)loginRegistBtn{
    if (!_loginRegistBtn) {
        _loginRegistBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginRegistBtn setTitle:@"登陆/注册" forState:UIControlStateNormal];
        [_loginRegistBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginRegistBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [_loginRegistBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginRegistBtn;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"headerCell";
    GRHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRHeaderCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
