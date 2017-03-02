//
//  GRMineUserWithdrawView.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/11.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRMineUserWithdrawView.h"

@interface GRMineUserWithdrawView ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *textField;

@end

@implementation GRMineUserWithdrawView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = defaultBackGroundColor;
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    UILabel *label = [[UILabel alloc] init];
    if (iPhone5) {
        label.frame = CGRectMake(15, 0, K_Screen_Width-15*2, 60);
    }else{
        label.frame = CGRectMake(15, 0, K_Screen_Width-15*2, 40);
    }
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor colorWithHexString:@"#666666"];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"提现时间为周一07:00～周六04:00 提现2500以内将收取1%的手续费，提现不足200元收取2元手续费，手续费25元封顶";
    [self addSubview:label];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), K_Screen_Width, self.frame.size.height-40)];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 80, 30)];
    label1.text = @"提现金额";
    label1.font = [UIFont systemFontOfSize:16];
    label1.textColor = [UIColor colorWithHexString:@"#333333"];
    [view addSubview:label1];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), CGRectGetMinY(label1.frame), K_Screen_Width-15*2-10-20-CGRectGetWidth(label1.frame), CGRectGetHeight(label1.frame))];
    _textField.placeholder = @" 当前可提现金额";
    _textField.font = [UIFont systemFontOfSize:14];
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    _textField.textColor = [UIColor colorWithHexString:@"#999999"];
    _textField.layer.borderColor = defaultBackGroundColor.CGColor;
    _textField.layer.borderWidth = 1.0f;
    _textField.delegate = self;
    [view addSubview:self.textField];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"确认提现" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    button.backgroundColor = mainColor;
    button.frame = CGRectMake(15, 25+CGRectGetMaxY(_textField.frame), K_Screen_Width-15*2, 44);
    button.layer.cornerRadius = 5.0f;
    button.layer.masksToBounds = YES;
     [button addTarget:self action:@selector(buttonSure:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(K_Screen_Width/2-100, CGRectGetMaxY(button.frame)+60,260, 20)];
    label2.textColor = [UIColor colorWithHexString:@"#666666"];
    label2.text = @"更换银行卡后充值／提现账号后全部更换";
    label2.font = [UIFont systemFontOfSize:13];
    [view addSubview:label2];
    UILabel *labelLG = [[UILabel alloc] initWithFrame:CGRectMake(K_Screen_Width/2-100-10-36, CGRectGetMinY(label2.frame)-7, 36, 36)];
    labelLG.layer.borderColor = defaultBackGroundColor.CGColor;
    labelLG.layer.borderWidth = 0.5;
    labelLG.font = [UIFont systemFontOfSize:15];
    labelLG.text = @"LG";
    labelLG.textAlignment = NSTextAlignmentCenter;
    labelLG.textColor = [UIColor colorWithHexString:@"#666666"];
    labelLG.layer.cornerRadius = labelLG.frame.size.width/2;
    labelLG.layer.masksToBounds = YES;
    [view addSubview:labelLG];
    
}

- (void)buttonSure:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(sureButtonAction:)]) {
        [self.delegate sureButtonAction:sender];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(surewithDrawMoneyAction:)]) {
        [self.delegate surewithDrawMoneyAction:textField];
    }
    return YES;
}

@end
