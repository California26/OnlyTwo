//
//  GRJJGetCodeView.m
//  GoldRush
//
//  Created by Jack on 2017/2/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRJJGetCodeView.h"


@interface GRJJGetCodeView ()<UITextFieldDelegate>

@property (nonatomic, weak) UIImageView *imageView;
///
@property (nonatomic, weak) UIButton *button;

@end

@implementation GRJJGetCodeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self creatSubViews];
        
    }
    return self;
}

- (void)creatSubViews{
    ///背景图片
    UIImageView *background = [[UIImageView alloc] init];
    background.image = [UIImage imageNamed:@"HPME_Exchange"];
    [self addSubview:background];
    
    UILabel *tip = [[UILabel alloc] init];
    tip.text = @"手机号将与交易所绑定以进行交易";
    tip.textColor = [UIColor colorWithHexString:@"#333333"];
    tip.font = [UIFont systemFontOfSize:15];
    [self addSubview:tip];
    
    ///手机号
    UITextField *phone = [[UITextField alloc] init];
    phone.borderStyle = UITextBorderStyleRoundedRect;
    phone.text = [GRUserDefault getUserPhone];
    phone.enabled = NO;
    [self addSubview:phone];
    
    //验证码输入框
    UILabel *code = [[UILabel alloc] init];
    code.textColor = [UIColor colorWithHexString:@"#333333"];
    code.font = [UIFont systemFontOfSize:16];
    [self addSubview:code];
    code.text = @"验证码";
    
    UITextField *result = [[UITextField alloc] init];
    NSMutableAttributedString *attrString;
    if (iPhone5) {
        attrString = [[NSMutableAttributedString alloc]initWithString:@"输入计算结果" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    }else{
        attrString = [[NSMutableAttributedString alloc]initWithString:@"输入计算结果" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    }

    result.attributedPlaceholder = attrString;
    result.textColor = [UIColor colorWithHexString:@"#cccccc"];
    result.keyboardType = UIKeyboardTypeNumberPad;
    result.clearButtonMode = UITextFieldViewModeWhileEditing;
    result.borderStyle = UITextBorderStyleRoundedRect;
    result.delegate = self;
    result.returnKeyType = UIReturnKeyDone;
    [self addSubview:result];
    
    //验证码
    UIImageView *codeImage = [[UIImageView alloc] init];
    [self addSubview:codeImage];
    self.imageView = codeImage;
    codeImage.contentMode = UIViewContentModeScaleAspectFit;
    codeImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",DomainName,@"?r=jlmmex/code/image"]]]];
    
    //换一个按钮
    UIButton *change = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:change];
    [change setTitle:@"换一个" forState:UIControlStateNormal];
    if (iPhone5) {
        change.titleLabel.font = [UIFont systemFontOfSize:15];
    }else{
        change.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    [change setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [change addTarget:self action:@selector(changeClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *get = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button = get;
    [get setTitle:@"获取短信验证码" forState:UIControlStateNormal];
    get.backgroundColor = mainColor;
    [get setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    get.titleLabel.font = [UIFont systemFontOfSize:18];
    [get addTarget:self action:@selector(regButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    get.layer.cornerRadius = 5.0f;
    get.layer.masksToBounds = YES;
    [self addSubview:get];
    
    //布局
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(K_Screen_Height/3);
    }];
    
    [tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(13);
        make.top.equalTo(background.mas_bottom).offset(5);
    }];
    
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(13);
        make.top.equalTo(tip.mas_bottom).offset(10);
        make.width.equalTo(@(K_Screen_Width - 26));
        make.height.equalTo(@40);
    }];

    [code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(13);
        make.top.equalTo(phone.mas_bottom).offset(20);
    }];
    
    [result mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(code.mas_right).offset(5);
        make.top.equalTo(phone.mas_bottom).offset(10);
        if (iPhone5) {
            make.width.equalTo(@90);
        }else{
            make.width.equalTo(@150);
        }
        make.height.equalTo(@40);
    }];
    
    [codeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(code.mas_centerY);
        make.left.equalTo(result.mas_right).offset(5);
        make.width.equalTo(@90);
        make.height.equalTo(@40);
    }];
    
    [change mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(code.mas_centerY);
        make.left.equalTo(codeImage.mas_right).offset(5);
    }];
    
    [get mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(change.mas_bottom).offset(25);
        make.left.equalTo(self).offset(13);
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@44);
        make.width.equalTo(@(K_Screen_Width - 26));
    }];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(JJ_getCode:withTextField:)]) {
        [self.delegate JJ_getCode:self withTextField:textField];
    }
}

- (void)setButtonTitle:(NSString *)buttonTitle{
    _buttonTitle = buttonTitle;
    
    [self.button setTitle:buttonTitle forState:UIControlStateNormal];
}

///按钮点击
- (void)regButtonAction:(UIButton *)sender{
    [self endEditing:YES];
    if ([self.delegate respondsToSelector:@selector(JJ_getCodeClick:withGetCodeBtn:)]) {
        [self.delegate JJ_getCodeClick:self withGetCodeBtn:sender];
    }
}

- (void)changeClick:(UIButton *)btn{
    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",DomainName,@"?r=jlmmex/code/image"]]]];
}


@end
