//
//  GRAlterCardAlarm.m
//  GoldRush
//
//  Created by 徐孟林 on 2016/12/30.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRAlterCardAlarm.h"

@interface GRAlterCardAlarm ()<UITextFieldDelegate>

@property (nonatomic,strong) UILabel *labelTitle;
@property (nonatomic,strong) UILabel *label1;
@property (nonatomic,strong) UILabel *labelPrice;
@property (nonatomic,strong) UILabel *label2;
@property (nonatomic,strong) UITextField *textFieldLast;
@property (nonatomic,strong) UILabel *label3;
@property (nonatomic,strong) UIButton *buttonCancel;
@property (nonatomic,strong) UIButton *buttonSave;
@property (nonatomic,strong) UILabel *label4;


@property (nonatomic,strong) NSString *stringChange;

@end

@implementation GRAlterCardAlarm


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.labelTitle];
        [self addSubview:self.labelPrice];
        [self addSubview:self.label1];
        [self addSubview:self.textFieldLast];
        [self addSubview:self.label2];
        [self addSubview:self.label3];
        [self addSubview:self.buttonCancel];
        [self addSubview:self.buttonSave];
        [self addSubview:self.label4];
    }
    return self;
}

- (UILabel *)labelTitle
{
    if (!_labelTitle) {
        _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
        _labelTitle.backgroundColor = [UIColor colorWithHexString:@"#00a0e9"];
        _labelTitle.font = [UIFont systemFontOfSize:18];
    }
    return _labelTitle;
}

- (UILabel *)labelPrice
{
    if (!_labelPrice) {
        _labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2-32.5, CGRectGetMaxY(_labelTitle.frame)+15, 70, 23)];
//        _labelPrice.textColor = [UIColor colorWithHexString:@"#09cb67"];
        _labelPrice.font = [UIFont systemFontOfSize:15];
    }
    return _labelPrice;
}

- (UILabel *)label1
{
    if (!_label1) {
        _label1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_labelPrice.frame)-95, CGRectGetMinY(_labelPrice.frame), 95, 23)];
        _label1.textColor = [UIColor colorWithHexString:@"#666666"];
        _label1.text = @"最新价：";
        _label1.textAlignment = NSTextAlignmentRight;
        _label1.font = _labelPrice.font;
    }
    return _label1;
}

- (UITextField *)textFieldLast
{
    if (!_textFieldLast) {
        _textFieldLast = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(_labelPrice.frame), CGRectGetMaxY(_labelPrice.frame)+10, CGRectGetWidth(_labelPrice.frame), CGRectGetHeight(_labelPrice.frame))];
        _textFieldLast.font = _labelPrice.font;
        _textFieldLast.textColor = [UIColor colorWithHexString:@"#f1496c"];
        _textFieldLast.layer.borderColor = [UIColor colorWithHexString:@"#29afed"].CGColor;
        _textFieldLast.layer.borderWidth = 1.0f;
        _textFieldLast.delegate = self;
        _textFieldLast.returnKeyType = UIReturnKeyDone;
    }
    return _textFieldLast;
}

- (UILabel *)label2
{
    if (!_label2) {
        _label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_label1.frame)-3, CGRectGetMinY(_textFieldLast.frame), CGRectGetWidth(_label1.frame), CGRectGetHeight(_label1.frame))];
        _label2.text = @"价格到  ";
        _label2.textAlignment = NSTextAlignmentRight;
        _label2.font = _label1.font;
        _label2.textColor = _label1.textColor;
    }
    return _label2;
}

- (UILabel *)label3
{
    if (!_label3) {
        _label3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_textFieldLast.frame)+5, CGRectGetMinY(_textFieldLast.frame), 60, CGRectGetHeight(_label2.frame))];
        _label3.textColor = _label2.textColor;
        _label3.font = _label2.font;
        _label3.text = @"提醒我";
        _label3.textAlignment = NSTextAlignmentLeft;
    }
    return _label3;
}

- (UILabel *)label4
{
    if (!_label4) {
        _label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 15)];
        _label4.textAlignment = NSTextAlignmentCenter;
        _label4.textColor = [UIColor colorWithHexString:@"#999999"];
        _label4.text = @"以消息通知，个别情况下可能延迟";
        _label4.font = [UIFont systemFontOfSize:12];
    }
    return _label4;
}

- (UIButton *)buttonCancel
{
    if (!_buttonCancel) {
        _buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonCancel.frame = CGRectMake(K_Screen_Width/2-20-100, self.frame.size.height-20-15-30,100, 30);
        [_buttonCancel setTitle:@"取消提醒" forState:UIControlStateNormal];
        [_buttonCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _buttonCancel.titleLabel.font = _label1.font;
        _buttonCancel.backgroundColor = [UIColor colorWithHexString:@"#b8b8b8"];
        [_buttonCancel addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _buttonCancel.tag = 100;
    }
    return _buttonCancel;
}

- (UIButton *)buttonSave
{
    if (!_buttonSave) {
        _buttonSave = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonSave.frame = CGRectMake(K_Screen_Width/2+20, CGRectGetMinY(_buttonCancel.frame), CGRectGetWidth(_buttonCancel.frame), CGRectGetHeight(_buttonCancel.frame));
        [_buttonSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buttonSave setTitle:@"保存设置" forState:UIControlStateNormal];
        _buttonSave.titleLabel.font = _buttonCancel.titleLabel.font;
        _buttonSave.backgroundColor = [UIColor colorWithHexString:@"#00a0e9"];
        [_buttonSave addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _buttonSave.tag = 101;
    }
    return _buttonSave;
}


- (void)buttonAction:(UIButton *)sender
{
    [self endEditing:YES];
    [self.delegate buttonAction:sender changePrice:self.stringChange lastPrice:self.stringLastPrice];
}

- (void)setStringLastPrice:(NSString *)stringLastPrice
{
    _stringLastPrice = stringLastPrice;
    _labelPrice.text = stringLastPrice;
}

- (void)setStringSetPrice:(NSString *)stringSetPrice
{
    _stringSetPrice = stringSetPrice;
    _textFieldLast.text = _stringSetPrice;
    _stringChange = stringSetPrice;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    self.stringChange = textField.text;
    return YES;
}
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    
//}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

@end
