//
//  GRAddBankCardView.m
//  GoldRush
//
//  Created by Jack on 2017/1/11.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRAddBankCardView.h"
#import "GRCountDownBtn.h"          ///验证码按钮
#import "GRTextField.h"
#import "GRJudgeBnakType.h"         ///判断银行卡类型


@interface GRAddBankCardView ()<UITextFieldDelegate>

@property (nonatomic, weak) GRTextField *bankCardFiled;         ///银行卡号
@property (nonatomic, weak) GRTextField *bankTypeFiled;         ///银行类型
@property (nonatomic, weak) GRTextField *nameFiled;             ///姓名
//@property (nonatomic, weak) GRTextField *phoneFiled;            ///手机号
//@property (nonatomic, weak) GRTextField *captchaFiled;          ///验证码
//@property (nonatomic, weak) GRCountDownBtn *getCaptchaBtn;      ///获取验证码按钮
@property (nonatomic, weak) UIButton *blindBtn;                 ///绑定按钮
//@property (nonatomic, assign) BOOL isTime;                      ///是否在获取验证码

@property (nonatomic, weak) GRTextField *provinceTextField;     ///开户省份
@property (nonatomic, weak) GRTextField *cityTextField;     ///开户城市
@property (nonatomic, weak) GRTextField *subBranchTextField;     ///开户支行

@end

@implementation GRAddBankCardView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //添加银行卡号输入框
        GRTextField *cardNum = [[GRTextField alloc] init];
        [self addSubview:cardNum];
        cardNum.borderStyle = UITextBorderStyleRoundedRect;
        cardNum.placeholder = @"请输入银行卡号";
        cardNum.tag = 100;
        self.bankCardFiled = cardNum;
        cardNum.keyboardType = UIKeyboardTypeNumberPad;
        cardNum.delegate = self;
        
        UILabel *bankNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        bankNum.textColor = [UIColor colorWithHexString:@"#333333"];
        bankNum.font = [UIFont systemFontOfSize:15];
        bankNum.textAlignment = NSTextAlignmentCenter;
        bankNum.text = @"银行卡号";
        bankNum.layer.borderColor = GRColor(224, 224, 224).CGColor;
        bankNum.layer.borderWidth = 1;
        cardNum.leftView = bankNum;
        cardNum.leftViewMode = UITextFieldViewModeAlways;
        bankNum.tag = 2341;
        
        //添加银行卡类型输入框
        GRTextField *cardType = [[GRTextField alloc] init];
        [self addSubview:cardType];
        cardType.tag = 101;
        cardType.enabled = NO;
        cardType.borderStyle = UITextBorderStyleRoundedRect;
        cardType.placeholder = @"请输入银行类型";
        self.bankTypeFiled = cardType;
        cardType.delegate = self;
        
        UILabel *bankType = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        bankType.textColor = [UIColor colorWithHexString:@"#333333"];
        bankType.font = [UIFont systemFontOfSize:15];
        bankType.textAlignment = NSTextAlignmentCenter;
        bankType.text = @"银行类型";
        bankType.layer.borderWidth = 1;
        bankType.layer.borderColor = GRColor(224, 224, 224).CGColor;
        cardType.leftView = bankType;
        cardType.leftViewMode = UITextFieldViewModeAlways;
        bankType.tag = 2342;
        
        //添加姓名输入框
        GRTextField *name = [[GRTextField alloc] init];
        [self addSubview:name];
        name.tag = 102;
        name.borderStyle = UITextBorderStyleRoundedRect;
        name.placeholder = @"请输入开户名";
        self.nameFiled = name;
        name.delegate = self;
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        nameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        nameLabel.font = [UIFont systemFontOfSize:15];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.text = @"开户名";
        nameLabel.layer.borderWidth = 1;
        nameLabel.layer.borderColor = GRColor(224, 224, 224).CGColor;
        name.leftView = nameLabel;
        name.leftViewMode = UITextFieldViewModeAlways;
        nameLabel.tag = 2343;
        
        ///添加省份
        GRTextField *province = [[GRTextField alloc] init];
        [self addSubview:province];
        province.tag = 103;
        province.borderStyle = UITextBorderStyleRoundedRect;
        province.placeholder = @"请输入开户省份";
        province.delegate = self;
        self.provinceTextField = province;
        
        UILabel *provinceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        provinceLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        provinceLabel.font = [UIFont systemFontOfSize:15];
        provinceLabel.textAlignment = NSTextAlignmentCenter;
        provinceLabel.text = @"开户省份";
        provinceLabel.layer.borderWidth = 1;
        provinceLabel.layer.borderColor = GRColor(224, 224, 224).CGColor;
        province.leftView = provinceLabel;
        province.leftViewMode = UITextFieldViewModeAlways;
        provinceLabel.tag = 2344;
        
        //添加城市
        GRTextField *city = [[GRTextField alloc] init];
        [self addSubview:city];
        city.tag = 104;
        city.borderStyle = UITextBorderStyleRoundedRect;
        city.placeholder = @"请输入开户城市";
        city.delegate = self;
        self.cityTextField = city;
        
        UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        cityLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        cityLabel.font = [UIFont systemFontOfSize:15];
        cityLabel.textAlignment = NSTextAlignmentCenter;
        cityLabel.text = @"开户城市";
        cityLabel.layer.borderWidth = 1;
        cityLabel.layer.borderColor = GRColor(224, 224, 224).CGColor;
        city.leftView = cityLabel;
        city.leftViewMode = UITextFieldViewModeAlways;
        cityLabel.tag = 2345;
        
        //添加支行
        GRTextField *subBranch = [[GRTextField alloc] init];
        [self addSubview:subBranch];
        subBranch.tag = 105;
        subBranch.borderStyle = UITextBorderStyleRoundedRect;
        subBranch.placeholder = @"请输入开户支行";
        subBranch.delegate = self;
        self.subBranchTextField = subBranch;
        
        UILabel *subBranchLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        subBranchLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        subBranchLabel.font = [UIFont systemFontOfSize:15];
        subBranchLabel.textAlignment = NSTextAlignmentCenter;
        subBranchLabel.text = @"开户支行";
        subBranchLabel.layer.borderWidth = 1;
        subBranchLabel.layer.borderColor = GRColor(224, 224, 224).CGColor;
        subBranch.leftView = subBranchLabel;
        subBranch.leftViewMode = UITextFieldViewModeAlways;
        subBranchLabel.tag = 2346;
        
        //绑定按钮
        UIButton *bindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [bindBtn setTitle:@"下一步" forState:UIControlStateNormal];
        bindBtn.backgroundColor = GRColor(224, 224, 224);
        bindBtn.enabled = NO;
        bindBtn.layer.masksToBounds = YES;
        bindBtn.layer.cornerRadius = 10;
        [bindBtn addTarget:self action:@selector(bindClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bindBtn];
        self.blindBtn = bindBtn;
        
        //约束
        [cardNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(13);
            make.top.equalTo(self).offset(25);
            make.right.equalTo(self).offset(-13);
            make.height.equalTo(@40);
        }];
        
        [cardType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(13);
            make.top.equalTo(cardNum.mas_bottom).offset(5);
            make.right.equalTo(self).offset(-13);
            make.height.equalTo(@40);
        }];
        
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(13);
            make.top.equalTo(cardType.mas_bottom).offset(5);
            make.right.equalTo(self).offset(-13);
            make.height.equalTo(@40);
        }];
        
        [province mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(13);
            make.top.equalTo(name.mas_bottom).offset(5);
            make.right.equalTo(self).offset(-13);
            make.height.equalTo(@40);
        }];
        
        [city mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(13);
            make.top.equalTo(province.mas_bottom).offset(5);
            make.right.equalTo(self).offset(-13);
            make.height.equalTo(@40);
        }];
        
        [subBranch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(13);
            make.top.equalTo(city.mas_bottom).offset(5);
            make.right.equalTo(self).offset(-13);
            make.height.equalTo(@40);
        }];
        
        [bindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(42);
            make.top.equalTo(subBranch.mas_bottom).offset(30);
            make.right.equalTo(self).offset(-42);
            make.height.equalTo(@44);
        }];
    }
    return self;
}

