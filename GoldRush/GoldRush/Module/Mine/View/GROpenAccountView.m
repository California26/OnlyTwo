//
//  GROpenAccountView.m
//  GoldRush
//
//  Created by Jack on 2016/12/26.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GROpenAccountView.h"
#import "UIButton+GRButtonLayout.h"

@interface GROpenAccountView ()

///当前交易所
@property (nonatomic, weak) UILabel *typeLabel;
///开户按钮
@property (nonatomic, strong) UIButton *openAccountBtn;
///登陆按钮
@property (nonatomic, strong) UIButton *loginBtn;


@end

@implementation GROpenAccountView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       //设置 UI
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *desc = [[UILabel alloc] init];
    [self addSubview:desc];
    self.typeLabel = desc;
    desc.font = [UIFont boldSystemFontOfSize:15];
    [desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(13);
    }];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39, K_Screen_Width, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    
    UIButton *openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.openAccountBtn = openBtn;
    openBtn.frame = CGRectMake(K_Screen_Width - 70, 0, 65, 40);
    openBtn.titleRect = CGRectMake(0, 0, 55, 40);
    openBtn.imageRect = CGRectMake(55, 15, 6, 10);
    [openBtn setTitle:@"立刻开户" forState:UIControlStateNormal];
    [openBtn setTitleColor:[UIColor colorWithHexString:@"#eb6877"] forState:UIControlStateNormal];
    openBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [openBtn addTarget:self action:@selector(openClick:) forControlEvents:UIControlEventTouchUpInside];
    [openBtn setImage:[UIImage imageNamed:@"Mine_Open_Account"] forState:UIControlStateNormal];
    [self addSubview:self.openAccountBtn];
}

- (void)setShowBtn:(BOOL)showBtn{
    _showBtn = showBtn;

    if (_showBtn) {
        [self.loginBtn removeFromSuperview];
        [self.openAccountBtn removeFromSuperview];
    }else{
        
    }
    
}

- (void)setIsSucceedRegister:(BOOL)isSucceedRegister{
    _isSucceedRegister = isSucceedRegister;
    if (isSucceedRegister) {
        [self.openAccountBtn removeFromSuperview];
        [self addSubview:self.loginBtn];
    }else{
        [self addSubview:self.openAccountBtn];
    }
}

//立即登录
- (void)loginClick:(UIButton *)btn{
    if (self.loginBlock) {
        self.loginBlock(self.type);
    }
}
//开户
- (void)openClick:(UIButton *)btn{
    if (self.openBlock) {
        self.openBlock(self.type);
    }
}
#pragma mark - setter and getter
- (void)setType:(NSString *)type{
    _type = type;
    self.typeLabel.text = type;
}

- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.frame = CGRectMake(K_Screen_Width - 70, 0, 65, 40);
        _loginBtn.titleRect = CGRectMake(0, 0, 55, 40);
        _loginBtn.imageRect = CGRectMake(55, 15, 6, 10);
        [_loginBtn setTitle:@"立刻登陆" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor colorWithHexString:@"#eb6877"] forState:UIControlStateNormal];
        [_loginBtn setImage:[UIImage imageNamed:@"Mine_Open_Account"] forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [_loginBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UIButton *)openAccountBtn{
    if (!_openAccountBtn) {
        _openAccountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _openAccountBtn.frame = CGRectMake(K_Screen_Width - 70, 0, 65, 40);
        _openAccountBtn.titleRect = CGRectMake(0, 0, 55, 40);
        _openAccountBtn.imageRect = CGRectMake(55, 15, 6, 10);
        [_openAccountBtn setTitle:@"立刻开户" forState:UIControlStateNormal];
        [_openAccountBtn setTitleColor:[UIColor colorWithHexString:@"#eb6877"] forState:UIControlStateNormal];
        [_openAccountBtn setImage:[UIImage imageNamed:@"Mine_Open_Account"] forState:UIControlStateNormal];
        _openAccountBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [_openAccountBtn addTarget:self action:@selector(openClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _openAccountBtn;
}

@end