#pragma mark - private method
- (void)bindClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(gr_addBankCardView:didClickBindButton:)]) {
        [self.delegate gr_addBankCardView:self didClickBindButton:btn];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.bankCardFiled) {
        self.bankTypeFiled.text = [GRJudgeBnakType returnBankName:self.bankCardFiled.text];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(gr_addBankCardView:textFieldDidEndEditing:)]) {
        [self.delegate gr_addBankCardView:self textFieldDidEndEditing:textField];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (self.bankCardFiled.text.length == 0 ||
        self.bankTypeFiled.text.length == 0 ||
        self.nameFiled.text.length == 0 ||
        self.provinceTextField.text.length == 0 ||
        self.cityTextField.text.length == 0 ||
        self.subBranchTextField.text.length == 0) {
        self.blindBtn.enabled = NO;
    }else{
        self.blindBtn.enabled = YES;
    }
    //改变注册按钮的颜色
    [self changeRegisterButtonColor];
    return YES;
}

#pragma mark - GRTextFieldDelegate
- (BOOL)textField:(GRTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.bankCardFiled) {
        NSString *text = textField.text;
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        }
        text = [text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *newString = @"";
        while (text.length > 0) {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4) {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        // 限制长度
        if (newString.length >= 24) {
            return NO;
        }
        textField.text = newString;
        return NO;
    }else{
        return YES;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(gr_addBankCardView:textFieldShouldBeginEditing:)]) {
        [self.delegate gr_addBankCardView:self textFieldShouldBeginEditing:textField];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

- (void)setTextArray:(NSArray *)textArray{
    _textArray = textArray;
    for (int i; i < textArray.count; i ++) {
        UILabel *label = [self viewWithTag:2341 + i];
        label.text = textArray[i];
    }
}

#pragma mark - 改变注册按钮的颜色
- (void)changeRegisterButtonColor {
    if (self.blindBtn.enabled) {
        self.blindBtn.backgroundColor = mainColor;
    } else {
        self.blindBtn.backgroundColor = GRColor(224, 224, 224);
    }
}

- (void)setButtonTittle:(NSString *)buttonTittle{
    _buttonTittle = buttonTittle;
    [self.blindBtn setTitle:buttonTittle forState:UIControlStateNormal];
}

@end
